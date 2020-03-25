CREATE TABLE [dbo].[type] (
    [type_id]         INT            IDENTITY (1, 1) NOT NULL,
    [type_name]       NVARCHAR (255) NULL,
    [description]     NVARCHAR (MAX) NULL,
    [type_header_id]  INT            NULL,
    [is_active]       BIT            DEFAULT ((1)) NULL,
    [created_on]      DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [updated_on]      DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [created_by]      INT            NULL,
    [updated_by]      INT            NULL,
    [audit_client_id] INT            NULL,
    CONSTRAINT [PK_type_type_id] PRIMARY KEY CLUSTERED ([type_id] ASC),
    CONSTRAINT [FK_type_type_header] FOREIGN KEY ([type_header_id]) REFERENCES [dbo].[type_header] ([type_header_id])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'type';

