-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_calendar_all] 
	-- Add the parameters for the stored procedure here
		 @jsonVariable NVARCHAR(MAX)
		,@audit_user_id int 
		,@audit_client_id int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

 --   -- Insert statements for procedure here
	--if (select ISJSON(@jsonVariable) ) =0
	--begin
	--	exec [error_rais] '{"error_id":1}',1 ,1
	--end
	--declare @component_id int


	--				SELECT	@component_id =	 component_id 
					
	--		FROM OPENJSON (@jsonVariable, N'$')
	--			WITH (
	--					component_id int N'$.component.component_id'
	--					,component_name nvarchar(255) N'$.component.component_name'
	--					,description nvarchar(max) N'$.component.description'
	--					,location_id int N'$.component.location_id'
				
	--					,type_id int N'$.component.type_id'
						
	--					,is_active bit  N'$.component.is_active'
	--			) AS component


	--{
 --     "title": "event 1",
 --     "date": "2020-04-01",
 --     "textColor": "black",
 --     "backgroundColor": "red",
 --     "popupUrl": "admin/framework/framework_list",
 --     "id": "event_1"
 --   }

 select t.id
	 -- ,t.date
	  ,format(t.date,'yyyy-MM-dd') as [date]
	  ,t.title
	  ,t.type_id
	  ,t.popupUrl
	  ,t.survey_id
	  ,t.status_id
	  ,tc.textColor
	  ,tc.backgroundColor
from (
SELECT  [task_id] as id
      ,t.[survey_id]
      ,case when t.[type_id] = 17 then c.control_id_text
			when t.[type_id] = 18 then [task_name]
			end as title

	  ,case when t.[type_id] = 17 then 'assessment_and_compliance/security_compliance_calendar/security_compliance_calendar_control_task/security_compliance_calendar_control_task_detail'
			when t.[type_id] = 18 then 'assessment_and_compliance/security_compliance_calendar/security_compliance_calendar_user_task/security_compliance_calendar_user_task_detail'
			end as popupUrl
      ,t.[type_id]
      ,t.[calendar_date] as date
	  ,case when isnull(a.factor,-1) = -1 and t.[calendar_date] <= getutcdate() then 0 -- overdue
			when isnull(a.factor,-1) = 1 then 1 -- caomplete
			when isnull(a.factor,-1) = -1 then 2-- not complete
		  end as status_id
  FROM [task] as t
   left join answer as a on t.answer_id = a.answer_id --and a.type_id = 16 -- task answer type
  left join survey_control as sc on t.survey_control_id = sc.survey_control_id
  left join control as c on sc.control_id = c.control_id
  where t.survey_id = 1

  ) as t
left join task_color as tc on t.type_id = tc.type_id and t.status_id = tc.status_id
--where title = '2.031'

--SELECT  [task_id] as id
--      ,[survey_id]
--      ,[task_name] as title
--      ,[description]
--      ,[type_id]
--      ,[client_id]
--      ,[user_id]
--      ,[survey_control_id]
--      ,[document_id]
--      ,[answer_id]
--      ,format([calendar_date],'yyyy-MM-dd') as [date]
--      ,[is_active]
--      ,[created_on]
--      ,[updated_on]
--      ,[created_by]
--      ,[updated_by]
--      ,[audit_client_id]
--	  ,'black' as textColor
--	  ,'red'as backgroundColor
--	  ,'admin/framework/framework_list' as  popupUrl

--  FROM [task] as t
--  where t.survey_id = 1
   
END