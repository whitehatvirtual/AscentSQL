-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_monthly_score]
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
		DECLARE @StartDate  DATETIME,
				@EndDate    DATETIME;

		SELECT   @StartDate = dateadd(m,-10,getutcdate()) 
				,@EndDate   = dateadd(m,+1,getutcdate())


		select left(m.month_name,3) as label
			   ,case when row_number() over (order by m.score_year asc , m.score_month asc) = 12 then mrs.score else isnull(mrs.score,-100) end as value
			   ,m.score_month
			   ,m.score_year
			   ,row_number() over (order by m.score_year asc , m.score_month asc) as m_order
			   , avg(mrs.score) over (partition by (select 1) ) as trendlines
			   , 'Average score('+ cast(format(avg(mrs.score) over (partition by (select 1) ),'00') as varchar(20)) + ')' as trendlines_displayvalue
			   ,'#29C3B9'  as trendlines_color
			   , '2' as trendlines_thickness
			   
		from 
		(
		SELECT  DATENAME(MONTH, DATEADD(MONTH, x.number, @StartDate)) AS month_name
				,month(DATEADD(MONTH, x.number, @StartDate)) as score_month
				,year(DATEADD(MONTH, x.number, @StartDate)) as score_year
				
		FROM    master.dbo.spt_values x
		WHERE   x.type = 'P'        
		AND     x.number <= DATEDIFF(MONTH, @StartDate, @EndDate)
		) as m 
		left join monthly_risk_score as mrs on m.score_month = mrs.score_month and m.score_year = mrs.score_year
		order by m.score_year asc , m.score_month asc
	end
END