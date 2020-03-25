CREATE TABLE [dbo].[answer] (
    [answer_id]   INT            IDENTITY (5, 1) NOT NULL,
    [answer_name] NVARCHAR (255) NULL,
    [type_id]     INT            NULL,
    [factor]      INT            NULL,
    CONSTRAINT [PK_answer_answer_id] PRIMARY KEY CLUSTERED ([answer_id] ASC),
    CONSTRAINT [FK_answer_type] FOREIGN KEY ([type_id]) REFERENCES [dbo].[type] ([type_id])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.answer', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'answer';

