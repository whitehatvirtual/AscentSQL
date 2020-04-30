-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_control_family_progress] 
	-- Add the parameters for the stored procedure here
		 @jsonVariable NVARCHAR(MAX)
		,@audit_user_id int 
		,@audit_client_id int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT 
		  f.section_name
		  ,f.section_id
		  ,(sum(cast(case when answer_id is not null then 1 else 0 end as numeric(10,2))) / cast(COUNT(sc.control_id) as numeric(10,2))) * 100 as family_progress
		  ,sum(case when answer_id is not null then 1 else 0 end) 
		  --, 50 as family_progress
		  ,max(sc.[updated_on]) as last_updated
		  ,cast(f.section_id_text as int) as rno
	  
	  FROM [survey_control] as sc
	  join control as c on sc.control_id = c.control_id
	   cross apply [dbo].[uf_get_top_section] (c.section_id) as f
	   where sc.survey_id = 1
   			  group by f.section_name
					  ,f.section_id
						,cast(f.section_id_text as int)
						order by rno
   
END