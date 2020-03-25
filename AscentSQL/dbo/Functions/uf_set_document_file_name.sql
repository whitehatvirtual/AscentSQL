-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[uf_set_document_file_name]
(
	-- Add the parameters for the function here
			@folder_id int
			,@file_name nvarchar(255)
			,@file_extension nvarchar(255)

)
RETURNS nvarchar(255)
AS
BEGIN
	-- Declare the return variable here
		declare @result nvarchar(255)
		declare @file_count table (
				  file_no int
			)
		insert into @file_count

		SELECT 
			case when isnumeric(ltrim(rtrim(replace(replace(substring(right(d.file_name,5),PATINDEX('%([0-9])', right(d.file_name,5))+1,len(right(d.file_name,5)) ),')',''),'(',''))) ) = 1
				 then ltrim(rtrim(replace(replace(substring(right(d.file_name,5),PATINDEX('%([0-9])', right(d.file_name,5))+1,len(right(d.file_name,5)) ),')',''),'(','')))
				 end 
			as file_no
		--,[file_name]+'.'+file_extension
		FROM [document] as d
		where (d.file_name = @file_name or file_name like @file_name +' (%[0-9]%)')
		and file_extension = @file_extension
		and  d.folder_id = @folder_id



		set @result = (select case when count(*) >1 
			  then @file_name +' ('+cast(min(t1.file_no) as nvarchar(255))+')'
			  else @file_name
			  end as file_name
	   
		from 
				(	select 1 as file_no
					union all
					select file_no +1
					from @file_count
				) as t1 
				left join @file_count as t2 on t1.file_no = t2.file_no
				where t2.file_no is null
			)
	-- Return the result of the function
	RETURN @result

END