-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[add_update_location_property] 
	-- Add the parameters for the stored procedure here
		 @jsonVariable NVARCHAR(MAX)
		,@audit_user_id int 
		,@audit_client_id int 
AS
BEGIN
  --{
  --  "location_property": {  
		--  "location_id":"",
		--  "property_id":"",
		--  "value":"",  
		--  "is_active":"1"
  --  }
  --}

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	drop table if exists #sp_out
	CREATE TABLE #sp_out  
		(id int 
		 ,ActionTaken nvarchar(10)
		);  

    -- Insert statements for procedure here
	if (select ISJSON(@jsonVariable) ) =0
	begin
		exec [error_rais] '{"error_id":1}',1 ,1
	end

	merge [location_property] as target
	using (

					SELECT		 location_id as location_id
						,property_id as property_id
						,[value] as [value]
						,is_active as is_active
						,@audit_user_id  as audit_user_id 
						,@audit_client_id as audit_client_id 
			FROM OPENJSON (@jsonVariable, N'$')
				WITH (
						location_id int N'$.location_property.location_id'
						,property_id int N'$.location_property.property_id'
						,value varchar(255) N'$.location_property.value'
						,is_active bit  N'$.location_property.is_active'
				) AS location_property
		) as source
	on target.location_id = source.location_id and target.property_id = source.property_id 
	WHEN MATCHED 
		then update set target.[value] = source.[value]
						
						,target.is_active = source.is_active
						,target.updated_by = source.audit_user_id
						,target.updated_on = GETUTCDATE()
						,target.audit_client_id = source.audit_client_id
	WHEN NOT MATCHED BY TARGET 
		THEN INSERT 
           ([location_id]
           ,[property_id]
           ,[value]
           ,[created_by]
           ,[audit_client_id]
		   )
		values ( source.location_id
				,source.property_id
				,source.[value]
				,source.audit_user_id
				,source.audit_client_id
				)
		output	 inserted.location_property_id, $action INTO #sp_out
	 
	;
	select * 
	from #sp_out
	drop table if exists #sp_out
END