-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE add_update_user 
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
	declare @address_id int
			,@user_id int
			,@phone_id int



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

	   if @user_id > 0 
	   begin
		
			update u
				set first_name = ui.first_name
					,last_name = ui.last_name
					,email = ui.email
					,job_title = ui.job_title
					,time_zone = ui.time_zone
					,type_id = ui.type_id
					,updated_by = ui.audit_user_id
					,audit_client_id = ui.audit_client_id
			from [user] as u
			join (
					SELECT 
							 [user_id]
							,first_name
							,last_name
							,email
							,job_title
							,time_zone
							,type_id
							,@audit_user_id as audit_user_id
							,@audit_client_id as audit_client_id
			
					FROM OPENJSON (@jsonVariable)
					  WITH (
								user_id  int N'$.user.user_id' 
							   ,first_name  nvarchar(255)  N'$.user.first_name'  
							   ,last_name  nvarchar(255)  N'$.user.last_name'  
							   ,email nvarchar(255)  N'$.user.email' 
							   ,job_title nvarchar(50)  N'$.user.job_title' 
							   ,time_zone varchar(100) N'$.user.time_zone'
							   ,type_id int N'$.user.type_id'
							   ,is_active bit N'$.user.is_active'

						) AS [user]
				 ) as ui on u.user_id = ui.user_id

   			update a
			set a.street = ai.street
				,a.city = ai.city
				,a.state = ai.state
				,a.country = ai.country
				,a.zip = ai.zip
				,a.updated_by = ai.audit_user_id
				,a.updated_on = GETUTCDATE()
				,a.audit_client_id = ai.audit_client_id
			from address as a
			join (

			  SELECT address.address_id
					,address.street
					,address.city
					,address.state
					,address.country
					,address.zip
					,@audit_user_id as audit_user_id
					,@audit_client_id as audit_client_id
			FROM OPENJSON (@jsonVariable, N'$')
			  WITH (
						address_id int N'$.address.address_id'
					   ,street nvarchar(255) N'$.address.street'
					   ,city nvarchar(255) N'$.address.city'
					   ,state nvarchar(255) N'$.address.state'
					   ,country nvarchar(255) N'$.address.country'
					   ,zip nvarchar(20) N'$.address.zip'
				) AS address
				) as ai
			on a.address_id = ai.address_id

			update p
				set phone_no = ph.phone_no
					,type_id = ph.type_id
					,updated_by = ph.audit_user_id
					,audit_client_id = ph.audit_client_id
			from phone as p
			join(
			SELECT  
					 phone.phone_id
					,phone.phone_no
					,phone.type_id
					,@audit_user_id  as audit_user_id
					,@audit_client_id as audit_client_id

			FROM OPENJSON (@jsonVariable, N'$.phone')
			  WITH (
						phone_id int
					   ,phone_no  nvarchar(45) 
					   ,type_id int 
				) AS phone
			) as ph on p.phone_id = ph.phone_id 



	   end
	   else
	   begin

			Insert into address (street,city,state,country,zip,created_by,audit_client_id)
			  SELECT address.street
					,address.city
					,address.state
					,address.country
					,address.zip
					,@audit_user_id 
					,@audit_client_id
			FROM OPENJSON (@jsonVariable, N'$')
			  WITH (
						street nvarchar(255) N'$.address.street'
					   ,city nvarchar(255) N'$.address.city'
					   ,state nvarchar(255) N'$.address.state'
					   ,country nvarchar(255) N'$.address.country'
					   ,zip nvarchar(20) N'$.address.zip'
				) AS address;

			select @address_id = SCOPE_IDENTITY()
			INSERT INTO [dbo].[phone]
				   ([phone_no]
				   ,[type_id]
				   ,[created_by]
				   ,[audit_client_id])

			SELECT  
					-- phone.phone_id
					 phone.phone_no
					,phone.type_id
					,@audit_user_id  as audit_user_id
					,@audit_client_id as audit_client_id

			FROM OPENJSON (@jsonVariable, N'$.phone')
			  WITH (
						phone_id int
					   ,phone_no  nvarchar(45) 
					   ,type_id int 
				) AS phone
			select @phone_id = SCOPE_IDENTITY()

			INSERT INTO [user]
					   ([first_name]
					   ,[last_name]
					   ,[email]
					   ,[job_title]
					   ,[time_zone]
					   ,[phone_id]
					   ,[type_id]
					   ,[address_id]
					   ,[created_by]
					   ,[audit_client_id])

			SELECT 
					 first_name
					,last_name
					,email
					,job_title
					,time_zone
					,@phone_id
					,type_id
					,@address_id
					,@audit_user_id
					,@audit_client_id
			
			FROM OPENJSON (@jsonVariable)
			  WITH (
						user_id  int N'$.user.user_id' 
					   ,first_name  nvarchar(255)  N'$.user.first_name'  
					   ,last_name  nvarchar(255)  N'$.user.last_name'  
					   ,email nvarchar(255)  N'$.user.email' 
					   ,job_title nvarchar(50)  N'$.user.job_title' 
					   ,time_zone varchar(100) N'$.user.time_zone'
					   ,type_id int N'$.user.type_id'
					   ,is_active bit N'$.user.is_active'

				) AS [user]
			select @user_id = SCOPE_IDENTITY()

			INSERT INTO [dbo].[password]
				   ([user_id]
				   ,[password]
				   ,[password_salt]
				   ,[token]
				   ,[password_date])
			SELECT
				  @user_id
				  ,[password]
				  ,CONVERT(VARCHAR(32), HashBytes('MD5', email), 2)
				  ,CONVERT(VARCHAR(32), HashBytes('MD5', email), 2)
				  ,GETUTCDATE()

			FROM OPENJSON (@jsonVariable)
			  WITH (
						password  varchar(255) N'$.user.password' 
					   ,email nvarchar(255)  N'$.user.email' 
				) AS [password]
		end
	end
END