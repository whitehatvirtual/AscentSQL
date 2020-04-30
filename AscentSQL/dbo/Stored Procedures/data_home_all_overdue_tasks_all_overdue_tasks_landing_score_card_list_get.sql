-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[data_home_all_overdue_tasks_all_overdue_tasks_landing_score_card_list_get] 
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
	SELECT 'Control in Place' as controls_in_place
		,count ([survey_control_id])	as controls_not_in_place
	
	  FROM [survey_control]
  
	 where answer_id is not null

	 union all
	 	SELECT 'Control not Place' as caption
		,count ([survey_control_id])	as [value]
	
	  FROM [survey_control]
  
	 where answer_id is not null

END