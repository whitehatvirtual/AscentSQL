CREATE TABLE [dbo].[smtp] (
    [smtp_id]         INT           IDENTITY (1, 1) NOT NULL,
    [host]            VARCHAR (255) NOT NULL,
    [email]           VARCHAR (255) NOT NULL,
    [username]        VARCHAR (255) NOT NULL,
    [password]        VARCHAR (255) NOT NULL,
    [encryption_id]   INT           NOT NULL,
    [port]            INT           NOT NULL,
    [is_active]       BIT           DEFAULT ((1)) NOT NULL,
    [created_on]      DATETIME2 (7) NULL,
    [updated_on]      DATETIME2 (7) DEFAULT (getutcdate()) NULL,
    [created_by]      INT           NULL,
    [updated_by]      INT           NULL,
    [audit_client_id] INT           NULL,
    CONSTRAINT [PK_smtp_smtp_id] PRIMARY KEY CLUSTERED ([smtp_id] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.smtp', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'smtp';

