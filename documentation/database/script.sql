USE [master]
GO
/****** Object:  Database [OnlineExamSystem]    Script Date: 23/03/2017 10:38:49 PM ******/
CREATE DATABASE [OnlineExamSystem]
GO
USE [OnlineExamSystem]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 23/03/2017 10:38:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	
GO
/****** Object:  Table [dbo].[Account]    Script Date: 23/03/2017 10:38:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[username] [varchar](255) NOT NULL,
	[password] [varchar](128) NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Account_Role]    Script Date: 23/03/2017 10:38:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account_Role](
	[username] [varchar](255) NOT NULL,
	[role] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC,
	[role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[AccountProfile]    Script Date: 23/03/2017 10:38:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountProfile](
	[username] [varchar](255) NOT NULL,
	[birthdate] [date] NULL,
	[email] [varchar](255) NULL,
	[fullName] [nvarchar](255) NOT NULL,
	[gender] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Attempt]    Script Date: 23/03/2017 10:38:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attempt](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[endTime] [datetime2](7) NULL,
	[score] [float] NULL,
	[startTime] [datetime2](7) NULL,
	[examinee] [varchar](255) NULL,
	[testId] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Attempt_Choice]    Script Date: 23/03/2017 10:38:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attempt_Choice](
	[attemptId] [bigint] NOT NULL,
	[choiceId] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[attemptId] ASC,
	[choiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Choice]    Script Date: 23/03/2017 10:38:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Choice](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[content] [nvarchar](max) NULL,
	[correct] [bit] NULL,
	[questionId] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Course]    Script Date: 23/03/2017 10:38:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[id] [varchar](30) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Question]    Script Date: 23/03/2017 10:38:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[content] [nvarchar](max) NULL,
	[courseId] [varchar](30) NULL,
	[owner] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Role]    Script Date: 23/03/2017 10:38:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[name] [varchar](30) NOT NULL,
	[description] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 23/03/2017 10:38:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Test]    Script Date: 23/03/2017 10:38:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Test](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[attemptLimit] [int] NULL,
	[joinEndTime] [datetime2](7) NULL,
	[joinStartTime] [datetime2](7) NULL,
	[name] [nvarchar](255) NULL,
	[restricted] [bit] NULL,
	[timeLength] [int] NULL,
	[owner] [varchar](255) NULL,
	[courseId] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Test_Examinee]    Script Date: 23/03/2017 10:38:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Test_Examinee](
	[testId] [bigint] NOT NULL,
	[examinee] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[testId] ASC,
	[examinee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Test_Question]    Script Date: 23/03/2017 10:38:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Test_Question](
	[testId] [bigint] NOT NULL,
	[questionId] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[testId] ASC,
	[questionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
INSERT [dbo].[Account] ([username], [password]) VALUES (N'admin', N'c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3eab1d80b931dd472634dfac71cd34ebc35d16ab7fb8a90c81f975113d6c7538dc69dd8de9077ec')
INSERT [dbo].[Account] ([username], [password]) VALUES (N'binhdvsb01958@fpt.edu.vn', N'4da3909ffd17d75deefca79b1a6a50522a885ee8f4bbe111d61fe33031e6d7915828f33a03fbd6a2c2ce29a62eb0e4c149abde5821d83bd1deef0bdaafd97083')
INSERT [dbo].[Account] ([username], [password]) VALUES (N'canhkdse04533@fpt.edu.vn', N'aba13ea2852c26729468544a2823b3648ace742a94ab0151c8f8ed8242dd302b95719fc39d94f66019f43e76950cb7d21cd048e52d32c7bbd42796ff7173a449')
INSERT [dbo].[Account] ([username], [password]) VALUES (N'haindse04546@fpt.edu.vn', N'80b5912c77f1e4580173f6b3717746ba53757c23bce2defa0723e2d237df994659d977f88ade54dd8e18be7ae56376c268fd46dbac92d22d602d83fa37450d79')
INSERT [dbo].[Account] ([username], [password]) VALUES (N'lampdse04797@fpt.edu.vn', N'd492dfeb3d3aa5a8362318a3c7e3227571e4b6ffdd2c31cf5412aa4218c6cf2e8c9d7e61d4ce23668cdc28b55948fa1856f80f0c476c7e5f88874892fdffac66')
INSERT [dbo].[Account] ([username], [password]) VALUES (N'minhnqse04781@fpt.edu.vn', N'c462fe6296989812d9d3e83e4c9f69a34c1b5364d338b0b13f459d3d497a4f4a33528b54b3435fbab0af6ebae4c1a8eaef70f9ad93ff078924a3bacc5b069fba')
INSERT [dbo].[Account] ([username], [password]) VALUES (N'nguyenlcse04555@fpt.edu.vn', N'5008c3c58c41131980194647854c69ac36644226ed2522926e2eee2ed97f5d488849746d6680bd22782473d1239b74c1b739f15ee95828da1653e52532e41375')
INSERT [dbo].[Account_Role] ([username], [role]) VALUES (N'admin', N'admin')
INSERT [dbo].[Account_Role] ([username], [role]) VALUES (N'binhdvsb01958@fpt.edu.vn', N'testmaster')
INSERT [dbo].[Account_Role] ([username], [role]) VALUES (N'canhkdse04533@fpt.edu.vn', N'testmaster')
INSERT [dbo].[Account_Role] ([username], [role]) VALUES (N'haindse04546@fpt.edu.vn', N'testmaster')
INSERT [dbo].[Account_Role] ([username], [role]) VALUES (N'lampdse04797@fpt.edu.vn', N'student')
INSERT [dbo].[Account_Role] ([username], [role]) VALUES (N'minhnqse04781@fpt.edu.vn', N'student')
INSERT [dbo].[Account_Role] ([username], [role]) VALUES (N'nguyenlcse04555@fpt.edu.vn', N'testmaster')
INSERT [dbo].[AccountProfile] ([username], [birthdate], [email], [fullName], [gender]) VALUES (N'admin', CAST(N'1969-09-06' AS Date), N'nguyenlc1993@gmail.com', N'Tao là boss', 1)
INSERT [dbo].[AccountProfile] ([username], [birthdate], [email], [fullName], [gender]) VALUES (N'binhdvsb01958@fpt.edu.vn', CAST(N'1997-01-17' AS Date), N'binhdvsb01958@fpt.edu.vn', N'Doãn Văn Bình', 0)
INSERT [dbo].[AccountProfile] ([username], [birthdate], [email], [fullName], [gender]) VALUES (N'canhkdse04533@fpt.edu.vn', CAST(N'1997-02-17' AS Date), N'canhkdse04533@fpt.edu.vn', N'Khổng Đức Cảnh', 1)
INSERT [dbo].[AccountProfile] ([username], [birthdate], [email], [fullName], [gender]) VALUES (N'haindse04546@fpt.edu.vn', CAST(N'1997-10-15' AS Date), N'haindse04546@fpt.edu.vn', N'Nguyễn Duy Hải', 1)
INSERT [dbo].[AccountProfile] ([username], [birthdate], [email], [fullName], [gender]) VALUES (N'lampdse04797@fpt.edu.vn', CAST(N'1997-05-10' AS Date), N'lampdse04797@fpt.edu.vn', N'Phan Đăng Lâm', 1)
INSERT [dbo].[AccountProfile] ([username], [birthdate], [email], [fullName], [gender]) VALUES (N'minhnqse04781@fpt.edu.vn', CAST(N'1997-07-12' AS Date), N'minhnqse04781@fpt.edu.vn', N'Nguyễn Quang Minh', 1)
INSERT [dbo].[AccountProfile] ([username], [birthdate], [email], [fullName], [gender]) VALUES (N'nguyenlcse04555@fpt.edu.vn', CAST(N'1993-12-26' AS Date), N'nguyenlcse04555@fpt.edu.vn', N'Lê Cao Nguyên', 1)
SET IDENTITY_INSERT [dbo].[Attempt] ON 

INSERT [dbo].[Attempt] ([id], [endTime], [score], [startTime], [examinee], [testId]) VALUES (12, CAST(N'2017-03-22T00:30:48.2000000' AS DateTime2), 7, CAST(N'2017-03-22T00:30:24.9560000' AS DateTime2), N'minhnqse04781@fpt.edu.vn', 27)
INSERT [dbo].[Attempt] ([id], [endTime], [score], [startTime], [examinee], [testId]) VALUES (21, CAST(N'2017-03-22T04:45:32.8090000' AS DateTime2), 0.66666666666666663, CAST(N'2017-03-22T04:44:41.0070000' AS DateTime2), N'lampdse04797@fpt.edu.vn', 28)
INSERT [dbo].[Attempt] ([id], [endTime], [score], [startTime], [examinee], [testId]) VALUES (22, CAST(N'2017-03-22T04:50:20.2870000' AS DateTime2), 7.333333333333333, CAST(N'2017-03-22T04:47:22.4960000' AS DateTime2), N'minhnqse04781@fpt.edu.vn', 28)
INSERT [dbo].[Attempt] ([id], [endTime], [score], [startTime], [examinee], [testId]) VALUES (23, CAST(N'2017-03-22T04:56:10.7300000' AS DateTime2), 2.3333333333333335, CAST(N'2017-03-22T04:53:32.9030000' AS DateTime2), N'binhdvsb01958@fpt.edu.vn', 28)
INSERT [dbo].[Attempt] ([id], [endTime], [score], [startTime], [examinee], [testId]) VALUES (24, CAST(N'2017-03-22T05:41:34.0280000' AS DateTime2), 2.5, CAST(N'2017-03-22T05:40:36.1160000' AS DateTime2), N'lampdse04797@fpt.edu.vn', 29)
INSERT [dbo].[Attempt] ([id], [endTime], [score], [startTime], [examinee], [testId]) VALUES (25, CAST(N'2017-03-22T05:42:15.5020000' AS DateTime2), 0, CAST(N'2017-03-22T05:42:07.3840000' AS DateTime2), N'lampdse04797@fpt.edu.vn', 29)
INSERT [dbo].[Attempt] ([id], [endTime], [score], [startTime], [examinee], [testId]) VALUES (26, CAST(N'2017-03-22T06:45:45.1370000' AS DateTime2), 3.75, CAST(N'2017-03-22T06:40:44.2460000' AS DateTime2), N'minhnqse04781@fpt.edu.vn', 30)
INSERT [dbo].[Attempt] ([id], [endTime], [score], [startTime], [examinee], [testId]) VALUES (27, CAST(N'2017-03-22T07:55:58.6340000' AS DateTime2), 10, CAST(N'2017-03-22T07:54:57.4580000' AS DateTime2), N'minhnqse04781@fpt.edu.vn', 31)
INSERT [dbo].[Attempt] ([id], [endTime], [score], [startTime], [examinee], [testId]) VALUES (28, CAST(N'2017-03-22T07:59:19.7520000' AS DateTime2), 2, CAST(N'2017-03-22T07:58:41.9540000' AS DateTime2), N'lampdse04797@fpt.edu.vn', 31)
SET IDENTITY_INSERT [dbo].[Attempt] OFF
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (12, 1)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (12, 6)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (12, 7)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (12, 14)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (12, 15)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (21, 1)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (21, 3)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (21, 8)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (21, 14)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (21, 17)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (22, 1)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (22, 5)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (22, 6)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (22, 7)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (22, 14)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (22, 15)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (22, 26)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (22, 28)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (22, 32)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (22, 37)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (22, 41)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (22, 43)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (22, 50)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (22, 86)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (22, 89)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (22, 94)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (23, 2)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (23, 5)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (23, 8)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (23, 14)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (23, 15)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (24, 53)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (24, 57)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (24, 65)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (24, 69)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (24, 71)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (24, 78)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (24, 82)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (26, 53)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (26, 61)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (26, 63)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (26, 68)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (26, 73)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (26, 76)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (26, 80)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (26, 98)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (27, 2)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (27, 5)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (27, 6)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (27, 7)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (27, 14)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (27, 15)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (28, 2)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (28, 3)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (28, 4)
INSERT [dbo].[Attempt_Choice] ([attemptId], [choiceId]) VALUES (28, 11)
SET IDENTITY_INSERT [dbo].[Choice] ON 

INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (1, N'True', 0, 1)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (2, N'False', 1, 1)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (3, N'8 bit', 0, 2)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (4, N'16 bit', 0, 2)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (5, N'32 bit', 1, 2)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (6, N'64 bit', 1, 2)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (7, N'0.0', 1, 3)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (8, N'0', 0, 3)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (9, N'null', 0, 3)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (10, N'undefined', 0, 3)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (11, N'+', 0, 5)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (12, N' -', 0, 5)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (13, N'*', 0, 5)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (14, N'%', 1, 5)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (15, N'DriverManager', 1, 6)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (16, N'Driver', 0, 6)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (17, N'ODBCDriver', 0, 6)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (18, N'None of the other', 0, 6)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (23, N' super', 0, 8)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (24, N' this', 0, 8)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (25, N'extent', 0, 8)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (26, N'extends', 1, 8)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (27, N'upper', 0, 9)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (28, N'super', 1, 9)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (29, N'this', 0, 9)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (30, N' None of the mentioned', 0, 9)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (31, N'public member', 0, 10)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (32, N'private member', 1, 10)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (33, N'protected member', 0, 10)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (34, N'static member', 0, 10)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (35, N'class B + class A {}', 0, 11)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (36, N'class B inherits class A {}', 0, 11)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (37, N'class B extends A {}', 1, 11)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (38, N'class B extends class A {}', 0, 11)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (39, N'public members of class can be accessed by any code in the program.', 0, 12)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (40, N'private members of class can only be accessed by other members of the class.', 0, 12)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (41, N'private members of class can be inherited by a sub class, and become protected members in sub class.', 1, 12)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (42, N'protected members of a class can be inherited by a sub class, and become private members of the sub class.', 0, 12)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (43, N'class', 1, 13)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (44, N'object', 0, 13)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (45, N'variable', 0, 13)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (46, N'character array', 0, 13)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (47, N'char()', 0, 14)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (48, N'Charat()', 0, 14)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (49, N'charat()', 0, 14)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (50, N'charAt()', 1, 14)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (51, N'Unsigned integer of at least 64 bits', 0, 15)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (52, N'Signed integer of at least 16 bits', 0, 15)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (53, N'Unsigned integer of at least 16 bits', 1, 15)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (54, N'Signed integer of at least 64 bits', 0, 15)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (55, N'x = x | (x-1)', 0, 16)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (56, N'x = x & (x-1)', 1, 16)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (57, N'x = x | (x+1)', 0, 16)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (58, N'x = x & (x+1)', 0, 16)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (59, N' It contains a state.', 0, 17)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (60, N'It is a type', 0, 17)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (61, N'Both a & b', 1, 17)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (62, N'None of the mentioned', 0, 17)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (63, N'&lt;function&gt;', 0, 18)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (64, N' &lt;functional&gt;', 1, 18)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (65, N'&lt;funct&gt;', 0, 18)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (66, N'&lt;functionstream&gt;', 0, 18)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (67, N'1', 0, 19)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (68, N'2', 0, 19)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (69, N'3', 0, 19)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (70, N'4', 1, 19)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (71, N'Iterators', 0, 20)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (72, N'Pointers', 0, 20)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (73, N'Both a & b', 1, 20)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (74, N'None of the mentioned', 0, 20)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (75, N'1', 0, 21)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (76, N'2', 0, 21)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (77, N'3', 0, 21)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (78, N'3 or 4', 1, 21)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (79, N'Range', 1, 22)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (80, N'Vector', 0, 22)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (81, N'List', 0, 22)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (82, N'All of the mentioned', 0, 22)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (83, N'super(void);', 1, 23)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (84, N'superclass.();', 0, 23)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (85, N'super.A();', 0, 23)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (86, N'super();', 0, 23)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (87, N'Abstraction', 1, 24)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (88, N'Encapsulation', 0, 24)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (89, N'Polymorphism', 0, 24)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (90, N'None of the mentioned', 0, 24)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (91, N'Objectcopy()', 1, 25)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (92, N' copy()', 0, 25)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (93, N'Object clone()', 0, 25)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (94, N'clone()', 0, 25)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (95, N'+', 1, 26)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (96, N'^', 0, 26)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (97, N'&', 0, 26)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (98, N'*', 0, 26)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (99, N'A', 1, 27)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (100, N'B', 0, 27)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (101, N'C', 0, 27)
INSERT [dbo].[Choice] ([id], [content], [correct], [questionId]) VALUES (102, N'D', 0, 27)
SET IDENTITY_INSERT [dbo].[Choice] OFF
GO
INSERT [dbo].[Course] ([id], [name]) VALUES (N'PRF192', N'Fundamental programming in C')
INSERT [dbo].[Course] ([id], [name]) VALUES (N'PRO001', N'Programming with Alice')
INSERT [dbo].[Course] ([id], [name]) VALUES (N'PRO192', N'Object-oriented programming with Java')
SET IDENTITY_INSERT [dbo].[Question] ON 

INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (1, N'Can we compare int variable with a boolean variable?', N'PRO192', N'nguyenlcse04555@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (2, N'What is the size of floating-point variable?', N'PRO192', N'nguyenlcse04555@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (3, N'What is the default value of short variable?', N'PRO192', N'nguyenlcse04555@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (5, N'Which of the following operations might throw an ArithmeticException?', N'PRO192', N'nguyenlcse04555@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (6, N'The ____ class is the primary class that has the driver information.', N'PRO192', N'nguyenlcse04555@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (8, N'Which of these keyword must be used to inherit a class?', N'PRO192', N'canhkdse04533@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (9, N'Which of these keywords is used to refer to member of base class from a sub class?', N'PRO192', N'canhkdse04533@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (10, N'A class member declared protected becomes member of subclass of which type?', N'PRO192', N'canhkdse04533@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (11, N'Which of these is correct way of inheriting class A by class B?', N'PRO192', N'canhkdse04533@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (12, N'Which of the following statements are incorrect?', N'PRO192', N'canhkdse04533@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (13, N'String in Java is a?', N'PRO192', N'canhkdse04533@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (14, N'Which of these method of String class is used to obtain character at specified index?', N'PRO192', N'canhkdse04533@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (15, N'The size_t integer type in C++ is?', N'PRF192', N'canhkdse04533@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (16, N'Which of these expressions will make the rightmost set bit zero in an input integer x?', N'PRF192', N'canhkdse04533@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (17, N'What are the two advantage of function objects than the function call?', N'PRF192', N'canhkdse04533@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (18, N' Which header is need to be used with function objects?', N'PRF192', N'canhkdse04533@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (19, N'How many parameters does a operator() in a function object shoud take?', N'PRF192', N'canhkdse04533@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (20, N'How does a sequence of objects are accessed in c++?', N'PRF192', N'canhkdse04533@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (21, N'How many parameters are present in mismatch method in non-sequence modifying algorithm?', N'PRF192', N'canhkdse04533@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (22, N'To what kind of elements does non-modifying sequence algorithm can be applied?', N'PRF192', N'canhkdse04533@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (23, N'Which of these is correct way of calling a constructor having no parameters, of superclass A by subclass B?', N'PRO192', N'canhkdse04533@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (24, N'Which of these is supported by method overriding in Java?', N'PRO192', N'canhkdse04533@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (25, N'Which of these method of Object class can clone an object?', N'PRO192', N'canhkdse04533@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (26, N'Which operator is used to dereference a pointer?', N'PRF192', N'nguyenlcse04555@fpt.edu.vn')
INSERT [dbo].[Question] ([id], [content], [courseId], [owner]) VALUES (27, N'ABCDEF', N'PRO192', N'nguyenlcse04555@fpt.edu.vn')
SET IDENTITY_INSERT [dbo].[Question] OFF
INSERT [dbo].[Role] ([name], [description]) VALUES (N'admin', N'Administrator')
INSERT [dbo].[Role] ([name], [description]) VALUES (N'student', N'Student')
INSERT [dbo].[Role] ([name], [description]) VALUES (N'testmaster', N'Test Master')
SET IDENTITY_INSERT [dbo].[Test] ON 

INSERT [dbo].[Test] ([id], [attemptLimit], [joinEndTime], [joinStartTime], [name], [restricted], [timeLength], [owner], [courseId]) VALUES (4, 5, CAST(N'2017-03-20T04:00:00.0000000' AS DateTime2), CAST(N'2017-03-20T03:20:00.0000000' AS DateTime2), N'Progress Test 1', 0, 30, N'canhkdse04533@fpt.edu.vn', N'PRO192')
INSERT [dbo].[Test] ([id], [attemptLimit], [joinEndTime], [joinStartTime], [name], [restricted], [timeLength], [owner], [courseId]) VALUES (9, 2, CAST(N'2017-03-20T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-20T23:59:00.0000000' AS DateTime2), N'Mid-term Test', 1, 30, N'canhkdse04533@fpt.edu.vn', N'PRO192')
INSERT [dbo].[Test] ([id], [attemptLimit], [joinEndTime], [joinStartTime], [name], [restricted], [timeLength], [owner], [courseId]) VALUES (27, 3, CAST(N'2017-03-22T00:30:00.0000000' AS DateTime2), CAST(N'2017-03-22T00:00:00.0000000' AS DateTime2), N'Progress Test 2', 1, 30, N'nguyenlcse04555@fpt.edu.vn', N'PRF192')
INSERT [dbo].[Test] ([id], [attemptLimit], [joinEndTime], [joinStartTime], [name], [restricted], [timeLength], [owner], [courseId]) VALUES (28, 5, CAST(N'2017-03-22T08:30:00.0000000' AS DateTime2), CAST(N'2017-03-22T00:00:00.0000000' AS DateTime2), N'Final Exam', 1, 45, N'canhkdse04533@fpt.edu.vn', N'PRO192')
INSERT [dbo].[Test] ([id], [attemptLimit], [joinEndTime], [joinStartTime], [name], [restricted], [timeLength], [owner], [courseId]) VALUES (29, 2, CAST(N'2017-03-22T08:30:00.0000000' AS DateTime2), CAST(N'2017-03-22T00:00:00.0000000' AS DateTime2), N'Public Exam', 0, 30, N'canhkdse04533@fpt.edu.vn', N'PRF192')
INSERT [dbo].[Test] ([id], [attemptLimit], [joinEndTime], [joinStartTime], [name], [restricted], [timeLength], [owner], [courseId]) VALUES (30, 1, CAST(N'2017-03-22T09:00:00.0000000' AS DateTime2), CAST(N'2017-03-22T06:00:00.0000000' AS DateTime2), N'PRF192 Final (Spring 2017)', 1, 5, N'nguyenlcse04555@fpt.edu.vn', N'PRF192')
INSERT [dbo].[Test] ([id], [attemptLimit], [joinEndTime], [joinStartTime], [name], [restricted], [timeLength], [owner], [courseId]) VALUES (31, 1, CAST(N'2017-03-22T08:15:59.0000000' AS DateTime2), CAST(N'2017-03-22T07:45:00.0000000' AS DateTime2), N'PRO192 Final', 1, 15, N'nguyenlcse04555@fpt.edu.vn', N'PRO192')
SET IDENTITY_INSERT [dbo].[Test] OFF
INSERT [dbo].[Test_Examinee] ([testId], [examinee]) VALUES (27, N'binhdvsb01958@fpt.edu.vn')
INSERT [dbo].[Test_Examinee] ([testId], [examinee]) VALUES (27, N'lampdse04797@fpt.edu.vn')
INSERT [dbo].[Test_Examinee] ([testId], [examinee]) VALUES (27, N'minhnqse04781@fpt.edu.vn')
INSERT [dbo].[Test_Examinee] ([testId], [examinee]) VALUES (28, N'binhdvsb01958@fpt.edu.vn')
INSERT [dbo].[Test_Examinee] ([testId], [examinee]) VALUES (28, N'lampdse04797@fpt.edu.vn')
INSERT [dbo].[Test_Examinee] ([testId], [examinee]) VALUES (28, N'minhnqse04781@fpt.edu.vn')
INSERT [dbo].[Test_Examinee] ([testId], [examinee]) VALUES (30, N'binhdvsb01958@fpt.edu.vn')
INSERT [dbo].[Test_Examinee] ([testId], [examinee]) VALUES (30, N'lampdse04797@fpt.edu.vn')
INSERT [dbo].[Test_Examinee] ([testId], [examinee]) VALUES (30, N'minhnqse04781@fpt.edu.vn')
INSERT [dbo].[Test_Examinee] ([testId], [examinee]) VALUES (31, N'binhdvsb01958@fpt.edu.vn')
INSERT [dbo].[Test_Examinee] ([testId], [examinee]) VALUES (31, N'lampdse04797@fpt.edu.vn')
INSERT [dbo].[Test_Examinee] ([testId], [examinee]) VALUES (31, N'minhnqse04781@fpt.edu.vn')
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (4, 1)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (27, 1)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (27, 2)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (27, 3)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (27, 5)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (27, 6)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (28, 1)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (28, 2)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (28, 3)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (28, 5)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (28, 6)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (28, 8)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (28, 9)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (28, 10)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (28, 11)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (28, 12)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (28, 13)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (28, 14)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (28, 23)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (28, 24)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (28, 25)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (29, 15)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (29, 16)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (29, 17)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (29, 18)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (29, 19)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (29, 20)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (29, 21)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (29, 22)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (30, 15)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (30, 17)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (30, 18)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (30, 19)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (30, 20)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (30, 21)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (30, 22)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (30, 26)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (31, 1)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (31, 2)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (31, 3)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (31, 5)
INSERT [dbo].[Test_Question] ([testId], [questionId]) VALUES (31, 6)
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_principal_name]    Script Date: 23/03/2017 10:39:07 PM ******/
ALTER TABLE [dbo].[sysdiagrams] ADD  CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
ALTER TABLE [dbo].[Account_Role]  WITH CHECK ADD  CONSTRAINT [FK_6t4hg7bk6timmnif1xkmhdmbv] FOREIGN KEY([role])
REFERENCES [dbo].[Role] ([name])
GO
ALTER TABLE [dbo].[Account_Role] CHECK CONSTRAINT [FK_6t4hg7bk6timmnif1xkmhdmbv]
GO
ALTER TABLE [dbo].[Account_Role]  WITH CHECK ADD  CONSTRAINT [FK_a27vrsjryr0cq299ilwiy7rw8] FOREIGN KEY([username])
REFERENCES [dbo].[Account] ([username])
GO
ALTER TABLE [dbo].[Account_Role] CHECK CONSTRAINT [FK_a27vrsjryr0cq299ilwiy7rw8]
GO
ALTER TABLE [dbo].[AccountProfile]  WITH CHECK ADD  CONSTRAINT [FK_14jqyqaawdwt9xkvdn39rpk7t] FOREIGN KEY([username])
REFERENCES [dbo].[Account] ([username])
GO
ALTER TABLE [dbo].[AccountProfile] CHECK CONSTRAINT [FK_14jqyqaawdwt9xkvdn39rpk7t]
GO
ALTER TABLE [dbo].[Attempt]  WITH CHECK ADD  CONSTRAINT [FK_66pdikkd8yffgyxh0yln6wvq6] FOREIGN KEY([examinee])
REFERENCES [dbo].[Account] ([username])
GO
ALTER TABLE [dbo].[Attempt] CHECK CONSTRAINT [FK_66pdikkd8yffgyxh0yln6wvq6]
GO
ALTER TABLE [dbo].[Attempt]  WITH CHECK ADD  CONSTRAINT [FK_adtfqwhiyjscvbjyvdr3xcb94] FOREIGN KEY([testId])
REFERENCES [dbo].[Test] ([id])
GO
ALTER TABLE [dbo].[Attempt] CHECK CONSTRAINT [FK_adtfqwhiyjscvbjyvdr3xcb94]
GO
ALTER TABLE [dbo].[Attempt_Choice]  WITH CHECK ADD  CONSTRAINT [FK_gfxyw1ctspnu1v6vd1v7mk4iu] FOREIGN KEY([choiceId])
REFERENCES [dbo].[Choice] ([id])
GO
ALTER TABLE [dbo].[Attempt_Choice] CHECK CONSTRAINT [FK_gfxyw1ctspnu1v6vd1v7mk4iu]
GO
ALTER TABLE [dbo].[Attempt_Choice]  WITH CHECK ADD  CONSTRAINT [FK_r635w4cr1n6q95pd5r62nn7sf] FOREIGN KEY([attemptId])
REFERENCES [dbo].[Attempt] ([id])
GO
ALTER TABLE [dbo].[Attempt_Choice] CHECK CONSTRAINT [FK_r635w4cr1n6q95pd5r62nn7sf]
GO
ALTER TABLE [dbo].[Choice]  WITH CHECK ADD  CONSTRAINT [FK_ltu6vs6dbyb65myiy66641qep] FOREIGN KEY([questionId])
REFERENCES [dbo].[Question] ([id])
GO
ALTER TABLE [dbo].[Choice] CHECK CONSTRAINT [FK_ltu6vs6dbyb65myiy66641qep]
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK_40mi5hkxdn2b4xf96d2a7y6us] FOREIGN KEY([owner])
REFERENCES [dbo].[Account] ([username])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK_40mi5hkxdn2b4xf96d2a7y6us]
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK_kxkijfooq60g6qo41xogm07b1] FOREIGN KEY([courseId])
REFERENCES [dbo].[Course] ([id])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK_kxkijfooq60g6qo41xogm07b1]
GO
ALTER TABLE [dbo].[Test]  WITH CHECK ADD  CONSTRAINT [FK_8iw8in8qsoj2jhq85rj1ue3t3] FOREIGN KEY([courseId])
REFERENCES [dbo].[Course] ([id])
GO
ALTER TABLE [dbo].[Test] CHECK CONSTRAINT [FK_8iw8in8qsoj2jhq85rj1ue3t3]
GO
ALTER TABLE [dbo].[Test]  WITH CHECK ADD  CONSTRAINT [FK_9f0mag5ysbeuhbnfc9g2bfvrd] FOREIGN KEY([owner])
REFERENCES [dbo].[Account] ([username])
GO
ALTER TABLE [dbo].[Test] CHECK CONSTRAINT [FK_9f0mag5ysbeuhbnfc9g2bfvrd]
GO
ALTER TABLE [dbo].[Test_Examinee]  WITH CHECK ADD  CONSTRAINT [FK_rx79hpkqifjerd3r4weiihhqh] FOREIGN KEY([testId])
REFERENCES [dbo].[Test] ([id])
GO
ALTER TABLE [dbo].[Test_Examinee] CHECK CONSTRAINT [FK_rx79hpkqifjerd3r4weiihhqh]
GO
ALTER TABLE [dbo].[Test_Examinee]  WITH CHECK ADD  CONSTRAINT [FK_sqn9yamghypt8fodv27dycemr] FOREIGN KEY([examinee])
REFERENCES [dbo].[Account] ([username])
GO
ALTER TABLE [dbo].[Test_Examinee] CHECK CONSTRAINT [FK_sqn9yamghypt8fodv27dycemr]
GO
ALTER TABLE [dbo].[Test_Question]  WITH CHECK ADD  CONSTRAINT [FK_iotk9juf148ekopmr1yoluggt] FOREIGN KEY([testId])
REFERENCES [dbo].[Test] ([id])
GO
ALTER TABLE [dbo].[Test_Question] CHECK CONSTRAINT [FK_iotk9juf148ekopmr1yoluggt]
GO
ALTER TABLE [dbo].[Test_Question]  WITH CHECK ADD  CONSTRAINT [FK_ou2ncsriagj4ubcowvrsg59lk] FOREIGN KEY([questionId])
REFERENCES [dbo].[Question] ([id])
GO
ALTER TABLE [dbo].[Test_Question] CHECK CONSTRAINT [FK_ou2ncsriagj4ubcowvrsg59lk]
GO
/****** Object:  StoredProcedure [dbo].[sp_alterdiagram]    Script Date: 23/03/2017 10:39:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_alterdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null,
		@version 	int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId 			int
		declare @retval 		int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @ShouldChangeUID	int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid ARG', 16, 1)
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();	 
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		revert;
	
		select @ShouldChangeUID = 0
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		
		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end
	
		if(@IsDbo <> 0)
		begin
			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
			begin
				select @ShouldChangeUID = 1 ;
			end
		end

		-- update dds data			
		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;

		-- change owner
		if(@ShouldChangeUID = 1)
			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;

		-- update dds version
		if(@version is not null)
			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_creatediagram]    Script Date: 23/03/2017 10:39:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_creatediagram]
	(
		@diagramname 	sysname,
		@owner_id		int	= null, 	
		@version 		int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId int
		declare @retval int
		declare @IsDbo	int
		declare @userName sysname
		if(@version is null or @diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID(); 
		select @IsDbo = IS_MEMBER(N'db_owner');
		revert; 
		
		if @owner_id is null
		begin
			select @owner_id = @theId;
		end
		else
		begin
			if @theId <> @owner_id
			begin
				if @IsDbo = 0
				begin
					RAISERROR (N'E_INVALIDARG', 16, 1);
					return -1
				end
				select @theId = @owner_id
			end
		end
		-- next 2 line only for test, will be removed after define name unique
		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end
	
		insert into dbo.sysdiagrams(name, principal_id , version, definition)
				VALUES(@diagramname, @theId, @version, @definition) ;
		
		select @retval = @@IDENTITY 
		return @retval
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_dropdiagram]    Script Date: 23/03/2017 10:39:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_dropdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT; 
		
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		delete from dbo.sysdiagrams where diagram_id = @DiagId;
	
		return 0;
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagramdefinition]    Script Date: 23/03/2017 10:39:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagramdefinition]
	(
		@diagramname 	sysname,
		@owner_id	int	= null 		
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		set nocount on

		declare @theId 		int
		declare @IsDbo 		int
		declare @DiagId		int
		declare @UIDFound	int
	
		if(@diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner');
		if(@owner_id is null)
			select @owner_id = @theId;
		revert; 
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end

		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagrams]    Script Date: 23/03/2017 10:39:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagrams]
	(
		@diagramname sysname = NULL,
		@owner_id int = NULL
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		DECLARE @user sysname
		DECLARE @dboLogin bit
		EXECUTE AS CALLER;
			SET @user = USER_NAME();
			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
		REVERT;
		SELECT
			[Database] = DB_NAME(),
			[Name] = name,
			[ID] = diagram_id,
			[Owner] = USER_NAME(principal_id),
			[OwnerID] = principal_id
		FROM
			sysdiagrams
		WHERE
			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
			(@diagramname IS NULL OR name = @diagramname) AND
			(@owner_id IS NULL OR principal_id = @owner_id)
		ORDER BY
			4, 5, 1
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_renamediagram]    Script Date: 23/03/2017 10:39:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_renamediagram]
	(
		@diagramname 		sysname,
		@owner_id		int	= null,
		@new_diagramname	sysname
	
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @DiagIdTarg		int
		declare @u_name			sysname
		if((@diagramname is null) or (@new_diagramname is null))
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT;
	
		select @u_name = USER_NAME(@owner_id)
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
		--	return 0;
	
		if(@u_name is null)
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
		else
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
	
		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end		
	
		if(@u_name is null)
			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
		else
			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_upgraddiagrams]    Script Date: 23/03/2017 10:39:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_upgraddiagrams]
	AS
	BEGIN
		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
			return 0;
	
		CREATE TABLE dbo.sysdiagrams
		(
			name sysname NOT NULL,
			principal_id int NOT NULL,	-- we may change it to varbinary(85)
			diagram_id int PRIMARY KEY IDENTITY,
			version int,
	
			definition varbinary(max)
			CONSTRAINT UK_principal_name UNIQUE
			(
				principal_id,
				name
			)
		);


		/* Add this if we need to have some form of extended properties for diagrams */
		/*
		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
		BEGIN
			CREATE TABLE dbo.sysdiagram_properties
			(
				diagram_id int,
				name sysname,
				value varbinary(max) NOT NULL
			)
		END
		*/

		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
		begin
			insert into dbo.sysdiagrams
			(
				[name],
				[principal_id],
				[version],
				[definition]
			)
			select	 
				convert(sysname, dgnm.[uvalue]),
				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
				0,							-- zero for old format, dgdef.[version],
				dgdef.[lvalue]
			from dbo.[dtproperties] dgnm
				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
				
			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
			return 2;
		end
		return 1;
	END
	
GO
USE [master]
GO
ALTER DATABASE [OnlineExamSystem] SET  READ_WRITE 
GO
