﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_framework_by_id]
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
		
		FROM OPENJSON (@jsonVariable, N'$.frame.framework_list')
		  WITH (
				   framework_id  int  N'$.framework_id' 

			) AS [framework];
	
		--FROM OPENJSON (@jsonVariable, N'$')
		--  WITH (
		--		   framework_id  int  N'$.framework.framework_id' 

		--	) AS [framework];

		SELECT  [framework_id]
				,[framework_name]
				,[version]
				,[description]
				,cast([is_active] as int) as [status]
				
				,[is_master]
				,[created_on]
				,[updated_on]
				,[created_by]
				,[updated_by]
				,[audit_client_id]
		FROM [framework] 
		where [framework_id] = @framework_id
	end
END