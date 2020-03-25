-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE get_client_all
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
	SELECT [client_id]
		  ,[client_name]
		  ,[email]
		  ,[time_zone]
		  ,a.street
		  ,a.city
		  ,a.state
		  ,a.country
		  ,a.zip
		  ,c.[is_active]
      
	FROM [client] as c
	join address as a on c.address_id = a.address_id
END