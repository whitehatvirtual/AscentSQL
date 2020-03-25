CREATE TABLE [dbo].[client] (
    [client_id]        INT            IDENTITY (1, 1) NOT NULL,
    [client_name]      NVARCHAR (255) NULL,
    [email]            NVARCHAR (255) NULL,
    [time_zone]        VARCHAR (100)  NULL,
    [logo_document_id] INT            NULL,
    [address_id]       INT            NULL,
    [service_tier_id]  INT            NULL,
    [type_id]          INT            NULL,
    [is_active]        BIT            DEFAULT ((1)) NULL,
    [created_on]       DATETIME       DEFAULT (getdate()) NULL,
    [updated_on]       DATETIME       DEFAULT (getdate()) NULL,
    [created_by]       INT            NULL,
    [updated_by]       INT            NULL,
    CONSTRAINT [PK_client_client_id] PRIMARY KEY CLUSTERED ([client_id] ASC),
    CONSTRAINT [FK_client_address] FOREIGN KEY ([address_id]) REFERENCES [dbo].[address] ([address_id]),
    CONSTRAINT [FK_client_service_tier] FOREIGN KEY ([service_tier_id]) REFERENCES [dbo].[service_tier] ([service_tier_id]),
    CONSTRAINT [FK_client_type] FOREIGN KEY ([type_id]) REFERENCES [dbo].[type] ([type_id])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.client', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'client';

