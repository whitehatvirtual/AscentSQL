CREATE PROCEDURE [dbo].[data_admin_manage_controls_control_list_control_list_list_get]
         @jsonVariable NVARCHAR(MAX)
	,    @audit_user_id int 
	,    @audit_client_id int
AS 
    BEGIN

    SET  XACT_ABORT  ON
    SET  NOCOUNT  ON
    
    EXEC [dbo].[get_control_all] @jsonVariable, @audit_user_id, @audit_client_id

    END