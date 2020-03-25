CREATE TABLE [dbo].[contact] (
    [contact_id]   INT            IDENTITY (1, 1) NOT NULL,
    [contact_name] NVARCHAR (255) NULL,
    [email]        NVARCHAR (100) NULL,
    [phone_id]     INT            NULL,
    [is_active]    BIT            DEFAULT ((1)) NULL,
    CONSTRAINT [PK_contact_contact_id] PRIMARY KEY CLUSTERED ([contact_id] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.contact', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'contact';

