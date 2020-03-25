CREATE TABLE [dbo].[reference_library] (
    [reference_library_id] INT            IDENTITY (1, 1) NOT NULL,
    [link]                 NVARCHAR (MAX) NULL,
    [document_id]          INT            NULL,
    [is_active]            BIT            DEFAULT ((1)) NULL,
    [created_on]           DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [updated_on]           DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [created_by]           INT            NULL,
    [updated_by]           INT            NULL,
    [audit_client_id]      INT            NULL,
    CONSTRAINT [PK_reference_library] PRIMARY KEY CLUSTERED ([reference_library_id] ASC),
    CONSTRAINT [FK_reference_library_document] FOREIGN KEY ([document_id]) REFERENCES [dbo].[document] ([document_id])
);

