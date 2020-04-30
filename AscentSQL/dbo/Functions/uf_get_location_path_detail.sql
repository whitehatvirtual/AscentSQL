-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[uf_get_location_path_detail]
(
	-- Add the parameters for the function here
	
)
RETURNS 
	@result TABLE 
(
	-- Add the column definitions for the TABLE variable here
	location_id int,
	location_name varchar(255),
	parent_id int,
	level int,
	location_path  varchar(4000),
	location_route  varchar(4000)

)


AS
BEGIN
	;
	with loc as (


	select [location_id]
		  ,[location_name]
		  ,parent_id
		  ,1 as level
      
	  FROM [location]
	  where parent_id is null
	  union all
	  select s.[location_id]
		  ,s.[location_name]
		  ,s.parent_id
		  ,l.level + 1
	  from [location] as s
	  join loc as l on s.parent_id = l.location_id
	  --where l.location_id = 191
 

	)
	
	insert into @result
	select	l.location_id
			,l.location_name
			,l.parent_id
			,l.level
			,p.location_path
			,pn.location_path
	from loc as l
	cross apply dbo.uf_get_location_path(l.location_id,'_') as p
	cross apply dbo.uf_get_location_path(l.location_id,'/') as pn
	
	RETURN 
END