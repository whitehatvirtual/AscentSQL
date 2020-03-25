CREATE TABLE [dbo].[user_client] (
    [user_client_id]  INT           IDENTITY (1, 1) NOT NULL,
    [user_id]         INT           NULL,
    [client_id]       INT           NULL,
    [is_active]       BIT           DEFAULT ((1)) NULL,
    [created_on]      DATETIME2 (7) DEFAULT (getutcdate()) NULL,
    [updated_on]      DATETIME2 (7) DEFAULT (getutcdate()) NULL,
    [created_by]      INT           NULL,
    [updated_by]      INT           NULL,
    [audit_client_id] INT           NULL,
    CONSTRAINT [PK_user_client_user_client_id] PRIMARY KEY CLUSTERED ([user_client_id] ASC),
    CONSTRAINT [FK_user_client_client] FOREIGN KEY ([client_id]) REFERENCES [dbo].[client] ([client_id]),
    CONSTRAINT [FK_user_client_user] FOREIGN KEY ([user_id]) REFERENCES [dbo].[user] ([user_id])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.user_client', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'user_client';

