
CREATE PROCEDURE [dbo].[auth_get_user_info_by_username]  
  	     @jsonVariable NVARCHAR(MAX)
		,@audit_user_id int 
		,@audit_client_id int
AS 
   BEGIN

        SET  XACT_ABORT  ON

        SET  NOCOUNT  ON


        if (select ISJSON(@jsonVariable) ) =0
        begin

            select 'input not JSON format!'
            return

        end

        else

        begin

            DECLARE @email NVARCHAR(255)

            select  @email = [email]
            FROM OPENJSON (@jsonVariable, N'$')
            WITH (
                    email  NVARCHAR(255)  N'$.userName' 
                ) AS [user];

            SELECT 
                u.user_id, 
                u.first_name + ' ' +u.last_name as first_name, 
                '('+ud.client_name +')'as last_name, 
                p.password, 
                p.password_salt
				,ud.client_id
				,ud.client_name
            FROM [user] AS u 
            JOIN [password]  AS p ON u.user_id = p.user_id
			outer apply [dbo].[uf_get_first_client_details] (u.user_id) as ud
            WHERE u.email = @email
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER 
        end
   END
GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.auth_get_user_info_by_username', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'auth_get_user_info_by_username';

