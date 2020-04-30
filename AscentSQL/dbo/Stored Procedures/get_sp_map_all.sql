-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_sp_map_all]
	-- Add the parameters for the stored procedure here
	     @jsonVariable NVARCHAR(MAX)
		,@audit_user_id int 
		,@audit_client_id int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [sp_map_id]
			  ,[call_sp_name]
			  ,[read_sp_name]
			  ,[write_sp_name]
			  ,[location_id]
	FROM [Ascent].[dbo].[sp_map]
	for JSON auto



	

END