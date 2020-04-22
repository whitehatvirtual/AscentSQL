-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE system_add_frame_components 
	-- Add the parameters for the stored procedure here
	  @sp varchar(255) 
	 ,@location_id int 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set xact_abort on;

	IF (OBJECT_ID(@sp) IS NULL)
	BEGIN
		select 'no such sp!!!'
		return

	END;
	if not exists (select l.location_id  from location as l where l.location_id = @location_id)
	begin
		select 'no such location!!!'
		return

	end 

	declare @sub_section_id int
		 ,@location_name varchar(255)
		 ,@description nvarchar(255)
		 ,@type varchar(255)
		 
		
		 ,@type_id int = 36 -- txtLabel
		 ,@location_sp nvarchar(max)
		 ,@jsonVariable nvarchar(max)
		 ,@audit_user_id int = 1
		 ,@audit_client_id int =1
		 ,@sql nvarchar(max)

	set @jsonVariable = (
	SELECT
		 '' as component_id
		,name as component_name
		,[dbo].[uf_initial_cap] (replace(name,'_',' ')) as description
		,@location_id as location_id
		,column_ordinal as display_order
		,@type_id as type_id
		,1 as is_active

	FROM sys.dm_exec_describe_first_result_set_for_object
	(
	  OBJECT_ID(@sp), 
	  NULL
	)
	for json auto , root('component')
										
	)
	EXECUTE  [dbo].[add_update_component] 
	   @jsonVariable
	  ,@audit_user_id
	  ,@audit_client_id


	;
	with loc as (


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
	  join loc as l on l.parent_id = s.location_id
	  --where l.location_id = 191
 

	)


	select @location_sp = ( select location_name+'_' 
	from loc 
	order by level desc
	FOR XML PATH('')
	)


	IF (OBJECT_ID(@location_sp) IS NOT NULL)
	BEGIN
		exec('DROP procedure [dbo].[data_'+@location_sp+'list_get]')


	END;

	select @sql =
	'
	create PROCEDURE [dbo].[data_'+@location_sp+'list_get] 
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
		EXECUTE  '+@sp+'  
				   @jsonVariable
				  ,@audit_user_id
				  ,@audit_client_id


	END
	'
	exec(@sql)
END