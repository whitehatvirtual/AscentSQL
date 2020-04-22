-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[uf_get_client_superuser] 
(
	-- Add the parameters for the function here
	@client_id int
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = (select top 1 user_id 
					  from user_client 
					  where client_id = @client_id
							and is_active =1
							and type_id = 54 -- super user type
					  order by user_client_id asc
					  )

	-- Return the result of the function
	RETURN @Result

END