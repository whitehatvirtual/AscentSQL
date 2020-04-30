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
	declare @location_id int
			,@parent_id int
			--			SELECT	@location_id =	location_id
			--					,@parent_id = parent_id
					
			--FROM OPENJSON (@jsonVariable, N'$.frame.location_grid')
			--	WITH (
			--			location_id int N'$.location_id'
			--			,parent_id int N'$.parent_id'

			--	) AS component
								SELECT	
			--		,JSON_QUERY(location_id,'$.key') AS Languages
			--FROM OPENJSON (		(SELECT	value 
					@location_id = JSON_value(value,'$.location_id')
			FROM OPENJSON (@jsonVariable, N'$.frame')

if @location_id is null 
begin
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
	  ,'Edit' as action
  FROM [location] as l 
  left join type as t on l.type_id = t.type_id
  where t.[type_name] = 'module'
	
end
else
begin
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
	  ,'Edit' as action
  FROM [location] as l 
  left join type as t on l.type_id = t.type_id
  where parent_id = @location_id
end
  
END