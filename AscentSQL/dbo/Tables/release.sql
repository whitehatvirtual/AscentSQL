CREATE TABLE [dbo].[release] (
    [release_id]      INT            IDENTITY (1, 1) NOT NULL,
    [version_number]  VARCHAR (100)  NOT NULL,
    [description]     NVARCHAR (MAX) NOT NULL,
    [is_active]       BIT            DEFAULT ((1)) NOT NULL,
    [created_on]      DATETIME2 (7)  NULL,
    [updated_on]      DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [created_by]      INT            NULL,
    [updated_by]      INT            NULL,
    [audit_client_id] INT            NULL,
    CONSTRAINT [PK_release_release_id] PRIMARY KEY CLUSTERED ([release_id] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.`release`', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'release';

