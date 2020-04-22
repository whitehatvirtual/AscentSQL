-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_section_all]
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

		SELECT     [section_id] as id
					,[section_name] as control_family_name
					,[description] as control_description
					,[framework_id]
					,[parent_section_id]
					,dbo.uf_get_status([is_active]) as [status]
					,[created_on]
					,[updated_on]
					,[created_by]
					,[updated_by]
					,[audit_client_id]
		FROM [section]
		where (isnull(@parent_section_id,0)=0  and [parent_section_id] is null)
				or ([parent_section_id] = @parent_section_id)
	end
END