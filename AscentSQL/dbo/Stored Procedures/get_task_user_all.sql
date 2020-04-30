-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[get_task_user_all] 
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
	--if (select ISJSON(@jsonVariable) ) =0
	--begin
	--	exec [error_rais] '{"error_id":1}',1 ,1
	--end
	--declare @component_id int


	--				SELECT	@component_id =	 component_id 
					
	--		FROM OPENJSON (@jsonVariable, N'$')
	--			WITH (
	--					component_id int N'$.component.component_id'
	--					,component_name nvarchar(255) N'$.component.component_name'
	--					,description nvarchar(max) N'$.component.description'
	--					,location_id int N'$.component.location_id'
				
	--					,type_id int N'$.component.type_id'
						
	--					,is_active bit  N'$.component.is_active'
	--			) AS component
		SELECT 
			[user_id] as value
			, [dbo].[uf_get_user_fullname] ([user_id]) as text
      
		  FROM [user_client] as uc 
END