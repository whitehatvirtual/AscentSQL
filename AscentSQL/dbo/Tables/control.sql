CREATE TABLE [dbo].[control] (
    [control_id]               INT            IDENTITY (1, 1) NOT NULL,
    [control_id_text]          NVARCHAR (255) NULL,
    [description]              NVARCHAR (MAX) NULL,
    [artifacts_example]        NVARCHAR (MAX) NULL,
    [remediation_requirements] NVARCHAR (MAX) NULL,
    [master_control_id]        INT            NULL,
    [section_id]               INT            NULL,
    [frequency_id]             INT            NULL,
    [risk_id]                  INT            NULL,
    [maturity_id]              INT            NULL,
    [type_id]                  INT            NULL,
    [is_active]                BIT            DEFAULT ((1)) NULL,
    [created_on]               DATETIME       NULL,
    [updated_on]               DATETIME       DEFAULT (getdate()) NULL,
    [created_by]               INT            NULL,
    [updated_by]               INT            NULL,
    [audit_client_id]          INT            NULL,
    CONSTRAINT [PK_control_control_id] PRIMARY KEY CLUSTERED ([control_id] ASC),
    CONSTRAINT [FK_control_frequency] FOREIGN KEY ([frequency_id]) REFERENCES [dbo].[frequency] ([frequency_id]),
    CONSTRAINT [FK_control_maturity] FOREIGN KEY ([maturity_id]) REFERENCES [dbo].[maturity] ([maturity_id]),
    CONSTRAINT [FK_control_risk] FOREIGN KEY ([risk_id]) REFERENCES [dbo].[risk] ([risk_id]),
    CONSTRAINT [FK_control_section] FOREIGN KEY ([section_id]) REFERENCES [dbo].[section] ([section_id]),
    CONSTRAINT [FK_control_type] FOREIGN KEY ([type_id]) REFERENCES [dbo].[type] ([type_id])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.control', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'control';

