CREATE TABLE [dbo].[property] (
    [property_id]     INT            IDENTITY (1, 1) NOT NULL,
    [property_name]   VARCHAR (255)  NULL,
    [description]     NVARCHAR (255) NULL,
    [type_id]         INT            NULL,
    [is_active]       BIT            DEFAULT ((1)) NULL,
    [created_on]      DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [updated_on]      DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [created_by]      INT            NULL,
    [updated_by]      INT            NULL,
    [audit_client_id] INT            NULL,
    CONSTRAINT [PK_property] PRIMARY KEY CLUSTERED ([property_id] ASC),
    CONSTRAINT [FK_property_type] FOREIGN KEY ([type_id]) REFERENCES [dbo].[type] ([type_id])
);

