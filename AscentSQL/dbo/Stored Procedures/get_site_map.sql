CREATE PROCEDURE [dbo].[get_site_map]
    @jsonVariable NVARCHAR(MAX)
	,    @audit_user_id int 
	,    @audit_client_id int
AS 
     BEGIN

    SET  XACT_ABORT  ON

    SET  NOCOUNT  ON
    ;
    with module as
        (
            SELECT [location_id]
            , [location_name]
            , [description]
            , [type_id]
            , [parent_id]
            , [display_order]
			, dbo.uf_get_icon([location_name]) as Icon
            , [is_active]
            FROM [location] 
            where parent_id is null


        ), section as
        (
            SELECT [location_id]
            , [location_name]
            , [description]
            , [type_id]
            , [parent_id]
            , [display_order]
			, dbo.uf_get_icon([location_name]) as Icon
            , [is_active]

            FROM [location] as section
            where parent_id in (SELECT [location_id]
            FROM module)
        ), sub_section as
        (
            SELECT [location_id]
            , [location_name] 
            , [description]
            , [type_id]
            , [parent_id]
            , [display_order]
			, dbo.uf_get_icon([location_name]) as Icon
            , [is_active]
            FROM [location] as sub_section
            where parent_id in (SELECT [location_id] FROM section)
        ), frame as
        (
            SELECT [location_id]
            , [location_name]
            , [description]
            , [type_id]
            , [parent_id]
            , [display_order]
            , [is_active]
			, dbo.uf_get_icon([location_name]) as Icon
            FROM [location] as frame
            where parent_id in (SELECT [location_id] FROM sub_section)
        )

    select  m.[location_id] 
		  , m.[location_name] as name
		  , m.[description] as caption
		  , m.[display_order]
		  , m.[icon] 
		  , m.[is_active] 
		  , (select
				    s.[location_id] 
				  , s.[location_name] as name
				  , s.[description] as caption
				  , s.[display_order] 
				  , s.[icon] 
				  , s.[is_active] 
				  , (select
							    ss.[location_id] 
							  , ss.[location_name]  as name
							  , ss.[description] as caption
							  , ss.[display_order] 
							  , ss.[icon] 
							  , ss.[is_active] 
							  , (select
											 f.[location_id]
										  , f.[location_name] as name
										  , f.[description] as caption
										  , f.[display_order]
										  , f.[icon]
										  , f.[is_active]
										  , (
												SELECT 
														[location_id]
														,p.property_name
														,[value]
														,lp.[is_active]

												FROM [location_property] as lp
												  join property as p on lp.property_id =p.property_id
												where lp.location_id = f.location_id
												for json path
											) as property
										  ,(SELECT [component_id]
												  ,[component_name]
												  ,c.[description]
												  ,[location_id]
												  ,t.type_name
												  ,p.property_name
												  ,[value]
												  ,c.[is_active]

											  FROM [component] as c
											  join type as t on c.type_id = t.type_id
											  join property as p on c.property_id = p.property_id 
											  where c.location_id = f.location_id
											  for json path
											) as component

											from frame as f
											where f.parent_id = ss.location_id
											for json path
										  ) as frame
								from sub_section as ss
								where ss.parent_id = s.location_id
							    for json path
							  ) as sub_section
				  from section as s
				  where s.parent_id = m.location_id
				  for json path
		  ) as section
    from module as m
    for json path , root('module')
    END
GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.get_site_map', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'get_site_map';

