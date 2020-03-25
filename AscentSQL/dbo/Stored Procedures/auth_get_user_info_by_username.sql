
CREATE PROCEDURE [dbo].[auth_get_user_info_by_username]  
   @email nvarchar(max)
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT 
         1 AS user_id, 
         N'surya' AS first_name, 
         N'pratap' AS last_name, 
         N'4221295378' AS password, 
         N'fadsfsdafdsafasdfasdfadsfdsfasdqwvevwetwretbrw' AS password_salt

      SELECT 
         u.user_id, 
         u.first_name, 
         u.last_name, 
         p.password, 
         p.password_salt
      FROM [user] AS u 
      JOIN [password]  AS p 
            ON u.user_id = p.user_id
      WHERE u.email = @email
 



   END
GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.auth_get_user_info_by_username', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'auth_get_user_info_by_username';

