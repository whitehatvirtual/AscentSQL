CREATE TABLE [dbo].[note] (
    [note_id]         INT            IDENTITY (1, 1) NOT NULL,
    [note_text]       NVARCHAR (MAX) NULL,
    [type_id]         INT            NULL,
    [is_active]       BIT            DEFAULT ((1)) NULL,
    [created_on]      DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [updated_on]      DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [created_by]      INT            NULL,
    [updated_by]      INT            NULL,
    [audit_client_id] INT            NULL,
    CONSTRAINT [PK_note] PRIMARY KEY CLUSTERED ([note_id] ASC),
    CONSTRAINT [FK_note_type] FOREIGN KEY ([type_id]) REFERENCES [dbo].[type] ([type_id])
);

