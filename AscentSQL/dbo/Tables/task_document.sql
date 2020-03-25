CREATE TABLE [dbo].[task_document] (
    [task_document_id] INT            IDENTITY (1, 1) NOT NULL,
    [task_id]          INT            NULL,
    [document_id]      INT            NULL,
    [description]      NVARCHAR (MAX) NULL,
    [is_active]        BIT            DEFAULT ((1)) NULL,
    [created_on]       DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [updated_on]       DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [created_by]       INT            NULL,
    [updated_by]       INT            NULL,
    [audit_client_id]  INT            NULL,
    CONSTRAINT [PK_task_document_task_document_id] PRIMARY KEY CLUSTERED ([task_document_id] ASC),
    CONSTRAINT [FK_task_document_document] FOREIGN KEY ([document_id]) REFERENCES [dbo].[document] ([document_id]),
    CONSTRAINT [FK_task_document_task] FOREIGN KEY ([task_id]) REFERENCES [dbo].[task] ([task_id])
);

