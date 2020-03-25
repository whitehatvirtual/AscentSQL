-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE get_section_all
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
		select  @parent_section_id = parent_section_id
	
		FROM OPENJSON (@jsonVariable, N'$')
			WITH (
					parent_section_id  int  N'$.section.parent_section_id' 

			) AS [section];

		SELECT     [section_id]
					,[section_name]
					,[description]
					,[framework_id]
					,[parent_section_id]
					,[is_active]
					,[created_on]
					,[updated_on]
					,[created_by]
					,[updated_by]
					,[audit_client_id]
		FROM [section]
		where [parent_section_id] = @parent_section_id
	end
END