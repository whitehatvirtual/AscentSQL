CREATE TABLE [dbo].[detail]
(
	[detail_id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [detail_name] NVARCHAR(255) NULL, 
    [description] NVARCHAR(50) NULL,
    [is_active]       BIT             DEFAULT ((1)) NULL,
    [created_on]      DATETIME2 (7)   DEFAULT (getutcdate()) NULL,
    [updated_on]      DATETIME2 (7)   DEFAULT (getutcdate()) NULL,
    [created_by]      INT             NULL,
    [updated_by]      INT             NULL,
    [audit_client_id] INT             NULL,
)
