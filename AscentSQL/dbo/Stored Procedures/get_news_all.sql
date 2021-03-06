﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_news_all] 
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

			select 'input not JSON format!'
			return

		end

		else

		begin
			SELECT [news_id]
			  ,[news_title]
			  ,[description]
			  ,dbo.uf_get_status([is_active]) as [status]
			  ,[created_on]
			  ,[updated_on]
			  ,[created_by]
			  ,[updated_by]
			  ,[audit_client_id]
		  FROM [news]
		end
END