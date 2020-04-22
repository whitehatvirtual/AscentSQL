
create PROCEDURE [dbo].[data_system_manage_db_audit_manage_db_audit_landing_manage_db_audit_grid_list_get] 
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
	EXECUTE  dbo.get_audit_table_all  
			   @jsonVariable
			  ,@audit_user_id
			  ,@audit_client_id


END