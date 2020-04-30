-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_family_score]
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
		select	
				label
				,value
				,case when value <= 0  then '#c0392b'
					  when value > 0  AND value <= 39 then '#c0392b'
					  when value > 39 AND value <= 74 then '#f1c40f'
					  else '#009432' 
				 end color 
				 , 1 as showValue
		from
		(

		SELECT 
      
			   f.section_name as label
			   ,cast(f.section_id_text as int) as rno
			  ,(sum(isnull(a.factor,-1) * r.score*0.5)/sum(r.score*0.5 ) )*100 as value

	 

		  from control as c
		  join risk as r on c.risk_id = r.risk_id
		  join [survey_control] as sc on c.control_id = sc.control_id
		  left join answer as a on sc.answer_id = a.answer_id
		  cross apply [dbo].[uf_get_top_section] (c.section_id) as f
		  where sc.survey_id = 1
		  group by f.section_name
					,cast(f.section_id_text as int) 
   
		) as s
		order by rno
	end
END