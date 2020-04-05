-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE get_location_all
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
      ,[description]
      ,[type_id]
      ,[parent_id]
      ,[display_order]
      ,[is_active]
      ,[created_on]
      ,[updated_on]
      ,[created_by]
      ,[updated_by]
      ,[audit_client_id]
  FROM [location] as l 
  
END