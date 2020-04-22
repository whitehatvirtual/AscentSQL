-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[add_update_section] 
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
	declare @section_id int
	declare @sp_out  table
		(id int 
		 ,ActionTaken nvarchar(10)
		);

	if (select ISJSON(@jsonVariable) ) =0
	begin

	select 'input not JSON format!'
	return

	end

	else
	
  


	begin
		select  @section_id = section_id
	
		FROM OPENJSON (@jsonVariable, N'$')
		  WITH (
				   section_id  int  N'$.section.section_id' 

			) AS [section];

	   if @section_id > 0 
	   begin
			update t
			set section_name = s.section_name
				,description = s.description
				,framework_id = s.framework_id
				,parent_section_id = s.parent_section_id
				,updated_on = GETUTCDATE()
				,is_active = s.is_active
				,updated_by = s.audit_user_id
				,audit_client_id = s.audit_client_id
			output inserted.section_id, 'U' into @sp_out
			from section as t
			join (
   					SELECT  section_id
							,section_name
							,description
							,framework_id 
							,parent_section_id

							,is_active
							,@audit_user_id  as audit_user_id 
							,@audit_client_id as audit_client_id 
					FROM OPENJSON (@jsonVariable, N'$')
					  WITH (
								section_id int N'$.section.section_id'
							   ,section_name nvarchar(255) N'$.section.section_name'
							   ,description nvarchar(max) N'$.section.description'
							   ,framework_id int N'$.section.framework_id'
							   ,parent_section_id int N'$.section.parent_section_id'
							   ,is_active bit  N'$.section.is_active'
						) AS j
				) as s on t.section_id = s.section_id


	   end
	   else
	   begin
			INSERT INTO [section]
					   ([section_name]
					   ,[description]
					   ,[framework_id]
					   ,[parent_section_id]
					   ,[created_by]
					   ,[audit_client_id])
			output inserted.section_id, 'I' into @sp_out

   			SELECT   section_name
					,description
					,framework_id 
					,parent_section_id
					,@audit_user_id  as audit_user_id 
					,@audit_client_id as audit_client_id 
			FROM OPENJSON (@jsonVariable, N'$')
				WITH (
						section_id int N'$.section.section_id'
						,section_name nvarchar(255) N'$.section.section_name'
						,description nvarchar(max) N'$.section.description'
						,framework_id int N'$.section.framework_id'
						,parent_section_id int N'$.section.parent_section_id'
						,is_active bit  N'$.section.is_active'
				) AS j
	   end
	   select * from @sp_out
	end

END