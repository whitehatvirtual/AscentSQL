-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[uf_check_dublicate_folder_name] 
(
	-- Add the parameters for the function here
			 @location_id int 
			,@folder_name nvarchar(255)  
			,@parent_folder_id int 
			,@client_id int
			,@folder_id int
)
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result bit
	if @parent_folder_id is null or @parent_folder_id = 0 
		begin
		set @parent_folder_id = (	SELECT [folder_id]
 									FROM [folder] as f 
									where f.location_id = @location_id
										and f.folder_name = 'root'
										and f.client_id = @client_id
									)
		end
	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = case when count(f.folder_id) >0 then 1 else 0 end
	FROM folder as f
	where f.parent_id = @parent_folder_id
			and f.client_id = @client_id
			and f.folder_name = @folder_name
			and f.location_id = @location_id
			and f.is_active = 'true'
			and (isnull(@folder_id,0) = 0 or f.folder_id <> @folder_id)
	
	-- Return the result of the function
	RETURN @Result

END