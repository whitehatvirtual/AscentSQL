-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[add_update_control] 
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
	declare @control_id int

	if (select ISJSON(@jsonVariable) ) =0
	begin

	select 'input not JSON format!'
	return

	end

	else

	begin
		select  @control_id = control_id
	
		FROM OPENJSON (@jsonVariable, N'$')
		  WITH (
				   control_id  int  N'$.control.control_id' 

			) AS [control];

	   if @control_id > 0 
	   begin
			update t
			set control_id_text = s.control_id_text
				,description = s.description
				,artifacts_example = s.artifacts_example
				,remediation_requirements = s.remediation_requirements
				,master_control_id = s.master_control_id
				,section_id = s.section_id
				,frequency_id = s.frequency_id
				,risk_id = s.risk_id
				,maturity_id = s.maturity_id
				,type_id = s.type_id
				,updated_on = GETUTCDATE()
				,is_active = s.is_active
				,updated_by = s.audit_user_id
				,audit_client_id = s.audit_client_id
			from control as t
			join (
   					SELECT  control_id
							,control_id_text
							,description
							,artifacts_example 
							,remediation_requirements
							,master_control_id
							,section_id
							,frequency_id
							,risk_id
							,maturity_id
							,type_id
							,is_active
							,@audit_user_id  as audit_user_id 
							,@audit_client_id as audit_client_id 
					FROM OPENJSON (@jsonVariable, N'$')
					  WITH (
								control_id int N'$.control.control_id'
							   ,control_id_text nvarchar(255) N'$.control.control_id_text'
							   ,description nvarchar(max) N'$.control.description'
							   ,artifacts_example nvarchar(max) N'$.control.artifacts_example'
							   ,remediation_requirements nvarchar(max) N'$.control.remediation_requirements'
							   ,master_control_id int N'$.control.master_control_id'
							   ,section_id int N'$.control.section_id'
							   ,frequency_id int N'$.control.frequency_id'
							   ,risk_id int N'$.control.risk_id'
							   ,maturity_id int N'$.control.maturity_id'
							   ,type_id int N'$.control.type_id'
							   ,is_active bit  N'$.control.is_active'
						) AS j
				) as s on t.control_id = s.control_id

	   end
	   else
	   begin
	INSERT INTO [dbo].[control]
			   ([control_id_text]
			   ,[description]
			   ,[artifacts_example]
			   ,[remediation_requirements]
			   ,[master_control_id]
			   ,[section_id]
			   ,[frequency_id]
			   ,[risk_id]
			   ,[maturity_id]
			   ,[type_id]
			   ,[is_active]
			   ,[created_by]
			   ,[audit_client_id])

				SELECT		control_id_text
							,description
							,artifacts_example 
							,remediation_requirements
							,master_control_id
							,section_id
							,frequency_id
							,risk_id
							,maturity_id
							,type_id
							,is_active
							,@audit_user_id  as audit_user_id 
							,@audit_client_id as audit_client_id 
					FROM OPENJSON (@jsonVariable, N'$')
					  WITH (
								control_id int N'$.control.control_id'
							   ,control_id_text nvarchar(255) N'$.control.control_id_text'
							   ,description nvarchar(max) N'$.control.description'
							   ,artifacts_example nvarchar(max) N'$.control.artifacts_example'
							   ,remediation_requirements nvarchar(max) N'$.control.remediation_requirements'
							   ,master_control_id int N'$.control.master_control_id'
							   ,section_id int N'$.control.section_id'
							   ,frequency_id int N'$.control.frequency_id'
							   ,risk_id int N'$.control.risk_id'
							   ,maturity_id int N'$.control.maturity_id'
							   ,type_id int N'$.control.type_id'
							   ,is_active bit  N'$.control.is_active'
						) AS j
	   end

	end
END