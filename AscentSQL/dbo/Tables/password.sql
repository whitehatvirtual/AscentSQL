CREATE TABLE [dbo].[password] (
    [password_id]   INT           IDENTITY (1, 1) NOT NULL,
    [user_id]       INT           NOT NULL,
    [password]      VARCHAR (255) NOT NULL,
    [password_salt] VARCHAR (255) NOT NULL,
    [token]         VARCHAR (255) NOT NULL,
    [password_date] DATETIME2 (0) NULL,
    CONSTRAINT [PK_password_password_id] PRIMARY KEY CLUSTERED ([password_id] ASC),
    CONSTRAINT [FK_password_user] FOREIGN KEY ([user_id]) REFERENCES [dbo].[user] ([user_id])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.password', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'password';

