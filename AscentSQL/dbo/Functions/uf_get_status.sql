-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION uf_get_status
(
	-- Add the parameters for the function here
	@is_active bit
)
RETURNS varchar(10)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @result varchar(10)

	-- Add the T-SQL statements to compute the return value here
	SELECT @result = case when @is_active = 0 then 'Inactive' else 'Active' end 

	-- Return the result of the function
	RETURN @result

END