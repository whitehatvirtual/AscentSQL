CREATE TABLE [dbo].[address] (
    [address_id]      INT            IDENTITY (1, 1) NOT NULL,
    [street]          NVARCHAR (255) NULL,
    [city]            NVARCHAR (255) NULL,
    [state]           NVARCHAR (255) NULL,
    [country]         NVARCHAR (255) NULL,
    [zip]             NVARCHAR (20)  NULL,
    [is_active]       BIT            DEFAULT ((1)) NULL,
    [created_on]      DATETIME2 (7)  CONSTRAINT [DF_address_created_on] DEFAULT (getutcdate()) NULL,
    [updated_on]      DATETIME2 (7)  CONSTRAINT [DF_address_updated_on] DEFAULT (getutcdate()) NULL,
    [created_by]      INT            NULL,
    [updated_by]      INT            NULL,
    [audit_client_id] INT            NULL,
    CONSTRAINT [PK_address_address_id] PRIMARY KEY CLUSTERED ([address_id] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.address', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'address';

