CREATE TABLE [dbo].[client_phone] (
    [client_phone_id] INT IDENTITY (1, 1) NOT NULL,
    [phone_id]        INT NULL,
    [client_id]       INT NULL,
    [phone_type_id]   INT NULL,
    [is_active]       BIT DEFAULT ((1)) NULL,
    CONSTRAINT [PK_client_phone_client_phone_id] PRIMARY KEY CLUSTERED ([client_phone_id] ASC),
    CONSTRAINT [FK_client_phone_client] FOREIGN KEY ([client_id]) REFERENCES [dbo].[client] ([client_id]),
    CONSTRAINT [FK_client_phone_phone] FOREIGN KEY ([phone_id]) REFERENCES [dbo].[phone] ([phone_id])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.client_phone', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'client_phone';

