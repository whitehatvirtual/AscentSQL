-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE get_release_by_id
	-- Add the parameters for the stored procedure here
	     @jsonVariable NVARCHAR(MAX)
		,@audit_user_id int 
		,@audit_client_id int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @release_id int

	if (select ISJSON(@jsonVariable) ) =0
	begin

	select 'input not JSON format!'
	return

	end

	else

	begin
		select  @release_id = release_id
	
		FROM OPENJSON (@jsonVariable, N'$')
		  WITH (
				   release_id  int  N'$.release.release_id' 

			) AS [release];


			SELECT  [release_id]
				  ,[version_number]
				  ,[description]
				  ,[is_active]
				  ,[created_on]
				  ,[updated_on]
				  ,[created_by]
				  ,[updated_by]
				  ,[audit_client_id]
			  FROM [release]
			  where release_id = @release_id
	end
END