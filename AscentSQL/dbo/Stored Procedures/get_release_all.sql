﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_release_all] 
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

	select 'input not JSON format!'
	return

	end

	else

	begin

			SELECT  [release_id]
				  ,[version_number]
				  ,[description]
				  ,dbo.uf_get_status([is_active]) as [status]
				  ,isnull([updated_on],[created_on]) as release_date
				  ,[created_on]
				  ,[updated_on]
				  ,[created_by]
				  ,[updated_by]
				  ,[audit_client_id]
			  FROM [release]
	end
END