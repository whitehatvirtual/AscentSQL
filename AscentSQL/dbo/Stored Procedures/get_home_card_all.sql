-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_home_card_all] 
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
		SELECT 

			  'Control In Place' as card_label
			  ,count([survey_control_id]) as card_value

		  FROM [survey_control]
		  where survey_id  = 1 
				and (answer_id = 1 or answer_id = 3)
		union all

		SELECT 

			  'Control Not In Place' as label
			  ,count([survey_control_id]) as control_in_place

		  FROM [survey_control]
		  where survey_id  = 1 
				and (answer_id = 2 or answer_id is null )

		union all
		select  
			   'Overdue Controls' as label
				,count(t.task_id) 
			  FROM [task] as t 

			  where t.calendar_date <= GETUTCDATE() 
			  and t.survey_id = 1 and t.type_id = 17
		union all 
		select  
			   'Upcoming Controls (' + cast(year(GETUTCDATE()) as varchar(4) )+ ')'as label
				,count(t.task_id) 
			  FROM [task] as t 

			  where t.calendar_date > GETUTCDATE() 
			  and t.survey_id = 1 and t.type_id = 17


END