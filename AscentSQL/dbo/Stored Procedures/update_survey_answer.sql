-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[update_survey_answer] 
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
	set @jsonVariable = REPLACE(@jsonVariable, CHAR(13)+CHAR(10),'')
    -- Insert statements for procedure here
	if (select ISJSON(@jsonVariable) ) =0
	begin
		exec [error_rais] '{"error_id":1}',1 ,1
	end


declare  @sp_out table 
		(id int 
		 ,ActionTaken nvarchar(10)
		);  

	merge survey_control as target
	using (

					SELECT	survey_control_id
							,[answer_id]
							,[comment]
							,@audit_user_id  as audit_user_id 
						    ,@audit_client_id as audit_client_id 
		  -- ,	JSON_query(section_id,'$.frame.assessment_questionnaire_control_family') AS Languages
			 
					
			FROM OPENJSON (@jsonVariable, N'$.question_card')
			with (
			survey_control_id int N'$.survey_control_id'
			,[answer_id] int N'$.answer_id'
			,[comment] nvarchar(max) N'$.comment'
			
			)
			where [answer_id] is not null or [comment] is not null
		) as source
	on target.survey_control_id = source.survey_control_id
	WHEN MATCHED 
		then update set target.[answer_id] = source.[answer_id]
						,target.[comment] = source.[comment]
						,target.updated_by = source.audit_user_id
						,target.updated_on = GETUTCDATE()
						,target.audit_client_id = source.audit_client_id
	--WHEN NOT MATCHED BY TARGET 
	--	THEN insert ([location_name]
	--			   ,[description]
	--			   ,[type_id]
	--			   ,[parent_id]
	--			   ,[display_order]
	--			   ,[created_by]
	--			   ,[audit_client_id]
	--			   ) 
	--	values ( source.[location_name]
	--			,source.[description]
	--			,source.type_id
	--			,source.[parent_id]
	--			,source.[display_order]
	--			,source.audit_user_id
	--			,source.audit_client_id
	--			)
		output	 inserted.survey_control_id, $action INTO @sp_out
	 
	;
	select * from @sp_out
END