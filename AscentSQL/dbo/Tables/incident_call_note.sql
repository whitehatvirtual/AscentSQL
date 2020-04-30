CREATE TABLE [dbo].[incident_call_note] (
    [incident_call_note_id] INT             IDENTITY (1, 1) NOT NULL,
    [incident_id]           INT             NULL,
    [note_date_time]        DATETIME2 (7)   NULL,
    [attendees]             NVARCHAR (1000) NULL,
    [os]                    NVARCHAR (1000) NULL,
    [action_item_previous]  NVARCHAR (1000) NULL,
    [action_item_current]   NVARCHAR (1000) NULL,
    [next_meeting]          DATETIME2 (7)   NULL,
    CONSTRAINT [PK_incident_call_note] PRIMARY KEY CLUSTERED ([incident_call_note_id] ASC)
);

