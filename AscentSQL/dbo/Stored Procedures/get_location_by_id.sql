-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_location_by_id]
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
	declare @location_id int
 

	SELECT		@location_id =  location_id 
						
	FROM OPENJSON (@jsonVariable, N'$.frame.location_grid')
		WITH (
				location_id int N'$.location_id'
				--,location_name nvarchar(255) N'$.location.location_name'
				--,description nvarchar(max) N'$.location.description'
				--,parent_id int N'$.location.parent_id'
				
				--,type_id int N'$.location.type_id'
				--,display_order int N'$.location.display_order'
				--,is_active bit  N'$.location.is_active'
		) AS location

	SELECT [location_id]
      ,[location_name]
      ,[description]
      ,[type_id]
      ,[parent_id]
      ,[display_order]
      ,is_active 
      ,[created_on]
      ,[updated_on]
      ,[created_by]
      ,[updated_by]
      ,[audit_client_id]
  FROM [location] as l 
  where l.location_id = @location_id
END