-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION uf_get_user_fullname
(
	-- Add the parameters for the function here
	@user_id int
)
RETURNS nvarchar(255)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result nvarchar(255)

	-- Add the T-SQL statements to compute the return value here
	set	@Result = (	  SELECT  [first_name] +' '+[last_name]
					  FROM [user] as u
					  where  u.user_id = @user_id
					)

	-- Return the result of the function
	RETURN @Result

END