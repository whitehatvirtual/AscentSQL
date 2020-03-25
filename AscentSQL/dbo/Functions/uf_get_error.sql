-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[uf_get_error]
(	
	-- Add the parameters for the function here
	@error_id int 
	
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	select error_id, error_no, description
	from error
	where error_id = @error_id
)