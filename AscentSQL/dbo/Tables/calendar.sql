CREATE TABLE [dbo].[calendar] (
    [calendar_id]   INT           IDENTITY (1, 1) NOT NULL,
    [calendar_date] DATETIME2 (0) NULL,
    [task_id]       INT           NULL,
    CONSTRAINT [PK_calendar_calendar_id] PRIMARY KEY CLUSTERED ([calendar_id] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.calendar', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'calendar';

