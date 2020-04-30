-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_cat_tool_all]
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
		declare @survey_id int =2

		set @audit_client_id =1 

		--if (select ISJSON(@jsonVariable) ) =0
		--begin

		--select 'input not JSON format!'
		--return

		--end

		--else

		--begin

				select 
				  cat.domain_name
				  ,cat.maturity_id
				  ,m.maturity
				  ,cat.last_updated
				  ,cat.f_order
				from
				(
				select	
						 d.section_id
		 
						,d.domain_name
						,d.f_order
						,min(maturity_id ) as maturity_id
						,max(d.last_updated) as last_updated
				from
				(

				SELECT  --f.domain_name
		 
						f.section_id
						,f.domain_name
						,f.parent_section_id
						, f.factor_name
						,0 as f_order
						,min(maturity_id) as maturity_id
						,max(f.last_updated) as last_updated

				FROM [dbo].[uf_get_cat_tool_all] (@audit_client_id,@survey_id
				  -- <@client_id, int,>
				  --,<@survey_id, int,>
				  ) as f



				 group by  f.section_id
						,f.domain_name
						,f.parent_section_id
    
						,f.factor_name
				) as d
				group by d.section_id
						,d.f_order
						,d.domain_name




				union all

				SELECT  --f.domain_name
		 
						 f.parent_section_id
						,f.factor_name
						,ROW_NUMBER() over (partition by f.parent_section_id order by f.factor_name asc ) as f_order
						,min(maturity_id) as maturity_id
						,max(f.last_updated) as last_updated

				FROM [dbo].[uf_get_cat_tool_all] (@audit_client_id,@survey_id
				  -- <@client_id, int,>
				  --,<@survey_id, int,>
				  ) as f



				  group by  
							f.parent_section_id
	     
						,f.factor_name

				) cat

				join v_maturity as m on cat.maturity_id  = m.maturity_id
				order by cat.section_id
						,cat.f_order
						,cat.domain_name

		--end
END