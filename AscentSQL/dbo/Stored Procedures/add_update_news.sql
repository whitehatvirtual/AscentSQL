-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[add_update_news] 
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
	declare @news_id int

	if (select ISJSON(@jsonVariable) ) =0
	begin

	select 'input not JSON format!'
	return

	end

	else

	begin
		select  @news_id = news_id
	
		FROM OPENJSON (@jsonVariable, N'$')
		  WITH (
				   news_id  int  N'$.news.news_id' 

			) AS [news];

	   if @news_id > 0 
	   begin
			update t
			set news_title = s.news_title
				,description = s.description
				,updated_on = GETUTCDATE()
				,is_active = s.is_active
				,updated_by = s.audit_user_id
				,audit_client_id = s.audit_client_id
			from news as t
			join (
   					SELECT  news_id
							,news_title
							,description
							,is_active
							,@audit_user_id  as audit_user_id 
							,@audit_client_id as audit_client_id 
					FROM OPENJSON (@jsonVariable, N'$')
					  WITH (
								news_id int N'$.news.news_id'
							   ,news_title nvarchar(255) N'$.news.news_title'
							   ,description nvarchar(max) N'$.news.description'
							   ,is_active bit  N'$.news.is_active'
						) AS j
				) as s on t.news_id = s.news_id

	   end
	   else
	   begin
			INSERT INTO [news]
					   ([news_title]
					   ,[description]
					   ,[created_by]
					   ,[audit_client_id])

   			SELECT   news_title
					,description
					,@audit_user_id  as audit_user_id 
					,@audit_client_id as audit_client_id 
			FROM OPENJSON (@jsonVariable, N'$')
				WITH (
						news_id int N'$.news.news_id'
						,news_title nvarchar(255) N'$.news.news_title'
						,description nvarchar(max) N'$.news.description'
						,is_active bit  N'$.news.is_active'
				) AS j
	   end

	end
END