CREATE TABLE [dbo].[location] (
    [location_id]     INT           IDENTITY (1, 1) NOT NULL,
    [location_name]   VARCHAR (255) NULL,
    [description]     VARCHAR (255) NULL,
    [type_id]         INT           NULL,
    [parent_id]       INT           NULL,
    [display_order]   INT           NULL,
    [is_active]       BIT           DEFAULT ((1)) NULL,
    [created_on]      DATETIME2 (7) DEFAULT (getutcdate()) NULL,
    [updated_on]      DATETIME2 (7) DEFAULT (getutcdate()) NULL,
    [created_by]      INT           NULL,
    [updated_by]      INT           NULL,
    [audit_client_id] INT           NULL,
    CONSTRAINT [PK_location_location_id] PRIMARY KEY CLUSTERED ([location_id] ASC),
    CONSTRAINT [FK_location_location] FOREIGN KEY ([parent_id]) REFERENCES [dbo].[location] ([location_id]),
    CONSTRAINT [FK_location_type] FOREIGN KEY ([type_id]) REFERENCES [dbo].[type] ([type_id])
);




GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.location', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'location';


GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_nc_u_location_location_name]
    ON [dbo].[location]([location_name] ASC, [parent_id] ASC);

