-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE get_survey_answer_all 
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
		SELECT 
		  a.answer_id as value
		  ,a.answer_name as text
      
	  FROM  [survey_answer] as sa
	  join answer as a on sa.answer_id = a.answer_id
	  where survey_id = 1
END