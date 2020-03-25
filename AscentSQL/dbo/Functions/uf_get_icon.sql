-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION uf_get_icon 
(
	-- Add the parameters for the function here
	@icon_name varchar(100)
)
RETURNS varchar(100)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @result varchar(100)

	-- Add the T-SQL statements to compute the return value here
	SELECT @result = (select ui_icon_name from icon where icon_name = @icon_name)

	-- Return the result of the function
	RETURN @result

END