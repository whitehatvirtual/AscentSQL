CREATE TABLE [dbo].[section] (
    [section_id]        INT            IDENTITY (4, 1) NOT NULL,
    [section_name]      NVARCHAR (255) NULL,
    [description]       NVARCHAR (MAX) NULL,
    [framework_id]      INT            NULL,
    [parent_section_id] INT            NULL,
    [is_active]         BIT            DEFAULT ((1)) NULL,
    [created_on]        DATETIME2 (7)  NULL,
    [updated_on]        DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [created_by]        INT            NULL,
    [updated_by]        INT            NULL,
    [audit_client_id]   INT            NULL,
    CONSTRAINT [PK_section_section_id] PRIMARY KEY CLUSTERED ([section_id] ASC),
    CONSTRAINT [FK_section_framework] FOREIGN KEY ([framework_id]) REFERENCES [dbo].[framework] ([framework_id]),
    CONSTRAINT [FK_section_section] FOREIGN KEY ([parent_section_id]) REFERENCES [dbo].[section] ([section_id])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.section', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'section';

