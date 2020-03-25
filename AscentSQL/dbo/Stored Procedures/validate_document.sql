-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[validate_document] 
	-- Add the parameters for the stored procedure here
	     @jsonVariable NVARCHAR(MAX)
		,@audit_user_id int 
		,@audit_client_id int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set xact_abort on;
    -- Insert statements for procedure here
	declare  
			 @refVariable NVARCHAR(MAX)
			,@errorJSON NVARCHAR(MAX)

	declare @error_table table ( 
								error_id int
								)
	set @refVariable = '
			  {
			"document": {  
			  "document_id":"7",
			  "location_name":"security_whitepaper",  
			  "file_name":"file_name1_updated" ,
			  "file_extension":"doc",
			  "file_size":"10",
			  "folder_id":"",
			  "url":"url",
			  "is_active":"1"
			}
		  }
		'
	
	if (select ISJSON(@jsonVariable) ) =0
	begin

		insert into @error_table (error_id) values(1) 
		select @errorJSON = (select * from @error_table for json auto)
		
		exec [error_rais] @errorJSON,@audit_user_id ,@audit_client_id

	end 
	else


	begin
		----------------------------------

		insert into @error_table
		SELECT	distinct	4 as error_id

		from OPENJSON (@refVariable, N'$.document') as r
		left join OPENJSON (@jsonVariable, N'$.document') as j on r.[key] = j.[key]
		where j.[key] is null

		----------------------------------
 
		select @errorJSON = (select * 
		from @error_table for json auto)

		if (select count(*) from @error_table) > 0
		exec [error_rais] @errorJSON,@audit_user_id ,@audit_client_id
	end
END