CREATE TABLE [dbo].[task_note] (
    [task_note_id]    INT           IDENTITY (1, 1) NOT NULL,
    [task_id]         INT           NULL,
    [note_id]         INT           NULL,
    [is_active]       BIT           DEFAULT ((1)) NULL,
    [created_on]      DATETIME2 (7) DEFAULT (getutcdate()) NULL,
    [updated_on]      DATETIME2 (7) DEFAULT (getutcdate()) NULL,
    [created_by]      INT           NULL,
    [updated_by]      INT           NULL,
    [audit_client_id] INT           NULL,
    CONSTRAINT [PK_task_note_task_note_id] PRIMARY KEY CLUSTERED ([task_note_id] ASC),
    CONSTRAINT [FK_task_note_note] FOREIGN KEY ([note_id]) REFERENCES [dbo].[note] ([note_id]),
    CONSTRAINT [FK_task_note_task] FOREIGN KEY ([task_id]) REFERENCES [dbo].[task] ([task_id])
);

