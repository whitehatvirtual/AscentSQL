CREATE PROCEDURE [dbo].[data_admin_framework_framework_list_framework_list_list_get]
         @jsonVariable NVARCHAR(MAX)
	,    @audit_user_id int 
	,    @audit_client_id int
AS 
    BEGIN

    SET  XACT_ABORT  ON
    SET  NOCOUNT  ON
    EXEC [dbo].[get_framework_all] @jsonVariable  ,@audit_user_id  ,@audit_client_id

    END