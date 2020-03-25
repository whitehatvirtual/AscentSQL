CREATE TABLE [dbo].[phone] (
    [phone_id]        INT           IDENTITY (1, 1) NOT NULL,
    [phone_no]        NVARCHAR (45) NULL,
    [type_id]         INT           NULL,
    [is_active]       BIT           DEFAULT ((1)) NOT NULL,
    [created_on]      DATETIME2 (7) NULL,
    [updated_on]      DATETIME2 (7) DEFAULT (getutcdate()) NULL,
    [created_by]      INT           NULL,
    [updated_by]      INT           NULL,
    [audit_client_id] INT           NULL,
    CONSTRAINT [PK_phone_phone_id] PRIMARY KEY CLUSTERED ([phone_id] ASC),
    CONSTRAINT [FK_phone_type] FOREIGN KEY ([type_id]) REFERENCES [dbo].[type] ([type_id])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.phone', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'phone';

