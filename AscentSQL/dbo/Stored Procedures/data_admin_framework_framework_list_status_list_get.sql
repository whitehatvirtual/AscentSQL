
	CREATE PROCEDURE [dbo].[data_admin_framework_framework_list_status_list_get] 
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
		SELECT  1 as value
			  , 'Active' as text
      union all
	  		SELECT  0 as value
			  , 'Inactive' as text
		  


	END