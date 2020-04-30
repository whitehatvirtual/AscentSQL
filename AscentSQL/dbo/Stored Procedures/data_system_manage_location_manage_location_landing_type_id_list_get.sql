
	CREATE PROCEDURE [dbo].[data_system_manage_location_manage_location_landing_type_id_list_get] 
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
		SELECT  [type_id] as value
			  ,[type_name] as text
      
		  FROM [type]
		  where type_header_id = 2


	END