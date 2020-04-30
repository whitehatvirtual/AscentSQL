-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[uf_get_top_section]
(
	-- Add the parameters for the function here
	@section_id int
)
RETURNS 
	@result TABLE 
(
	-- Add the column definitions for the TABLE variable here
	section_id int,
	section_id_text nvarchar(255),
	section_name nvarchar(255),
	description nvarchar(max),
	framework_id int,
	parent_section_id int

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

		with sec as (
		SELECT  [section_id]
			  ,[section_id_text]
			  ,[section_name]
			  ,[description]
			  ,[framework_id]
			  ,[parent_section_id]
      
		  FROM [section]
		  where section_id = @section_id
		  union  all
		  SELECT  s.[section_id]
			  ,s.[section_id_text]
			  ,s.[section_name]
			  ,s.[description]
			  ,s.[framework_id]
			  ,s.[parent_section_id]
      
		  FROM [section] as s
			join sec on s.section_id = sec.parent_section_id
		  )
		insert into @result
		select * 
		from sec
		where sec.parent_section_id is null
	
	RETURN 
END