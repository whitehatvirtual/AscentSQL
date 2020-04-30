-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_task_by_id]
	-- Add the parameters for the stored procedure here
	     @jsonVariable NVARCHAR(MAX)
		,@audit_user_id int 
		,@audit_client_id int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @task_id int 
    -- Insert statements for procedure here
	--declare @control_id int

	--	if (select ISJSON(@jsonVariable) ) =0
	--	begin

	--	select 'input not JSON format!'
	--	return

	--	end

	--	else

	--	begin
	--		select  @control_id = control_id
	
	--		FROM OPENJSON (@jsonVariable, N'$')
	--		  WITH (
	--				   control_id  int  N'$.control.control_id' 

	--			) AS [control];
	set @jsonVariable = REPLACE(@jsonVariable, CHAR(13)+CHAR(10),'')
					SELECT	@task_id = task_id
					

					
			FROM OPENJSON (@jsonVariable, N'$.frame')
			with (
			task_id int N'$.id'
			
			
			)


			SELECT
				  --,t.[survey_id]
				  c.control_id_text
				  ,c.description
				  ,[user_id]
				  ,c.artifacts_example
				  ,c.remediation_requirements
				  ,t.[answer_id]
				  ,t.[calendar_date]

				  --,[task_name]
				  --,[description]
				  --,[type_id]
				  --,[client_id]

				  ,t.[survey_control_id]
				  ,t.[task_id]

			  FROM [task] as t 
			  join [survey_control] as sc on t.survey_control_id = sc.survey_control_id
			  join control as c on sc.control_id = c.control_id
			  where t.task_id = @task_id
	--	end
END