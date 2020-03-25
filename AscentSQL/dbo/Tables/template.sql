CREATE TABLE [dbo].[template] (
    [template_id]     INT            IDENTITY (1, 1) NOT NULL,
    [template_name]   VARCHAR (255)  NULL,
    [type_id]         INT            NULL,
    [subject]         NVARCHAR (MAX) NULL,
    [body]            NVARCHAR (MAX) NULL,
    [is_active]       BIT            DEFAULT ((1)) NULL,
    [created_on]      DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [updated_on]      DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [created_by]      INT            NULL,
    [updated_by]      INT            NULL,
    [audit_client_id] INT            NULL,
    CONSTRAINT [PK_template_template_id] PRIMARY KEY CLUSTERED ([template_id] ASC),
    CONSTRAINT [FK_template_type] FOREIGN KEY ([type_id]) REFERENCES [dbo].[type] ([type_id])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.template', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'template';

