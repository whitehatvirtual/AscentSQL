-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[uf_get_cat_tool_all]
(
	@client_id int
	,@survey_id int
)
RETURNS 
	@result TABLE 
(
	-- Add the column definitions for the TABLE variable here
	domain_name nvarchar(255),
	section_id int,
	factor_name nvarchar(255),
	parent_section_id int,
	[survey_id] int,
	control_id int,
	maturity_id  int,
	last_updated datetime2(0) 
	

)


AS
BEGIN



	insert into @result
	SELECT f.section_name
		   ,f.section_id
		  ,se.section_name
		  ,se.parent_section_id
		  ,sc.[survey_id]
		  ,sc.[control_id]
	

		  --,c.maturity_id
		 -- ,m.maturity_name
	  
		  --,case when sc.answer_id  =1 then 1 else 0 end 
		  --,count(se.section_name) over (partition by sc.survey_id,f.section_name,se.section_name,c.maturity_id ) as countofa
		  --,sum(case when sc.answer_id  =1 then 1 else 0 end  ) over (partition by sc.survey_id,f.section_name,se.section_name,c.maturity_id ) as sumofa
		  --,max(c.maturity_id) over (partition by  sc.survey_id,f.section_name,se.section_name) 
		  ,case when count(se.section_name) over (partition by sc.survey_id,f.section_name,se.section_name,c.maturity_id )
					= sum(case when sc.answer_id  =1 then 1 else 0 end  ) over (partition by sc.survey_id,f.section_name,se.section_name,c.maturity_id ) 
				then max(c.maturity_id) over (partition by  sc.survey_id,f.section_name,se.section_name)
				else
					c.maturity_id - 1
				end as maturity_id
		   ,sc.updated_on

	  FROM [survey_control]  as sc
	  join survey as s on sc.survey_id = s.survey_id
	  join control as c on sc.control_id = c.control_id
	  join section as se on c.section_id = se.section_id
	  --join maturity as m on c.maturity_id = m.maturity_id
	  cross apply [dbo].[uf_get_top_section] (
	   c.section_id) as f
	  where s.type_id = 9 -- cat survey type
	  and s.client_id = @client_id
	  and sc.survey_id = @survey_id
	
	RETURN 
END