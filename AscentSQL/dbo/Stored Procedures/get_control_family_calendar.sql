-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[get_control_family_calendar] 
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

		
		   sc.[survey_id]
		  ,f.section_id_text+' '+ f.section_name as family_name
		  ,f.section_id_text
		  ,f.section_id
		  ,cast(section_id_text as int)
		  ,count(t.task_id) as task_count
		  --,f.*
	  FROM task as t join
	  [survey_control] as sc on t.survey_control_id = sc.survey_control_id
	  join control as c on sc.control_id = c.control_id
	  cross apply [dbo].[uf_get_top_section] (c.section_id) as f


	  where t.survey_id = 1
	  group by     sc.[survey_id]
		  ,f.section_name 
		  ,f.section_id_text
		  ,f.section_id
		  ,cast(section_id_text as int)
	 
	  order by cast(section_id_text as int)
   
END