-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_maturity_score]
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
		select c.section_name as label
			   ,isnull(m.maturity_id,0) as value
			   ,isnull(m.maturity_name,'Not Complete') as displayValue
			   ,isnull(m.color,'#A1A1A1') as color
			   --, 1 as showLabel
			   , 1 as showValue

			 from
		(

		SELECT 
			   f.section_id
			  ,f.section_name 
			  ,cast(f.section_id_text as int) as rno
		  from control as c
		  join [survey_control] as sc on c.control_id = sc.control_id
		  cross apply [dbo].[uf_get_top_section] (c.section_id) as f
		  where sc.survey_id = 1
		  group by 	f.section_id
					,f.section_name
					,cast(f.section_id_text as int)

		  ) as c 
		  left join 

		  (
		  SELECT 
				f.section_id
			   ,f.section_name 
			   ,min(c.maturity_id) as maturity_id
			--  ,(sum(r.score*0.5 ) /sum(isnull(a.factor,-1) * r.score*0.5))*100 as value

	 
		from  [survey_control] as sc
		join control as c on sc.control_id = c.control_id
		join answer as a on sc.answer_id = a.answer_id

		cross apply [dbo].[uf_get_top_section] (c.section_id) as f
		  where sc.survey_id = 1
		  group by 
					 f.section_id
					,f.section_name
		  ) as sc on c.section_id = sc.section_id
		left join maturity as m on sc.maturity_id = m.maturity_id
		order by rno
	end
END