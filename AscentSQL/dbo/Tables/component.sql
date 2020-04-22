CREATE TABLE [dbo].[component] (
    [component_id]    INT            IDENTITY (1, 1) NOT NULL,
    [component_name]  VARCHAR (255)  NULL,
    [description]     NVARCHAR (255) NULL,
    [location_id]     INT            NULL,
    [type_id]         INT            NULL,
    [is_active]       BIT            DEFAULT ((1)) NULL,
    [created_on]      DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [updated_on]      DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [created_by]      INT            NULL,
    [updated_by]      INT            NULL,
    [audit_client_id] INT            NULL,
    [display_order]   INT            NULL,
    CONSTRAINT [PK_component] PRIMARY KEY CLUSTERED ([component_id] ASC),
    CONSTRAINT [FK_component_location] FOREIGN KEY ([location_id]) REFERENCES [dbo].[location] ([location_id]),
    CONSTRAINT [FK_component_type] FOREIGN KEY ([type_id]) REFERENCES [dbo].[type] ([type_id])
);





