
	create PROCEDURE [dbo].[data_assessment_and_compliance_assessment_questionnaire_assessment_questionnaire_landing_question_card_list_get] 
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
		EXECUTE  get_survey_section_control_all  
				   @jsonVariable
				  ,@audit_user_id
				  ,@audit_client_id


	END