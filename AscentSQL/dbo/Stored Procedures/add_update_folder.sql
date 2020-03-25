-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[add_update_folder] 
	-- Add the parameters for the stored procedure here
		 @jsonVariable NVARCHAR(MAX)
		,@audit_user_id int 
		,@audit_client_id int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
    -- Insert statements for procedure here
	declare @location_id int
			,@location_name varchar(255)
			,@folder_name varchar(255) 
			,@parent_folder_id int 
			,@user_id int
			,@client_id int
			,@folder_id int
	if (select ISJSON(@jsonVariable) ) =0
	begin
	exec get_error 'abc',1,1
	--SELECT * FROM [dbo].[uf_get_error] (1)
	--return
	select 1
	end

	else

	begin

		SELECT 
				@location_name = location_name 
				,@folder_name = folder_name
				,@parent_folder_id = parent_folder_id
				,@user_id = @audit_user_id 
				,@client_id =@audit_client_id
				,@folder_id = folder_id
		FROM OPENJSON (@jsonVariable, N'$')
			WITH (
					location_name nvarchar(255) N'$.folder.location_name'
					,folder_name nvarchar(255) N'$.folder.folder_name'
					,parent_folder_id int N'$.folder.parent_folder_id'
					,folder_id int N'$.folder.folder_id'
					,is_active bit N'$.folder.is_active'

			) AS folder

		select @location_id = location_id from location as l where l.location_name = @location_name

		if @folder_id >0
		begin
			if (SELECT [dbo].[uf_check_dublicate_folder_name] (
							   @location_id
							  ,@folder_name
							  ,@parent_folder_id
							  ,@client_id
							  ,@folder_id
							)) = 1
			begin
				SELECT * FROM [dbo].[uf_get_error] (2)
				return
			end
		
			update f
				set f.folder_name = fi.folder_name
					,f.is_active = fi.is_active
					,f.updated_on = GETUTCDATE()
					,f.updated_by = audit_user_id
					,f.audit_client_id = fi.audit_client_id
			from folder as f
			join (
					SELECT 
						 folder_id 
						,folder_name
						,parent_folder_id
						,is_active
						,@audit_user_id as audit_user_id 
						,@audit_client_id as audit_client_id
					
					FROM OPENJSON (@jsonVariable, N'$')
					WITH (
							location_name nvarchar(255) N'$.folder.location_name'
							,folder_name nvarchar(255) N'$.folder.folder_name'
							,parent_folder_id int N'$.folder.parent_folder_id'
							,folder_id int N'$.folder.folder_id'
							,is_active bit N'$.folder.is_active'

					) AS folder
				) as fi on f.folder_id = fi.folder_id
				-- TO DO on is_active = 0 chnage is_active on all files and subfolders

		end 
		else
		begin


			if (SELECT [dbo].[uf_check_dublicate_folder_name] (
							   @location_id
							  ,@folder_name
							  ,@parent_folder_id
							  ,@client_id
							  ,null
							)) = 1
			begin
				SELECT * FROM [dbo].[uf_get_error] (3)
				return
			end


			if @parent_folder_id is null or @parent_folder_id = 0 
			begin
			set @parent_folder_id = (SELECT [folder_id]
 								  FROM [folder] as f 
								   where f.location_id = @location_id
										and f.folder_name = 'root'
										and f.client_id = @client_id
							) -- gets the root folder

				if @parent_folder_id is null 
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
				set @parent_folder_id = SCOPE_IDENTITY()
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
						,@parent_folder_id
						,@folder_name
						,1
						,@user_id
						,@client_id
						);
				end
				else
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
						,@parent_folder_id
						,@folder_name
						,1
						,@user_id
						,@client_id
						);
				end
			end
			else
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
					,@parent_folder_id
					,@folder_name
					,1
					,@user_id
					,@client_id
					);
			end
		end
	end
END