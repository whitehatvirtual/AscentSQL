-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[add_update_user_access] 
	-- Add the parameters for the stored procedure here
	     @jsonVariable NVARCHAR(MAX)
		,@audit_user_id int 
		,@audit_client_id int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    merge user_access as target
	using (


  SELECT  
		  3 as user_client_id
		  ,	[location_id]
		  , 2 as type_id
		  ,@audit_user_id  as audit_user_id 
		  ,@audit_client_id as audit_client_id 
	 from location
  
		) as source
	on target.location_id = source.location_id and target.user_client_id = source.user_client_id
	WHEN MATCHED 
		then update set
						target.type_id = source.type_id

						,target.updated_by = source.audit_user_id
						,target.updated_on = GETUTCDATE()
						,target.audit_client_id = source.audit_client_id
	WHEN NOT MATCHED BY TARGET 
		THEN insert ([user_client_id] 
				   ,[location_id]
				   ,[type_id]
				   ,[created_by]
				   ,[audit_client_id]
				   ) 
		values ( source.[user_client_id]
				,source.[location_id]
				,source.type_id
				,source.audit_user_id
				,source.audit_client_id
				)
				;	
END