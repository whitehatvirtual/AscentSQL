-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[add_update_component] 
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
	if (select ISJSON(@jsonVariable) ) =0
	begin
		exec [error_rais] '{"error_id":1}',1 ,1
	end

	
	declare @sp_out  table
		(id int 
		 ,ActionTaken nvarchar(10)
		);  


	merge [component] as target
	using (

					SELECT		 component_id as component_id
						,component_name as component_name
						,description as description

						,type_id as type_id
						,location_id as location_id
						,display_order as display_order
						,is_active as is_active
						,@audit_user_id  as audit_user_id 
						,@audit_client_id as audit_client_id 
			FROM OPENJSON (@jsonVariable, N'$.component')
				WITH (
						component_id int N'$.component_id'
						,component_name nvarchar(255) N'$.component_name'
						,description nvarchar(max) N'$.description'
						,location_id int N'$.location_id'
						,display_order int N'$.display_order'
						,type_id int N'$.type_id'
						
						,is_active bit  N'$.is_active'
				) AS component
		) as source
	on target.component_id = source.component_id 
	WHEN MATCHED 
		then update set target.component_name = source.component_name
						,target.description = source.description
						,target.type_id = source.type_id
						
						,target.location_id = source.location_id
						,target.display_order = source.display_order
						,target.is_active = source.is_active
						,target.updated_by = source.audit_user_id
						,target.updated_on = GETUTCDATE()
						,target.audit_client_id = source.audit_client_id
	WHEN NOT MATCHED BY TARGET 
		THEN insert ([component_name]
				   ,[description]
				   ,[type_id]
				   ,location_id
				   ,display_order
				   ,[created_by]
				   ,[audit_client_id]
				   ) 
		values ( source.[component_name]
				,source.[description]
				,source.type_id
				,source.location_id
				,source.display_order
				,source.audit_user_id
				,source.audit_client_id
				)
		output	 inserted.component_id, $action INTO @sp_out
	 
	;
		select * from @sp_out

END