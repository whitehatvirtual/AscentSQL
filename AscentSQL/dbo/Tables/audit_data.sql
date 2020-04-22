CREATE TABLE [dbo].[audit_data] (
    [audit_data_id]  INT            IDENTITY (1, 1) NOT NULL,
    [table_name]     VARCHAR (100)  NULL,
    [action_type]    CHAR (1)       NULL,
    [login_name]     VARCHAR (100)  NULL,
    [old_values]     NVARCHAR (MAX) NULL,
    [new_values]     NVARCHAR (MAX) NULL,
    [operation_date] DATETIME2 (0)  DEFAULT (getutcdate()) NULL,
    PRIMARY KEY CLUSTERED ([audit_data_id] ASC)
);

