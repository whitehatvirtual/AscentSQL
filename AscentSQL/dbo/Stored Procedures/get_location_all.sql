-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_location_all]
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
	if (select ISJSON(@jsonVariable) ) =0
	begin
		exec [error_rais] '{"error_id":1}',1 ,1
	end
	
	SELECT [location_id]
      ,[location_name]
      ,l.[description]
      ,t.[type_name] 
      ,[parent_id]
      ,[display_order]
      ,dbo.uf_get_status(l.[is_active]) as [status]
      ,l.[created_on]
      ,l.[updated_on]
      ,l.[created_by]
      ,l.[updated_by]
      ,l.[audit_client_id]
  FROM [location] as l 
  left join type as t on l.type_id = t.type_id
  
END