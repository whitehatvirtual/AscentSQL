-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[uf_get_location_path]
(
	-- Add the parameters for the function here
	@location_id int
	,@devider char(1)
)
RETURNS 
	@result TABLE 
(
	-- Add the column definitions for the TABLE variable here
	location_path  varchar(4000)

)

           --(<section_id_text, nvarchar(255),>
           --,<section_name, nvarchar(255),>
           --,<description, nvarchar(max),>
           --,<framework_id, int,>
           --,<parent_section_id, int,>
           --,<is_active, bit,>
           --,<created_on, datetime2(7),>
           --,<updated_on, datetime2(7),>
           --,<created_by, int,>
           --,<updated_by, int,>
           --,<audit_client_id, int,>)
AS
BEGIN
;
		with loc1 as (


		select [location_id]
			  ,[location_name]
			  ,parent_id
			  ,1 as level
      
		  FROM [location]
		  where location_id = @location_id
		  union all
		  select s.[location_id]
			  ,s.[location_name]
			  ,s.parent_id
			  ,l.level + 1
		  from [location] as s
		  join loc1 as l on l.parent_id = s.location_id
		  --where l.location_id = 191
 

		)


		insert into @result
				select STUFF((
		select @devider +location_name 
		from loc1
		order by level desc
		FOR XML PATH('')),1,1,'')
		from loc1 
		where loc1.location_id = @location_id
	
	RETURN 
END