CREATE TABLE [dbo].[user] (
    [user_id]         INT            IDENTITY (1, 1) NOT NULL,
    [first_name]      NVARCHAR (50)  NOT NULL,
    [last_name]       NVARCHAR (50)  NULL,
    [email]           VARCHAR (100)  NOT NULL,
    [job_title]       NVARCHAR (50)  NULL,
    [time_zone]       NVARCHAR (100) NULL,
    [phone_id]        INT            NULL,
    [type_id]         INT            NULL,
    [address_id]      INT            NULL,
    [is_active]       BIT            DEFAULT ((1)) NULL,
    [created_on]      DATETIME2 (7)  NULL,
    [updated_on]      DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [created_by]      INT            NULL,
    [updated_by]      INT            NULL,
    [audit_client_id] INT            NULL,
    CONSTRAINT [PK_user_user_id] PRIMARY KEY CLUSTERED ([user_id] ASC),
    CONSTRAINT [FK_user_address] FOREIGN KEY ([address_id]) REFERENCES [dbo].[address] ([address_id]),
    CONSTRAINT [FK_user_phone] FOREIGN KEY ([phone_id]) REFERENCES [dbo].[phone] ([phone_id]),
    CONSTRAINT [FK_user_type] FOREIGN KEY ([type_id]) REFERENCES [dbo].[type] ([type_id]),
    CONSTRAINT [user$email] UNIQUE NONCLUSTERED ([email] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.`user`', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'user';

