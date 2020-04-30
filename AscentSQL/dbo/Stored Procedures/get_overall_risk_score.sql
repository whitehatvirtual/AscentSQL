-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_overall_risk_score]
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
		--"colorRange": {
  --      "color": [{
  --        "minValue": "0",
  --        "maxValue": "50",
  --        "code": "#e44a00"
  --      }, {
  --        "minValue": "50",
  --        "maxValue": "75",
  --        "code": "#f8bd19"
  --      }, {
  --        "minValue": "75",
  --        "maxValue": "100",
  --        "code": "#6baa01"
  --      }]
  --    },
  --    "dials": {
  --      "dial": [{
  --        "value": "67"
  --      }]
  --    }
  --  }

	SELECT  
      [minValue]
      ,[maxValue]
      ,[code]
	  ,v.value
  FROM [gauge],
    (

  

		SELECT 
      
			  
			  
			  (sum(isnull(a.factor,-1) * r.score*0.5)/sum(r.score*0.5 ))*100 as value

	 

		  from control as c
		  join risk as r on c.risk_id = r.risk_id
		  join [survey_control] as sc on c.control_id = sc.control_id
		  left join answer as a on sc.answer_id = a.answer_id
		  cross apply [dbo].[uf_get_top_section] (c.section_id) as f
		   
   ) as v

END