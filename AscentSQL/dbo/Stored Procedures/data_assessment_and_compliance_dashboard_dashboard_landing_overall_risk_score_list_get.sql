-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[data_assessment_and_compliance_dashboard_dashboard_landing_overall_risk_score_list_get] 
	-- Add the parameters for the stored procedure here
		 @jsonVariable NVARCHAR(MAX)
		,@audit_user_id int 
		,@audit_client_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--	[{
--   "label": "Venezuela", 
--  "value": "290",
-- "color": "#FF00EE"
--}]

    -- Insert statements for procedure here
		EXECUTE  [dbo].[get_control_status]  
			   @jsonVariable
			  ,@audit_user_id
			  ,@audit_client_id

	



END