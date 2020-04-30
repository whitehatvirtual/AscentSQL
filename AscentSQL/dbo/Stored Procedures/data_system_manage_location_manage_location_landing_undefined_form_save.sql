-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[data_system_manage_location_manage_location_landing_undefined_form_save] 
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
	EXECUTE  [dbo].[add_update_location]  
			   @jsonVariable
			  ,@audit_user_id
			  ,@audit_client_id


END