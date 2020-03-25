-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[add_update_document] 
	     @jsonVariable NVARCHAR(MAX)
		,@audit_user_id int 
		,@audit_client_id int 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set xact_abort ON;
    -- Insert statements for procedure here
	declare  @location_id int
			,@document_id int
			,@location_name varchar(255)
			,@file_name nvarchar(255) 
			,@file_extension  nvarchar(10) 
			,@file_size numeric(18,4)
			,@folder_id int
			,@user_id int
			,@client_id int
			,@url nvarchar(max)
			,@is_active bit
		
	exec validate_document @jsonVariable, @audit_user_id, @audit_client_id 

	--if (select ISJSON(@jsonVariable) ) =0
	--begin

	--SELECT * FROM [dbo].[uf_get_error] (1)
	--return

	--end

	--else

	--begin
		SELECT		 @document_id = document_id
											
		FROM OPENJSON (@jsonVariable, N'$')
				WITH (
						document_id int N'$.document.document_id'
						   
				) AS document
		if @document_id >0 
		begin

			SELECT		 @document_id = document_id
						,@location_name = location_name 
						,@file_name = file_name
						,@file_extension = file_extension
						,@file_size = file_size
						,@folder_id = folder_id 
						,@url = url
						,@user_id = @audit_user_id 
						,@client_id =@audit_client_id
						,@is_active = is_active
					
				FROM OPENJSON (@jsonVariable, N'$')
				  WITH (
							document_id int N'$.document.document_id'
						   ,location_name nvarchar(255) N'$.document.location_name'
						   ,file_name nvarchar(255) N'$.document.file_name'
						   ,file_extension nvarchar(10) N'$.document.file_extension'
						   ,file_size numeric(18,4) N'$.document.file_size'
						   ,folder_id int N'$.document.folder_id'
						   ,url nvarchar(max) N'$.document.url'
						   ,is_active bit N'$.document.is_active'
					) AS document

			select @location_id = location_id from location as l where l.location_name = @location_name

			if @folder_id is null or @folder_id = ''
			begin
					set @folder_id = (SELECT [folder_id]
 									  FROM [folder] as f 
									  join location as l on f.location_id = l.location_id
									  where l.location_name = @location_name
											and f.folder_name = 'root'
											and f.client_id = @client_id
								) -- gets the root folder
			end

			-- check for dublicate file on updte

			if (SELECT 
						 count(*)
				FROM [document] as d
				where (d.file_name = @file_name )
					and file_extension = @file_extension
					and  d.folder_id = @folder_id
					and d.document_id <> @document_id
			
			) >0

			-- send error 
			exec [error_rais] '{"error_id":4}',1 ,1
			-------------------------------------
			update d
				set d.file_name = di.file_name
					,d.is_active = di.is_active
					,d.updated_on = GETUTCDATE()
					,d.updated_by = di.audit_user_id
					,d.audit_client_id = di.audit_client_id
			from
			[document] as d 
			join (
			SELECT		 document_id
						,file_name
						,file_extension
						,@audit_user_id  as audit_user_id 
						,@audit_client_id as audit_client_id
						,is_active
					
				FROM OPENJSON (@jsonVariable, N'$')
				  WITH (
							document_id int N'$.document.document_id'
						   ,location_name nvarchar(255) N'$.document.location_name'
						   ,file_name nvarchar(255) N'$.document.file_name'
						   ,file_extension nvarchar(10) N'$.document.file_extension'
						   ,file_size numeric(18,4) N'$.document.file_size'
						   ,folder_id int N'$.document.folder_id'
						   ,url nvarchar(max) N'$.document.url'
						   ,is_active bit N'$.document.is_active'
					) AS document
				)
				as di on d.document_id = di.document_id 
		end 
		else
		begin
			
			SELECT		 @document_id = document_id
						,@location_name = location_name 
						,@file_name = file_name
						,@file_extension = file_extension
						,@file_size = file_size
						,@folder_id = folder_id 
						,@url = url
						,@user_id = @audit_user_id 
						,@client_id =@audit_client_id
						,@is_active = is_active
					
				FROM OPENJSON (@jsonVariable, N'$')
				  WITH (
							document_id int N'$.document.document_id'
						   ,location_name nvarchar(255) N'$.document.location_name'
						   ,file_name nvarchar(255) N'$.document.file_name'
						   ,file_extension nvarchar(10) N'$.document.file_extension'
						   ,file_size numeric(18,4) N'$.document.file_size'
						   ,folder_id int N'$.document.folder_id'
						   ,url nvarchar(max) N'$.document.url'
						   ,is_active bit N'$.document.is_active'
					) AS document

			select @location_id = location_id from location as l where l.location_name = @location_name

			if @folder_id is null or @folder_id = ''
			begin
					set @folder_id = (SELECT [folder_id]
 									  FROM [folder] as f 
									  join location as l on f.location_id = l.location_id
									  where l.location_name = @location_name
											and f.folder_name = 'root'
											and f.client_id = @client_id
								) -- gets the root folder
			end
			if @folder_id is null 
			begin
				INSERT INTO folder
					(
					[location_id]
					,[client_id]
					,[parent_id]
					,[folder_name]
					,[is_active]
					,[created_by]
					,[audit_client_id]
					)
				VALUES
					(
					@location_id
					,@client_id
					,null
					,'root'
					,1
					,@user_id
					,@client_id
					);
				set @folder_id = SCOPE_IDENTITY()
				insert into [document]
				  (
				   [location_id]
				  ,[folder_id]
				  ,[url]
				  ,[file_name]
				  ,file_extension
				  ,file_size
				  ,[is_active]
				  ,[created_by]
				  ,[audit_client_id]
				  )
				values
				  (
				   @location_id
				  ,@folder_id
				  ,@url
				  ,@file_name
				  ,@file_extension
				  ,@file_size
				  ,1
				  ,@user_id
				  ,@client_id
				  )
				set @document_id = SCOPE_IDENTITY()
			end
			else
			begin
					
				 insert into [document]
				  (
				   [location_id]
				  ,[folder_id]
				  ,[url]
				  ,[file_name]
				  ,file_extension
				  ,file_size
				  ,[is_active]
				  ,[created_by]
				  ,[audit_client_id]
				  )
				values
				  (
				   @location_id
				  ,@folder_id
				  ,@url
				  ,[dbo].[uf_set_document_file_name] (@folder_id,@file_name,@file_extension) -- adding numbers to the file name  
				  ,@file_extension
				  ,@file_size
				  ,1
				  ,@user_id
				  ,@client_id
				  )
				set @document_id = SCOPE_IDENTITY()
			end
	    end
	--end
	select @document_id as document_id
	
END