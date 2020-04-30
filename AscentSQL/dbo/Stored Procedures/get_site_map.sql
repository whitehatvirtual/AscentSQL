CREATE PROCEDURE [dbo].[get_site_map]
		 @jsonVariable NVARCHAR(MAX)
		,@audit_user_id int 
		,@audit_client_id int
AS 
     BEGIN

    SET  XACT_ABORT  ON

    SET  NOCOUNT  ON
    ;

	----------------------------------
	--- Manage Loging here , get id
	----------------------------------
    with ua as
		(SELECT 
      		  ua.[location_id]
			  ,uc.user_id
			  ,uc.client_id
			  ,ua.is_active
		  FROM [user_access] as ua
		  join user_client as uc on ua.user_client_id = uc.user_client_id 
		  where uc.user_id = @audit_user_id 
				and uc.client_id = @audit_client_id 
				and ua.is_active = 1
		 ),module as
        (
            SELECT l.[location_id]
            , [location_name]
            , [description]
            , l.[type_id]
            , [parent_id]
            , [display_order]
			, dbo.uf_get_icon([location_name]) as Icon
            , l.[is_active]
            FROM [location] as l
			join ua on l.location_id = ua.location_id 
            where parent_id is null


        ), section as
        (
            SELECT section.[location_id]
            , [location_name]
            , [description]
            , section.[type_id]
            , [parent_id]
            , [display_order]
			, dbo.uf_get_icon([location_name]) as Icon
            , section.[is_active]

            FROM [location] as section
			join  ua on section.location_id = ua.location_id 
            where parent_id in (SELECT [location_id]
            FROM module)
        ), sub_section as
        (
            SELECT sub_section.[location_id]
            , [location_name] 
            , [description]
            , sub_section.[type_id]
            , [parent_id]
            , [display_order]
			, dbo.uf_get_icon([location_name]) as Icon
            , sub_section.[is_active]
            FROM [location] as sub_section
			join  ua on sub_section.location_id = ua.location_id 
            where parent_id in (SELECT [location_id] FROM section)
        ), frame as
        (
            SELECT frame.[location_id]
            , [location_name]
            , [description]
            , frame.[type_id]
            , [parent_id]
            , [display_order]
            , frame.[is_active]
			, dbo.uf_get_icon([location_name]) as Icon
            FROM [location] as frame
			join ua on frame.location_id = ua.location_id 
            where parent_id in (SELECT [location_id] FROM sub_section)
        )

    select  m.[location_id] 
		  , m.[location_name] as name
		  , m.[description] as caption
		  , ISNULL(m.display_order,0) as [display_order]
		  , m.[icon] 
		  , m.[is_active] 
		  , (select
				    s.[location_id] 
				  , s.[location_name] as name
				  , s.[description] as caption
				  , ISNULL(s.display_order,0) as [display_order]
				  , s.[icon] 
				  , s.[is_active] 
				  , (select
							    ss.[location_id] 
							  , ss.[location_name]  as name
							  , ss.[description] as caption
							  , ISNULL(ss.display_order,0) as [display_order]
							  , ss.[icon] 
							  , ss.[is_active] 
							  , (select
											 f.[location_id]
										  , f.[location_name] as name
										  , f.[description] as caption
										  , ISNULL(f.display_order,0) as [display_order]
                                          --, 'infoGrid' as [type]
										  , f.[icon]
										  , f.[is_active]
										  , (
												SELECT 
														[location_id]
														,p.property_name as name
														,[value]
														,lp.[is_active]

												FROM [location_property] as lp
												  join property as p on lp.property_id =p.property_id
												where lp.location_id = f.location_id
												for json path
											) as property
										  ,(SELECT [component_id]
												  ,[component_name] as name
												  ,c.[description]
												  ,[location_id]
												  ,t.type_name as [type]
												  ,c.[is_active]
                                                  ,ISNULL(c.display_order,0) as [display_order]
												  , (
														SELECT 
																cp.[component_id]
																,p.property_name as name
																,[value]
																,cp.[is_active]

														FROM [component_property] as cp
															join property as p on cp.property_id =p.property_id
														where cp.[component_id] = c.[component_id] and cp.is_active = 1
														for json path
													) as property

											  FROM [component] as c
											  join type as t on c.type_id = t.type_id
											  
											  where c.location_id = f.location_id and c.is_active = 1
                                              order by c.display_order
											  for json path
											) as component

											from frame as f
											where f.parent_id = ss.location_id and f.is_active = 1
											order by f.display_order asc
											for json path
										  ) as frame
								from sub_section as ss
								where ss.parent_id = s.location_id and ss.is_active = 1
								order by ss.display_order asc
							    for json path
							  ) as sub_section
				  from section as s
				  where s.parent_id = m.location_id and s.is_active = 1
				  order by s.display_order asc
				  for json path
		  ) as section
    from module as m
	where is_active = 1
	order by m.display_order asc
    for json path , root('module')
    END
GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.get_site_map', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'get_site_map';

