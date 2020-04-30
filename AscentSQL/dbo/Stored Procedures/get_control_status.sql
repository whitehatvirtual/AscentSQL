-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_control_status]
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
	declare @parent_section_id int

	if (select ISJSON(@jsonVariable) ) =0
	begin

	select 'input not JSON format!'
	return

	end

	else

	begin
		 -- SELECT  

     
		 -- 'Operating Effectively' as label
		 -- ,'#134074' as color
		 -- ,       count(sc.[control_id]) as value
		 -- --,[is_active]
		 -- --,[created_on]
		 -- --,[updated_on]
		 -- --,[created_by]
		 -- --,[updated_by]
		 -- --,[audit_client_id]
	  --FROM [survey_control] as sc
	  --join control as c on sc.control_id =c.control_id
	  --join risk as r on c.risk_id = r.risk_id

	  --where sc.is_active = 1 
	  --and sc.answer_id = 1
	  --union all
	  --group by 	  r.risk_name
		 -- ,r.color
			SELECT  

     
			  r.risk_name as label
			  ,r.color
			  ,       count(sc.[control_id]) as value 
			  ,'0' as showLabel
			  --,[is_active]
			  --,[created_on]
			  --,[updated_on]
			  --,[created_by]
			  --,[updated_by]
			  --,[audit_client_id]
		  FROM [survey_control] as sc
		  join control as c on sc.control_id =c.control_id
		  join risk as r on c.risk_id = r.risk_id

		  where sc.is_active = 1 
		  group by 	  r.risk_name
			  ,r.color

		union all
				  SELECT  

     
		  'N/A' as label
		  ,'#4E555C' as color
		  ,       count(sc.[control_id]) as value
		  ,'0' as showLabel
		  --,[is_active]
		  --,[created_on]
		  --,[updated_on]
		  --,[created_by]
		  --,[updated_by]
		  --,[audit_client_id]
	  FROM [survey_control] as sc
	  join control as c on sc.control_id =c.control_id
	  join risk as r on c.risk_id = r.risk_id

	  where sc.is_active = 1 
	  and sc.answer_id = 3

	end
END