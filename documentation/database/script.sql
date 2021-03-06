USE [OnlineExamSystem]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 3/24/2017 1:25:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Account_Role]    Script Date: 3/24/2017 1:25:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AccountProfile]    Script Date: 3/24/2017 1:25:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Attempt]    Script Date: 3/24/2017 1:25:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Attempt_Choice]    Script Date: 3/24/2017 1:25:33 AM ******/
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
/****** Object:  Table [dbo].[Choice]    Script Date: 3/24/2017 1:25:33 AM ******/
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
/****** Object:  Table [dbo].[Course]    Script Date: 3/24/2017 1:25:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Question]    Script Date: 3/24/2017 1:25:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Role]    Script Date: 3/24/2017 1:25:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Test]    Script Date: 3/24/2017 1:25:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Test](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[attemptLimit] [int] NULL,
	[joinEndTime] [datetime2](7) NULL,
	[joinStartTime] [datetime2](7) NULL,
	[name] [nvarchar](255) NULL,
	[restricted] [bit] NULL,
	[timeLength] [int] NULL,
	[courseId] [varchar](30) NULL,
	[owner] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Test_Examinee]    Script Date: 3/24/2017 1:25:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Test_Question]    Script Date: 3/24/2017 1:25:33 AM ******/
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
INSERT [dbo].[Account_Role] ([username], [role]) VALUES (N'admin', N'admin')
INSERT [dbo].[AccountProfile] ([username], [birthdate], [email], [fullName], [gender]) VALUES (N'admin', NULL, NULL, N'Administrator', NULL)
INSERT [dbo].[Role] ([name], [description]) VALUES (N'admin', N'Administrator')
INSERT [dbo].[Role] ([name], [description]) VALUES (N'student', N'Student')
INSERT [dbo].[Role] ([name], [description]) VALUES (N'testmaster', N'Test Master')
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
