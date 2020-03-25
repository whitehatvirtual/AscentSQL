-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE get_error
	-- Add the parameters for the stored procedure here
		 @jsonVariable NVARCHAR(MAX)
		,@audit_user_id int 
		,@audit_client_id int 
	 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	RAISERROR (N'This is message %s %d.', -- Message text.  
           16, -- Severity,  
           1, -- State,  
           @jsonVariable, -- First argument.  
           5); -- Second argument.
END