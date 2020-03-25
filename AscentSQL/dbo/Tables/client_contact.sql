CREATE TABLE [dbo].[client_contact] (
    [client_contact] INT IDENTITY (1, 1) NOT NULL,
    [client_id]      INT NULL,
    [contact_id]     INT NULL,
    [is_active]      BIT DEFAULT ((1)) NULL,
    CONSTRAINT [PK_client_contact_client_contact] PRIMARY KEY CLUSTERED ([client_contact] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.client_contact', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'client_contact';

