-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[add_update_client] 
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
	declare @phone table
	(
	phone_id int
	) 
	declare @address_id int
			,@client_id int
			


	select  @client_id = client.client_id
	
	FROM OPENJSON (@jsonVariable, N'$')
	  WITH (
			   client_id  nvarchar(255) N'$.client.client_id' 

		) AS client;

	if @client_id > 0 

	-- update existing client
		begin
		update c
		set c.client_name = ci.client_name
			,c.email = ci.email
			,c.time_zone = c.time_zone
			,c.logo_document_id = ci.logo_document_id
			,c.service_tier_id = ci.service_tier_id
			,c.is_active = ci.is_active
			,c.updated_by = ci.audit_user_id
			,c.updated_on = GETUTCDATE()

		from 

		client as c
		join ( 
		SELECT
				 client.client_id
				,client.client_name
				,client.email
				,client.time_zone
				,client.logo_document_id
				,client.is_active
				,client.service_tier_id
				,@audit_user_id  as audit_user_id

		FROM OPENJSON (@jsonVariable, N'$')
		  WITH (
					client_id  int N'$.client.client_id' 
				   ,client_name  nvarchar(255) N'$.client.client_name' 
				   ,email nvarchar(255) N'$.client.email'
				   ,time_zone varchar(100) N'$.client.time_zone'
				   ,logo_document_id int N'$.client.logo_document_id'
				   ,address_id int N'$.client.address_id'
				   ,service_tier_id int N'$.client.service_tier_id'
				   ,is_active bit N'$.client.is_active'
			) AS client
			) as ci

		on c.client_id = ci.client_id

		-- select *
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

	end 

	else
	-- insert new client
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

		insert into client (client_name,email,time_zone,logo_document_id,address_id,service_tier_id,created_by)

		  SELECT client.client_name
				,client.email
				,client.time_zone
				,logo_document_id
				,@address_id
				,service_tier_id
				,@audit_user_id 
		FROM OPENJSON (@jsonVariable, N'$')
		  WITH (
				   client_name  nvarchar(255) N'$.client.client_name' 
				   ,email nvarchar(255) N'$.client.email'
				   ,time_zone varchar(100) N'$.client.time_zone'
				   ,logo_document_id int N'$.client.logo_document_id'
				   ,address_id int N'$.client.address_id'
				   ,service_tier_id int N'$.client.service_tier_id'
			) AS client;

		select @client_id = SCOPE_IDENTITY()



	end


	-- insert update delete phones
	merge [phone] as target
	using (

		SELECT  phone.phone_id
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
		) as source
	on target.phone_id = source.phone_id
	WHEN MATCHED 
		then update set target.phone_no = source.phone_no
						,target.type_id = source.type_id
						,target.updated_by = source.audit_user_id
						,target.updated_on = GETUTCDATE()
						,target.audit_client_id = source.audit_client_id
	WHEN NOT MATCHED BY TARGET 
		THEN insert (phone_no,type_id,created_by,audit_client_id) values (source.phone_no,source.type_id,source.audit_user_id,source.audit_client_id)
		output Inserted.phone_id into @phone
	 
	;

	merge [client_phone] as target
	using (
	select @client_id as client_id  , phone_id
	from @phone
	

	) as source
	on (target.client_id = source.client_id and target.phone_id = source.phone_id)
	WHEN NOT MATCHED BY TARGET 
		then insert (client_id,phone_id) values (client_id,phone_id)
	WHEN NOT MATCHED BY source and target.client_id = @client_id
		then delete 
	;
END