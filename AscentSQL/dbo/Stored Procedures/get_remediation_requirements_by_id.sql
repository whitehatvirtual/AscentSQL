-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_remediation_requirements_by_id]
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

		--if (select ISJSON(@jsonVariable) ) =0
		--begin

		--select 'input not JSON format!'
		--return

		--end

		--else

		--begin
			select  @control_id = control_id
	
			FROM OPENJSON (@jsonVariable, N'$.frame.question_card')
			  WITH (
					   control_id  int  N'$.control_id' 

				) AS [control];
			SELECT  --[control_id]
      
				 --cast(isnull(@control_id,'') as varchar(20)) + ' ' + [remediation_requirements] as [remediation_requirements]
				 [remediation_requirements]
      
			  FROM  [control] 
			  where control_id = @control_id
		--end
END