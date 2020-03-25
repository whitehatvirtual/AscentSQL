-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[get_control_all]
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

			SELECT  [control_id]
				  ,[control_id_text]
				  ,c.[description]
				  ,[artifacts_example]
				  ,[remediation_requirements]
				  ,[master_control_id]
				  ,s.section_name
				  ,f.frequency_name
				  ,r.risk_name
				  ,m.maturity_name
				  ,t.type_name
				  ,c.[is_active]
				  ,c.[created_on]
				  ,c.[updated_on]
				  ,c.[created_by]
				  ,c.[updated_by]
				  ,c.[audit_client_id]
			  FROM [control] as c 
			  left join section as s on c.section_id = s.section_id
			  left join frequency as f on c.frequency_id = f.frequency_id
			  left join risk as r on c.risk_id = r.risk_id
			  left join maturity as m on c.maturity_id = m.maturity_id
			  left join type as t on c.type_id = t.type_id
		end
END