-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE audit_add_remove_table 
	-- Add the parameters for the stored procedure here
		 @table_name varchar(100)
		,@enable bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set xact_abort on;
    -- Insert statements for procedure here
	declare  @SQL nvarchar(max)
			,@triger sysname
	set @triger = 'tr_'+@table_name+'_audit'
	--select @triger

	if @enable = 1
	begin
	---------------------------
	-- create audit tables
	---------------------------
		IF OBJECT_ID(N'dbo.audit_data', N'U') IS NULL
		begin
			 CREATE TABLE [dbo].[audit_data](
				[audit_data_id] [int] IDENTITY(1,1) NOT NULL,
				[table_name] [varchar](100) NULL,
				[action_type] [char](1) NULL,
				[login_name] [varchar](100) NULL,
				[old_values] [nvarchar](max) NULL,
				[new_values] [nvarchar](max) NULL,
				[operation_date] [datetime2](0) NULL,
			PRIMARY KEY CLUSTERED 
			(
				[audit_data_id] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY]


			ALTER TABLE [dbo].[audit_data] ADD  DEFAULT (getutcdate()) FOR [operation_date]

		end

		IF OBJECT_ID(N'dbo.audit_table', N'U') IS NULL
		begin
			 CREATE TABLE [dbo].[audit_table](
				[audit_table_id] [int] IDENTITY(1,1) NOT NULL,
				[table_name] [varchar](100) NULL,
				[enabled] bit NULL,
				[operation_date] [datetime2](0) NULL,
			PRIMARY KEY CLUSTERED 
			(
				[audit_table_id] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY] 


			ALTER TABLE [dbo].[audit_table] ADD  DEFAULT (getutcdate()) FOR [operation_date]

		end



		---------------------
		--Add triger
		---------------------
		set @SQL =
		'
		CREATE TRIGGER '+@triger+'
		   ON  '+@table_name+'
		   AFTER INSERT,UPDATE
		AS 
		BEGIN
			-- SET NOCOUNT ON added to prevent extra result sets from
			-- interfering with SELECT statements.
			SET NOCOUNT ON;

			 IF NOT EXISTS(SELECT 1 FROM deleted) AND NOT EXISTS(SELECT 1 FROM inserted) 
				RETURN;

			declare @tablename varchar(100)
			SELECT @tablename = OBJECT_NAME(parent_object_id) 
						 FROM sys.objects 
						 WHERE sys.objects.name = OBJECT_NAME(@@PROCID)

			/*Action*/
			DECLARE @ActionType char(1)
			IF EXISTS (SELECT * FROM inserted)
				   IF EXISTS (SELECT * FROM deleted)
						   SELECT @ActionType = ''U''
				   ELSE
						   SELECT @ActionType = ''I''
			ELSE
				   SELECT @ActionType = ''D''

			declare @inserted nvarchar(max) , @deleted nvarchar(max)  
			SET @inserted = (SELECT * FROM inserted FOR JSON PATH)
			SET @deleted = (SELECT * FROM deleted FOR JSON PATH)

						 INSERT INTO audit_data([table_name]
											   ,[action_type]
											   ,[login_name]
											   ,[old_values]
											   ,[new_values])
						 SELECT @tablename
							  , @ActionType
							  , SUSER_SNAME()
							  , @deleted
							  , @inserted


		END
		'
		exec (@sql)


		merge [audit_table] as target
			using (select @table_name as table_name
				) as source
			on target.table_name = source.table_name 
			WHEN MATCHED 
				then update set target.enabled = 1
						
			WHEN NOT MATCHED BY TARGET 
				THEN insert (table_name
							,enabled
						   ) 
				values ( source.table_name
						,1
						)
		;

	end
	else
	begin

		IF (OBJECT_ID(@triger) IS NOT NULL)
		BEGIN
			exec('DROP TRIGGER '+@triger)


		END;

		IF OBJECT_ID(N'dbo.audit_table', N'U') IS NOT NULL
			begin
				update audit_table
				set [enabled] = 0
				where [table_name] = @table_name
		end 

	end
END