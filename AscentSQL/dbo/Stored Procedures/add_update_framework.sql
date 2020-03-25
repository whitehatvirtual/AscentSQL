-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE add_update_framework 
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
	declare @framework_id int

	if (select ISJSON(@jsonVariable) ) =0
	begin

	select 'input not JSON format!'
	return

	end

	else

	begin
		select  @framework_id = framework_id
	
		FROM OPENJSON (@jsonVariable, N'$')
		  WITH (
				   framework_id  int  N'$.framework.framework_id' 

			) AS [framework];

	   if @framework_id > 0 
	   begin
			update f
			set framework_name = fi.framework_name
				,version = fi.version
				,description = fi.description
				,is_master = fi.is_master
				,updated_on = GETUTCDATE()
				,updated_by = fi.audit_user_id
				,audit_client_id = fi.audit_client_id
			from framework as f
			join (
   					SELECT  framework_id
							,framework_name
							,version
							,description
							,is_master 
							,@audit_user_id  as audit_user_id 
							,@audit_client_id as audit_client_id 
					FROM OPENJSON (@jsonVariable, N'$')
					  WITH (
								framework_id nvarchar(255) N'$.framework.framework_id'
							   ,framework_name nvarchar(255) N'$.framework.framework_name'
							   ,version nvarchar(255) N'$.framework.version'
							   ,description nvarchar(max) N'$.framework.description'
							   ,is_active bit  N'$.framework.is_active'
							   ,is_master bit  N'$.framework.is_master'
						) AS framework
				) as fi on f.framework_id = fi.framework_id

	   end
	   else
	   begin
			INSERT INTO [dbo].[framework]
			   ([framework_name]
			   ,[version]
			   ,[description]
			   ,[is_master]
			   ,[created_by]
			   ,[audit_client_id])

			SELECT framework_name
					,version
					,description
					,is_master
					,@audit_user_id 
					,@audit_client_id
			FROM OPENJSON (@jsonVariable, N'$')
			  WITH (
						framework_id nvarchar(255) N'$.framework.framework_id'
					   ,framework_name nvarchar(255) N'$.framework.framework_name'
					   ,version nvarchar(255) N'$.framework.version'
					   ,description nvarchar(max) N'$.framework.description'
					   ,is_active bit  N'$.framework.is_active'
					   ,is_master bit  N'$.framework.is_master'
				) AS framework;
	   end

	end
END