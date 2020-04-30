-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_survey_section_control_all]
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
	--declare @control_id int
	declare @section_id int
		if (select ISJSON(@jsonVariable) ) =0
		begin

		select 'input not JSON format!'
		return

		end

		else

		begin

						SELECT	@section_id = section_id
		  -- ,	JSON_query(section_id,'$.frame.assessment_questionnaire_control_family') AS Languages
			 
					
			FROM OPENJSON (@jsonVariable, N'$.frame.assessment_questionnaire_control_family')
			with (
			section_id int N'$.section_id'
			
			)

		SELECT  [survey_control_id]
			  --,sc.[survey_id]
			  --,sc.[control_id]
			  --,c.control_id_text
			  ,c.control_id_text +' '+c.description as description
			  --,c.artifacts_example
			  --,c.remediation_requirements
			  ,[answer_id]
			  ,[comment]
			  --,[document_id]
			  --,[calendar_date]
			  ,'Notes' as notes_edit
			  ,'Timeline' as timeline
			  ,'Remediation Requirements' as remediation_req
			  ,'Documents' as documents_edit
			  --,[is_active]
			  --,[created_on]
			  --,[updated_on]
			  --,[created_by]
			  --,[updated_by]
			  --,[audit_client_id]
	  
		  FROM [survey_control] as sc
		  join control as c on sc.control_id = c.control_id
		  join survey as s on sc.survey_id = s.survey_id
		  cross apply [dbo].[uf_get_top_section] (c.section_id) as f
   
		  where f.section_id = @section_id
			and s.client_id = @audit_client_id
			and s.type_id = 8 -- control survey 
			-- and sc.survey_id = @survey_id -- active survey

		end
END