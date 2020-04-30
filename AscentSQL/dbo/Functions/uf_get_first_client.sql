-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION uf_get_first_client 
(
	-- Add the parameters for the function here
	@user_id int
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @result int

	-- Add the T-SQL statements to compute the return value here
	
		select top 1 @result = client_id
		from 
		(
		SELECT 
			   [client_id]
			  ,[type_id]
			  ,user_id
		  FROM [user_client] 
		  where type_id = 54
				and user_id = @user_id
		union all 
		SELECT 
			   [client_id]
			  ,[type_id]
			  ,user_id
		  FROM [user_client] 
		  where user_id = @user_id
		 ) as uc

	-- Return the result of the function
	RETURN @result

END