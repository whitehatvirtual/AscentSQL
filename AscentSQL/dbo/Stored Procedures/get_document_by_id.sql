-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[get_document_by_id]
	-- Add the parameters for the stored procedure here
		 @jsonVariable NVARCHAR(MAX)
		,@audit_user_id int 
		,@audit_client_id int 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare 	@document_id int

	if (select ISJSON(@jsonVariable) ) =0
	begin

	select 'input not JSON format!'
	return

	end

	else

	begin
	SELECT @document_id = document_id
			FROM OPENJSON (@jsonVariable, N'$')
			  WITH (
						document_id int N'$.document.document_id'
					   
				) AS document
    -- Insert statements for procedure here
	select   d.file_name
			,d.file_extension
			,d.file_size
			,d.file_name+'.'+file_extension as file_full_name
			,d.url 
	from document as d 
	where d.document_id = @document_id
	end
END