-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_document_all]
		 @jsonVariable NVARCHAR(MAX)
		,@audit_user_id int 
		,@audit_client_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare  @Location_name varchar(255)
			, @PrentFolderID int
			, @User_ID int
			, @Client_ID int


	if (select ISJSON(@jsonVariable) ) =0
	begin

		select 'input not JSON format!'
		return

	end

	else

	begin

		SELECT @location_name = location_name 
				,@PrentFolderID  = folder_id 
				,@user_id = @audit_user_id 
				,@client_id =@audit_client_id
		FROM OPENJSON (@jsonVariable, N'$')
			WITH (
					location_name nvarchar(255) N'$.document.location_name'
					,folder_id int N'$.document.folder_id'

			) AS document

		if @PrentFolderID is null or @PrentFolderID = '' 
		begin
		set @PrentFolderID = (SELECT [folder_id]
 							  FROM [folder] as f 
							  join location as l on f.location_id = l.location_id
							  where l.location_name = @location_name
									and f.client_id = @Client_ID
									and f.folder_name = 'root'
						) -- gets the root folder
						
 
		end

		SELECT f.folder_id as ID
			 ,f.folder_name as [name]
			 ,f.created_on as created_on
			 ,dbo.uf_get_user_fullname(f.created_by) as updated_by
			 ,'' as url
			 ,dbo.uf_get_icon('folder') as Icon
			 ,'D' as FileFolder -- F = file, D =folder
		FROM folder as f

		where f.client_id = @Client_ID and f.parent_id  = @PrentFolderID
		and f.is_active = 1
		union all
		SELECT  d.document_id as ID
				,d.file_name
				 ,d.created_on
				 ,dbo.uf_get_user_fullname(f.created_by) as updated_by
				,d.url
				,dbo.uf_get_icon('file') as Icon
				,'F' as FileFolder 
		FROM folder as f
		--join ref_doc_type as u on f.doc_type_id  = u.doc_type_id
		join document as d on f.folder_id = d.folder_id
		where f.client_id = @Client_ID and f.folder_id = @PrentFolderID
		and f.is_active = 1 and d.is_active = 1
	end
END