CREATE TABLE [dbo].[news] (
    [news_id]         INT           IDENTITY (1, 1) NOT NULL,
    [news_title]      VARCHAR (255) NOT NULL,
    [description]     VARCHAR (MAX) NOT NULL,
    [is_active]       BIT           DEFAULT ((1)) NULL,
    [created_on]      DATETIME2 (7) NULL,
    [updated_on]      DATETIME2 (7) DEFAULT (getutcdate()) NULL,
    [created_by]      INT           NOT NULL,
    [updated_by]      INT           NOT NULL,
    [audit_client_id] INT           NOT NULL,
    CONSTRAINT [PK_news_news_id] PRIMARY KEY CLUSTERED ([news_id] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.news', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'news';

