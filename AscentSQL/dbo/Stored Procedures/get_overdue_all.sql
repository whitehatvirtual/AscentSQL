-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[get_overdue_all]
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
	select  [task_id]
		  ,t.[survey_id]
		  ,c.control_id_text as control_id
		  ,[task_name]
		  ,t.[description]
		  ,t.[type_id]
		  ,[client_id]
		  ,[dbo].[uf_get_user_fullname] ([user_id]) as control_owner
		  ,f.section_name as control_family
		  --,[survey_control_id]
		  --,[document_id]
		  --,[answer_id]
		  ,t.[calendar_date] as [date]
		  --,[is_active]
		  --,[created_on]
		  --,[updated_on]
		  --,[created_by]
		  --,[updated_by]
		  --,[audit_client_id]
	  FROM [task] as t 
	  left join survey_control as sc on t.survey_control_id = sc.survey_control_id
	  left join control as c on sc.control_id = c.control_id
	  cross apply [dbo].[uf_get_top_section] (
	  c.section_id) as f
	  where t.calendar_date < GETUTCDATE()
END