CREATE TABLE [dbo].[framework] (
    [framework_id]    INT            IDENTITY (1, 1) NOT NULL,
    [framework_name]  NVARCHAR (255) NULL,
    [version]         NVARCHAR (255) NULL,
    [description]     NVARCHAR (MAX) NULL,
    [is_active]       BIT            DEFAULT ((1)) NULL,
    [is_master]       BIT            NULL,
    [created_on]      DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [updated_on]      DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [created_by]      INT            NULL,
    [updated_by]      INT            NULL,
    [audit_client_id] INT            NULL,
    CONSTRAINT [PK_framework_framework_id] PRIMARY KEY CLUSTERED ([framework_id] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.framework', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'framework';

