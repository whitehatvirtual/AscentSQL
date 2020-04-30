CREATE TABLE [dbo].[sp_map] (
    [sp_map_id]     INT            IDENTITY (1, 1) NOT NULL,
    [call_sp_name]  VARCHAR (4000) NULL,
    [read_sp_name]  VARCHAR (4000) NULL,
    [write_sp_name] VARCHAR (4000) NULL,
    [location_id]   INT            NULL,
    CONSTRAINT [PK_sp_map] PRIMARY KEY CLUSTERED ([sp_map_id] ASC)
);




GO
CREATE UNIQUE NONCLUSTERED INDEX [ix_u_sp_map_call_sp_name]
    ON [dbo].[sp_map]([call_sp_name] ASC);

