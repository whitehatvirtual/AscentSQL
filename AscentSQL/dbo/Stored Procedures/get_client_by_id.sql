-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_client_by_id]
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
	declare @client_id int


	select   @client_id = client.client_id
	FROM OPENJSON (@jsonVariable, N'$')
		WITH (
				client_id  nvarchar(255) N'$.client.client_id' 
		) AS client

	SELECT [client_id]
		  ,[client_name]
		  ,[email]
		  ,[time_zone]
		  ,[logo_document_id]
		  ,[address_id]
		  ,[is_active]
		  ,[created_on]
		  ,[updated_on]
		  ,[created_by]
		  ,[updated_by]
	FROM [client] as c 


	where c.client_id = @client_id

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
		  ,[audit_client_id]
	FROM [address] as a
	join client as c on a.address_id = c.address_id
	where c.client_id = @client_id

	SELECT p.[phone_id]
		  ,[phone_no]
		  ,p.[is_active]
		  ,p.[created_on]
		  ,p.[updated_on]
		  ,p.[created_by]
		  ,p.[updated_by]
		  ,[audit_client_id]
	FROM [phone] as p
	join client_phone as cp on p.phone_id = cp.phone_id
	join client as c on cp.client_id = c.client_id
	where c.client_id = @client_id
END