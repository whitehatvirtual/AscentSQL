-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_user_all]
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
	SELECT  [user_id]
		  ,[first_name] as user_first_name
		  ,[last_name] as user_last_name
		  ,[email]
		  ,[job_title]
		  ,[time_zone]
		  ,p.phone_no as phone_number
		  ,t.type_name as user_type
		  ,[address_id]
		  ,dbo.uf_get_status(u.[is_active]) as [status]
		  ,u.[created_on] 
		  ,u.[updated_on]
		  ,u.[created_by]
		  ,u.[updated_by]
		  ,u.[audit_client_id]
	  FROM [user] as u
	  join type as t on u.type_id = t.type_id
	  left join phone as p on u.phone_id = p.phone_id
END