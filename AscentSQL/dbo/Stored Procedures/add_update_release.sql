-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[add_update_release] 
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
	declare @release_id int

	if (select ISJSON(@jsonVariable) ) =0
	begin

	select 'input not JSON format!'
	return

	end

	else

	begin
		select  @release_id = release_id
	
		FROM OPENJSON (@jsonVariable, N'$')
		  WITH (
				   release_id  int  N'$.release.release_id' 

			) AS [release];

	   if @release_id > 0 
	   begin
			update t
			set version_number = s.version_number
				,description = s.description
				,updated_on = GETUTCDATE()
				,is_active = s.is_active
				,updated_by = s.audit_user_id
				,audit_client_id = s.audit_client_id
			from release as t
			join (
   					SELECT  release_id
							,version_number
							,description
							,is_active
							,@audit_user_id  as audit_user_id 
							,@audit_client_id as audit_client_id 
					FROM OPENJSON (@jsonVariable, N'$')
					  WITH (
								release_id int N'$.release.release_id'
							   ,version_number nvarchar(255) N'$.release.version_number'
							   ,description nvarchar(max) N'$.release.description'
							   ,is_active bit  N'$.release.is_active'
						) AS j
				) as s on t.release_id = s.release_id

	   end
	   else
	   begin
			INSERT INTO [release]
					   ([version_number]
					   ,[description]
					   ,[created_by]
					   ,[audit_client_id])

   			SELECT   version_number
					,description
					,@audit_user_id  as audit_user_id 
					,@audit_client_id as audit_client_id 
			FROM OPENJSON (@jsonVariable, N'$')
				WITH (
						release_id int N'$.release.release_id'
						,version_number nvarchar(255) N'$.release.version_number'
						,description nvarchar(max) N'$.release.description'
						,is_active bit  N'$.release.is_active'
				) AS j
	   end

	end
END