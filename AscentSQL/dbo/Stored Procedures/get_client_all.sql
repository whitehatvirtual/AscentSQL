-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_client_all]
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
	SELECT c.[client_id]
		  ,[client_name] 
		  ,[email] as email_address
		  ,[time_zone]
		  ,isnull(a.street,'') + isnull(','+ a.city,'')  as client_address
		  ,a.state --+isnull(',' +a.country,'')
		  ,a.zip as zipcode
		  ,p.phone_no as phone_number
		  ,dbo.uf_get_status(c.[is_active]) as [status]
      
	FROM [client] as c
	left join address as a on c.address_id = a.address_id
	left join client_phone as cp on c.client_id = cp.client_id
	left join phone as p on cp.phone_id = p.phone_id and p.type_id = 6 -- mobile phone
END