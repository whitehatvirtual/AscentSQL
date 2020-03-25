CREATE TABLE [dbo].[encryption] (
    [encryption_id]   INT           IDENTITY (3, 1) NOT NULL,
    [encryption]      VARCHAR (255) NOT NULL,
    [is_active]       BIT           DEFAULT ((1)) NOT NULL,
    [created_on]      DATETIME2 (7) NULL,
    [updated_on]      DATETIME2 (7) NULL,
    [created_by]      INT           NULL,
    [updated_by]      INT           NULL,
    [audit_client_id] INT           NULL,
    CONSTRAINT [PK_encryption_encryption_id] PRIMARY KEY CLUSTERED ([encryption_id] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.encryption', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'encryption';

