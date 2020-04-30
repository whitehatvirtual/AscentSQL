-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION uf_get_first_client_details
(	
	-- Add the parameters for the function here
	@user_id int
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
			select top 1 client_id, client_name
			from 
			(
			SELECT 
				   uc.[client_id]
				  ,uc.[type_id]
				  ,user_id
				  ,c.client_name
			  FROM [user_client] as uc
			  join client as c on uc.client_id = c.client_id
			  where uc.type_id = 54
					and uc.user_id = @user_id
			union all 
			SELECT 
				   uc.[client_id]
				  ,uc.[type_id]
				  ,user_id
				  ,c.client_name
			  FROM [user_client]  as uc
			  
			  join client as c on uc.client_id = c.client_id
			  where uc.user_id = @user_id
			 ) as uc
)