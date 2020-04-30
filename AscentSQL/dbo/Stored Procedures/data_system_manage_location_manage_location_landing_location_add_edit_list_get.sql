
	CREATE PROCEDURE [dbo].[data_system_manage_location_manage_location_landing_location_add_edit_list_get] 
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
		EXECUTE  get_location_by_id
				   @jsonVariable
				  ,@audit_user_id
				  ,@audit_client_id


	END