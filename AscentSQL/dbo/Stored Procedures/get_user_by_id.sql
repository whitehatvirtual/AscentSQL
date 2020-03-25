-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE get_user_by_id 
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
	declare @user_id int

	if (select ISJSON(@jsonVariable) ) =0
	begin

	select 'input not JSON format!'
	return

	end

	else

	begin
	
		select  @user_id = [user_id]
	
		FROM OPENJSON (@jsonVariable, N'$')
		  WITH (
				   user_id  int  N'$.user.user_id' 

			) AS [user];
		-- result 1 user
	    SELECT  [user_id]
			,[first_name]
			,[last_name]
			,[email]
			,[job_title]
			,[time_zone]
			,[phone_id]
			,t.type_name
			,[address_id]
			,u.[is_active]
			,u.[created_on]
			,u.[updated_on]
			,u.[created_by]
			,u.[updated_by]
			,u.[audit_client_id]
		FROM [user] as u
		join type as t on u.type_id = t.type_id
		where u.user_id = @user_id
	
		--result 2 address
		SELECT a.[address_id]
				,[street]
				,[city]
				,[state]
				,[country]
				,[zip]
				,a.[is_active]
				,a.[created_on]
				,a.[updated_on]
				,a.[created_by]
				,a.[updated_by]
				,a.[audit_client_id]
		FROM [address] as a
		join [user] as u on a.address_id = u.address_id
		where u.user_id = @user_id

		--result 3 phone
		SELECT p.[phone_id]
				,[phone_no]
				,p.[type_id]
				,p.[is_active]
				,p.[created_on]
				,p.[updated_on]
				,p.[created_by]
				,p.[updated_by]
				,p.[audit_client_id]
		FROM [phone] as p
	
		join [user] as u on p.phone_id = u.phone_id
		where u.user_id = @user_id

		--result 4 password
		SELECT [password_id]
			,p.[user_id]
			,[password]
			,[password_salt]
			,[token]
			,[password_date]
			,ROW_NUMBER() over (partition by user_id order by password_date desc)
		FROM [password] as p
		where p.user_id = @user_id
	end
END