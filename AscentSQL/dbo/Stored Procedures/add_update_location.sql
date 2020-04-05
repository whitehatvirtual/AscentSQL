-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE add_update_location 
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

	merge [location] as target
	using (

					SELECT		 location_id as location_id
						,location_name as location_name
						,description as description
						,case when parent_id = 0 then null else parent_id end as parent_id 
						,type_id as type_id
						,display_order as display_order
						,is_active as is_active
						,@audit_user_id  as audit_user_id 
						,@audit_client_id as audit_client_id 
			FROM OPENJSON (@jsonVariable, N'$')
				WITH (
						location_id int N'$.location.location_id'
						,location_name nvarchar(255) N'$.location.location_name'
						,description nvarchar(max) N'$.location.description'
						,parent_id int N'$.location.parent_id'
				
						,type_id int N'$.location.type_id'
						,display_order int N'$.location.display_order'
						,is_active bit  N'$.location.is_active'
				) AS location
		) as source
	on target.location_id = source.location_id
	WHEN MATCHED 
		then update set target.location_name = source.location_name
						,target.description = source.description
						,target.type_id = source.type_id
						,target.display_order = source.display_order
						,target.parent_id = source.parent_id
						,target.is_active = source.is_active
						,target.updated_by = source.audit_user_id
						,target.updated_on = GETUTCDATE()
						,target.audit_client_id = source.audit_client_id
	WHEN NOT MATCHED BY TARGET 
		THEN insert ([location_name]
				   ,[description]
				   ,[type_id]
				   ,[parent_id]
				   ,[display_order]
				   ,[created_by]
				   ,[audit_client_id]
				   ) 
		values ( source.[location_name]
				,source.[description]
				,source.type_id
				,source.[parent_id]
				,source.[display_order]
				,source.audit_user_id
				,source.audit_client_id
				)
		
	 
	;
END