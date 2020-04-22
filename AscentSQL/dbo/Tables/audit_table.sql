CREATE TABLE [dbo].[audit_table] (
    [audit_table_id] INT           IDENTITY (1, 1) NOT NULL,
    [table_name]     VARCHAR (100) NULL,
    [enabled]        BIT           NULL,
    [operation_date] DATETIME2 (0) DEFAULT (getutcdate()) NULL,
    PRIMARY KEY CLUSTERED ([audit_table_id] ASC)
);

