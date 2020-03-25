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
    select m.[location_id] 
      , m.[location_name] as name
      , m.[description]  as caption
      , m.[display_order]
	  , m.[icon]
      , m.[is_active] 
	  , s.[location_id]
      , s.[location_name]  as name
      , s.[description] as caption
      , s.[display_order] 
	  , s.[icon]
      , s.[is_active] 
	  , ss.[location_id] 
      , ss.[location_name] as name
      , ss.[description] as caption
      , ss.[display_order]
	  , ss.[icon]
      , ss.[is_active]
	  , f.[location_id]
      , f.[location_name] as name
      , f.[description] as caption
      , f.[display_order]
	  , f.[icon]
      , f.[is_active]
	  , component.component_id
	  , component.component_name as name
	  , component.description as caption
	  , component.is_active
    from module as m
        left join section as s on s.parent_id = m.location_id
        left join sub_section as ss on ss.parent_id = s.location_id
        left join frame as f on f.parent_id = ss.location_id
		left join component on f.location_id = component.location_id
    order by m.[display_order],s.[display_order],ss.[display_order],f.[display_order]
    for json auto, root('module')
    END
GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.get_site_map', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'get_site_map';

