-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[get_control_by_id]
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
			SELECT  [control_id]
				  ,[control_id_text]
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
				  ,[created_on]
				  ,[updated_on]
				  ,[created_by]
				  ,[updated_by]
				  ,[audit_client_id]
			  FROM [control]
			  where control_id = @control_id
		end
END