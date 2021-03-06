USE [master]
GO
/****** Object:  Database [UniversityManagementSystemDB]    Script Date: 12/21/2018 5:18:53 PM ******/
CREATE DATABASE [UniversityManagementSystemDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'UniversityManagementSystemDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\UniversityManagementSystemDB.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'UniversityManagementSystemDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\UniversityManagementSystemDB_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [UniversityManagementSystemDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [UniversityManagementSystemDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [UniversityManagementSystemDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET  MULTI_USER 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [UniversityManagementSystemDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [UniversityManagementSystemDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [UniversityManagementSystemDB]
GO
/****** Object:  Table [dbo].[AssignCourse]    Script Date: 12/21/2018 5:18:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AssignCourse](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CourseId] [int] NOT NULL,
	[TeacherId] [int] NOT NULL,
	[Flag] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CourseAssignment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ClassAllocation]    Script Date: 12/21/2018 5:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClassAllocation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DeptId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[RoomNo] [varchar](50) NOT NULL,
	[Day] [varchar](50) NOT NULL,
	[FromTime] [int] NOT NULL,
	[ToTime] [int] NOT NULL,
	[Flag] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ClassRoomAllocation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Course]    Script Date: 12/21/2018 5:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Course](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Credit] [decimal](3, 2) NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[SemesterId] [int] NOT NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CourseEnrollment]    Script Date: 12/21/2018 5:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CourseEnrollment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[EnrollDate] [date] NOT NULL,
	[Grade] [varchar](50) NOT NULL,
	[Flag] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CourseEnrollment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Day]    Script Date: 12/21/2018 5:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Day](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Day] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Department]    Script Date: 12/21/2018 5:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Department](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Designation]    Script Date: 12/21/2018 5:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Designation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Designation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Grade]    Script Date: 12/21/2018 5:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Grade](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LetterGrade] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Grades] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Room]    Script Date: 12/21/2018 5:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Room](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoomNo] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Semester]    Script Date: 12/21/2018 5:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Semester](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
 CONSTRAINT [PK_Semester] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Student]    Script Date: 12/21/2018 5:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Student](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[RegNo] [varchar](50) NULL,
	[Email] [varchar](50) NOT NULL,
	[ContactNo] [varchar](50) NOT NULL,
	[RegDate] [date] NOT NULL,
	[Address] [varchar](1000) NOT NULL,
	[DeptId] [int] NOT NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Teacher]    Script Date: 12/21/2018 5:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Teacher](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Address] [varchar](1000) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[ContactNo] [varchar](50) NOT NULL,
	[Designation] [varchar](100) NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[CreditLimit] [decimal](18, 2) NOT NULL,
	[RemainingCredit] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[ClassRoutineView]    Script Date: 12/21/2018 5:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[ClassRoutineView] As
Select Course.Code as CourseCode, Course.Name as CourseName, Course.DepartmentId as DeptId,
ClassAllocation.Day as Day, ClassAllocation.RoomNo as RoomNo, ClassAllocation.FromTime as FromTime,
ClassAllocation.ToTime as ToTime, ClassAllocation.Flag as Flag
from Course Left Join ClassAllocation on Course.Id = ClassAllocation.CourseId 







GO
/****** Object:  View [dbo].[CourseStatisticsViews]    Script Date: 12/21/2018 5:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE View  [dbo].[CourseStatisticsViews] As
select Course.Code As Code, Course.Name As Title, Course.SemesterId As Semester, Teacher.Name As AssignedTo, Course.DepartmentId As DeptId, AssignCourse.Flag As Flag
From Course 
Left Join AssignCourse on Course.Id = AssignCourse.CourseId
Left Join Teacher on AssignCourse.TeacherId = Teacher.Id

GO
/****** Object:  View [dbo].[StudentCourseView]    Script Date: 12/21/2018 5:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE View [dbo].[StudentCourseView] as
Select Student.Id as StudentId, Student.Name as StudentName, Course.Id as CourseId, Course.Name as CourseName, Course.Code as CourseCode, 
CourseEnrollment.Grade as Grade ,CourseEnrollment.Flag as Flag
From Student 
inner join CourseEnrollment on student.Id = CourseEnrollment.StudentId
inner join Course on CourseEnrollment.CourseId = Course.Id








GO
SET IDENTITY_INSERT [dbo].[AssignCourse] ON 

INSERT [dbo].[AssignCourse] ([Id], [CourseId], [TeacherId], [Flag]) VALUES (1, 5, 4, N'1')
INSERT [dbo].[AssignCourse] ([Id], [CourseId], [TeacherId], [Flag]) VALUES (2, 4, 1, N'1')
INSERT [dbo].[AssignCourse] ([Id], [CourseId], [TeacherId], [Flag]) VALUES (3, 1, 2, N'1')
INSERT [dbo].[AssignCourse] ([Id], [CourseId], [TeacherId], [Flag]) VALUES (4, 6, 12, N'1')
INSERT [dbo].[AssignCourse] ([Id], [CourseId], [TeacherId], [Flag]) VALUES (5, 9, 9, N'1')
INSERT [dbo].[AssignCourse] ([Id], [CourseId], [TeacherId], [Flag]) VALUES (6, 10, 10, N'1')
INSERT [dbo].[AssignCourse] ([Id], [CourseId], [TeacherId], [Flag]) VALUES (7, 11, 11, N'1')
INSERT [dbo].[AssignCourse] ([Id], [CourseId], [TeacherId], [Flag]) VALUES (8, 7, 5, N'1')
INSERT [dbo].[AssignCourse] ([Id], [CourseId], [TeacherId], [Flag]) VALUES (9, 14, 6, N'1')
INSERT [dbo].[AssignCourse] ([Id], [CourseId], [TeacherId], [Flag]) VALUES (10, 15, 7, N'1')
INSERT [dbo].[AssignCourse] ([Id], [CourseId], [TeacherId], [Flag]) VALUES (11, 17, 8, N'1')
INSERT [dbo].[AssignCourse] ([Id], [CourseId], [TeacherId], [Flag]) VALUES (12, 20, 13, N'1')
INSERT [dbo].[AssignCourse] ([Id], [CourseId], [TeacherId], [Flag]) VALUES (13, 21, 14, N'1')
INSERT [dbo].[AssignCourse] ([Id], [CourseId], [TeacherId], [Flag]) VALUES (14, 23, 15, N'1')
INSERT [dbo].[AssignCourse] ([Id], [CourseId], [TeacherId], [Flag]) VALUES (15, 2, 1, N'1')
INSERT [dbo].[AssignCourse] ([Id], [CourseId], [TeacherId], [Flag]) VALUES (16, 21, 14, N'1')
INSERT [dbo].[AssignCourse] ([Id], [CourseId], [TeacherId], [Flag]) VALUES (17, 3, 1, N'1')
INSERT [dbo].[AssignCourse] ([Id], [CourseId], [TeacherId], [Flag]) VALUES (18, 17, 6, N'1')
INSERT [dbo].[AssignCourse] ([Id], [CourseId], [TeacherId], [Flag]) VALUES (19, 4, 3, N'1')
INSERT [dbo].[AssignCourse] ([Id], [CourseId], [TeacherId], [Flag]) VALUES (20, 25, 18, N'1')
SET IDENTITY_INSERT [dbo].[AssignCourse] OFF
SET IDENTITY_INSERT [dbo].[ClassAllocation] ON 

INSERT [dbo].[ClassAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Flag]) VALUES (1, 1, 1, N'101', N'Saturday', 480, 600, N'1')
INSERT [dbo].[ClassAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Flag]) VALUES (2, 1, 1, N'101', N'Sunday', 540, 600, N'1')
INSERT [dbo].[ClassAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Flag]) VALUES (3, 1, 2, N'201', N'Saturday', 570, 682, N'1')
INSERT [dbo].[ClassAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Flag]) VALUES (4, 1, 3, N'202', N'Saturday', 570, 720, N'1')
INSERT [dbo].[ClassAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Flag]) VALUES (5, 2, 9, N'201', N'Monday', 480, 540, N'1')
INSERT [dbo].[ClassAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Flag]) VALUES (6, 3, 14, N'101', N'Monday', 1428, 1439, N'1')
INSERT [dbo].[ClassAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Flag]) VALUES (7, 2, 10, N'101', N'Tuesday', 1230, 1260, N'1')
INSERT [dbo].[ClassAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Flag]) VALUES (8, 2, 13, N'102', N'Tuesday', 1230, 1260, N'1')
INSERT [dbo].[ClassAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Flag]) VALUES (9, 3, 15, N'201', N'Tuesday', 720, 780, N'1')
INSERT [dbo].[ClassAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Flag]) VALUES (10, 3, 7, N'301', N'Saturday', 1200, 1439, N'1')
INSERT [dbo].[ClassAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Flag]) VALUES (11, 4, 20, N'101', N'Wednesday', 1230, 1319, N'1')
INSERT [dbo].[ClassAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Flag]) VALUES (12, 4, 21, N'103', N'Wednesday', 1200, 1282, N'1')
INSERT [dbo].[ClassAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Flag]) VALUES (13, 4, 22, N'103', N'Wednesday', 540, 622, N'true')
INSERT [dbo].[ClassAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Flag]) VALUES (14, 1, 2, N'101', N'Sunday', 555, 735, N'1')
INSERT [dbo].[ClassAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Flag]) VALUES (15, 1, 4, N'101', N'Saturday', 555, 735, N'1')
INSERT [dbo].[ClassAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Flag]) VALUES (16, 1, 2, N'202', N'Monday', 555, 735, N'1')
INSERT [dbo].[ClassAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Flag]) VALUES (17, 1, 2, N'102', N'Sunday', 495, 540, N'1')
INSERT [dbo].[ClassAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Flag]) VALUES (18, 1, 3, N'202', N'Sunday', 495, 556, N'1')
INSERT [dbo].[ClassAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Flag]) VALUES (19, 2, 9, N'202', N'Wednesday', 435, 495, N'1')
INSERT [dbo].[ClassAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Flag]) VALUES (20, 1, 5, N'203', N'Monday', 495, 735, N'1')
INSERT [dbo].[ClassAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Flag]) VALUES (21, 1, 2, N'203', N'Wednesday', 495, 555, N'1')
INSERT [dbo].[ClassAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Flag]) VALUES (22, 6, 25, N'302', N'Monday', 735, 795, N'1')
SET IDENTITY_INSERT [dbo].[ClassAllocation] OFF
SET IDENTITY_INSERT [dbo].[Course] ON 

INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (1, N'CSE-101', N'C Programming', CAST(3.00 AS Decimal(3, 2)), N'C program is the basic programming language', 1, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (2, N'CSE-201', N'Object Oriented Programming I', CAST(3.50 AS Decimal(3, 2)), N'Object-oriented programming (OOP) is a programming', 1, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (3, N'CSE-301', N'Object Oriented Programming II', CAST(3.00 AS Decimal(3, 2)), N'Object-oriented programming (OOP) refers to a type', 1, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (4, N'CSE-202', N'Data Structures', CAST(2.50 AS Decimal(3, 2)), N'In computer science, a data structure is a particu', 1, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (5, N'CSE-801', N'Project / Thesis', CAST(5.00 AS Decimal(3, 2)), N'Important For CSE', 1, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (6, N'ETE-201', N'Electrical Theology', CAST(5.00 AS Decimal(3, 2)), N'Important For ETE', 2, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (7, N'PH-801', N'Biochemesitry', CAST(5.00 AS Decimal(3, 2)), N'Important For Pharmacy', 3, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (8, N'BBA-801', N'Business Ethics', CAST(5.00 AS Decimal(3, 2)), N'Important For Business', 5, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (9, N'ETE-101', N'Intro to Telecommunication', CAST(2.00 AS Decimal(3, 2)), N'Important For ETE', 2, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (10, N'ETE- 201', N'Satelite', CAST(2.50 AS Decimal(3, 2)), N'Important For ETE', 2, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (11, N'ETE-301', N'Circuits', CAST(3.00 AS Decimal(3, 2)), N'Important For ETE', 2, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (12, N'ETE-401', N'Computer Architecture', CAST(3.50 AS Decimal(3, 2)), N'Important For ETE', 2, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (13, N'ETE-535', N'Wireless Communication', CAST(4.00 AS Decimal(3, 2)), N'Important For ETE', 2, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (14, N'PH-2034', N'Molecules', CAST(2.00 AS Decimal(3, 2)), N'Important For Pharmacy', 3, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (15, N'PH-2035', N'Tree Habit', CAST(3.50 AS Decimal(3, 2)), N'Important For Pharmacy', 3, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (17, N'PH-2036', N'Reproduction', CAST(3.00 AS Decimal(3, 2)), N'Important For Pharmacy', 3, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (18, N'PH-2037', N'Bacteria', CAST(3.50 AS Decimal(3, 2)), N'Important For Pharmacy', 3, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (19, N'PH-2038', N'Natural Resource', CAST(4.00 AS Decimal(3, 2)), N'Important For Pharmacy', 3, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (20, N'ELL-001', N'Novels', CAST(3.00 AS Decimal(3, 2)), N'Important For ELL', 4, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (21, N'ELL-002', N'Phrase Culture', CAST(3.50 AS Decimal(3, 2)), N'Important For ELL', 4, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (22, N'ELL-003', N'Drama', CAST(3.00 AS Decimal(3, 2)), N'Important For ELL', 4, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (23, N'ELL-004', N'Classic Poetry', CAST(4.00 AS Decimal(3, 2)), N'Important For ELL', 4, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (24, N'ELL-005', N'Presentation', CAST(5.00 AS Decimal(3, 2)), N'Final dissertation', 4, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (25, N'ECO-50342', N'Economy In Society', CAST(4.00 AS Decimal(3, 2)), N'Economy In Society is a subject of EB', 6, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Credit], [Description], [DepartmentId], [SemesterId]) VALUES (26, N'DIS-1051', N'Islamic Dawah', CAST(5.00 AS Decimal(3, 2)), N'Its very important course for DIS', 7, 1)
SET IDENTITY_INSERT [dbo].[Course] OFF
SET IDENTITY_INSERT [dbo].[CourseEnrollment] ON 

INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (1, 1, 1, CAST(0x033B0B00 AS Date), N'A+', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (2, 1, 2, CAST(0xB93B0B00 AS Date), N'A', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (3, 1, 3, CAST(0x363A0B00 AS Date), N'A+', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (4, 2, 3, CAST(0xAE3A0B00 AS Date), N'A-', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (5, 2, 5, CAST(0xAF3A0B00 AS Date), N'D+', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (6, 2, 4, CAST(0x303A0B00 AS Date), N'A', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (7, 4, 4, CAST(0x703C0B00 AS Date), N'A', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (8, 5, 7, CAST(0x923C0B00 AS Date), N'D', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (9, 5, 14, CAST(0x683A0B00 AS Date), N'A', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (10, 5, 17, CAST(0x763A0B00 AS Date), N'B+', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (11, 6, 22, CAST(0x653B0B00 AS Date), N'D', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (12, 8, 11, CAST(0xB93B0B00 AS Date), N'D-', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (13, 8, 12, CAST(0xB93B0B00 AS Date), N'C', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (14, 10, 20, CAST(0xB93B0B00 AS Date), N'B+', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (15, 10, 24, CAST(0x693A0B00 AS Date), N'A', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (16, 9, 17, CAST(0x5A3C0B00 AS Date), N'Not Graded Yet', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (17, 12, 10, CAST(0xB93B0B00 AS Date), N'A', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (18, 9, 18, CAST(0xF83B0B00 AS Date), N'Not Graded Yet', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (19, 12, 6, CAST(0x533C0B00 AS Date), N'B+', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (20, 12, 9, CAST(0xA73A0B00 AS Date), N'A-', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (21, 12, 11, CAST(0x253B0B00 AS Date), N'A', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (22, 12, 12, CAST(0xB93B0B00 AS Date), N'A-', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (23, 12, 13, CAST(0xCB3A0B00 AS Date), N'A+', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (24, 4, 3, CAST(0x1D3F0B00 AS Date), N'Not Graded Yet', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (25, 5, 15, CAST(0x173F0B00 AS Date), N'Not Graded Yet', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (26, 11, 8, CAST(0x173F0B00 AS Date), N'Not Graded Yet', N'1')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Flag]) VALUES (1025, 3, 2, CAST(0x183F0B00 AS Date), N'Not Graded Yet', N'1')
SET IDENTITY_INSERT [dbo].[CourseEnrollment] OFF
SET IDENTITY_INSERT [dbo].[Day] ON 

INSERT [dbo].[Day] ([Id], [Name]) VALUES (1, N'Saturday')
INSERT [dbo].[Day] ([Id], [Name]) VALUES (2, N'Sunday')
INSERT [dbo].[Day] ([Id], [Name]) VALUES (3, N'Monday')
INSERT [dbo].[Day] ([Id], [Name]) VALUES (4, N'Tuesday')
INSERT [dbo].[Day] ([Id], [Name]) VALUES (5, N'Wednesday')
INSERT [dbo].[Day] ([Id], [Name]) VALUES (6, N'Thursday')
INSERT [dbo].[Day] ([Id], [Name]) VALUES (7, N'Friday')
SET IDENTITY_INSERT [dbo].[Day] OFF
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([Id], [Code], [Name]) VALUES (1, N'CSE', N'Computer Science and Engineering')
INSERT [dbo].[Department] ([Id], [Code], [Name]) VALUES (2, N'ETE', N'Electronics and Telecommunication Enginnering')
INSERT [dbo].[Department] ([Id], [Code], [Name]) VALUES (3, N'Pharmacy', N'Pharmacy Science')
INSERT [dbo].[Department] ([Id], [Code], [Name]) VALUES (4, N'ELL', N'English Language Lierature')
INSERT [dbo].[Department] ([Id], [Code], [Name]) VALUES (5, N'BBA', N'Bachelor Of Business Adminstration')
INSERT [dbo].[Department] ([Id], [Code], [Name]) VALUES (6, N'EB', N'Economics and Banking')
INSERT [dbo].[Department] ([Id], [Code], [Name]) VALUES (7, N'DIS', N'Dawah & Islmaic Studies')
INSERT [dbo].[Department] ([Id], [Code], [Name]) VALUES (8, N'DSS', N'Department Of Social Science')
INSERT [dbo].[Department] ([Id], [Code], [Name]) VALUES (9, N'DL', N'dept of Law')
SET IDENTITY_INSERT [dbo].[Department] OFF
SET IDENTITY_INSERT [dbo].[Designation] ON 

INSERT [dbo].[Designation] ([Id], [Name]) VALUES (2, N'Assistant Professor')
INSERT [dbo].[Designation] ([Id], [Name]) VALUES (3, N'Associate Professor')
INSERT [dbo].[Designation] ([Id], [Name]) VALUES (1, N'Lecturer')
INSERT [dbo].[Designation] ([Id], [Name]) VALUES (4, N'Professor')
SET IDENTITY_INSERT [dbo].[Designation] OFF
SET IDENTITY_INSERT [dbo].[Grade] ON 

INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (1, N'A+')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (2, N'A')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (3, N'A-')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (4, N'B+')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (5, N'B')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (6, N'B-')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (7, N'C+')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (8, N'C')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (9, N'C-')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (10, N'D+')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (11, N'D')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (12, N'D-')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (13, N'F')
SET IDENTITY_INSERT [dbo].[Grade] OFF
SET IDENTITY_INSERT [dbo].[Room] ON 

INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (1, N'101')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (2, N'102')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (3, N'103')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (4, N'201')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (5, N'202')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (6, N'203')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (7, N'301')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (8, N'302')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (9, N'303')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (10, N'401')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (11, N'402')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (12, N'403')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (13, N'501')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (14, N'502')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (15, N'503')
SET IDENTITY_INSERT [dbo].[Room] OFF
SET IDENTITY_INSERT [dbo].[Semester] ON 

INSERT [dbo].[Semester] ([Id], [Name]) VALUES (1, N'1st')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (2, N'2nd')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (3, N'3rd')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (4, N'4th')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (5, N'5th')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (6, N'6th')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (7, N'7th')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (8, N'8th')
SET IDENTITY_INSERT [dbo].[Semester] OFF
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (1, N'Abu Hasnat MD.', N'CSE-2018-001', N'hasnatBhalochle@gmail.com', N'01713228615', CAST(0x113F0B00 AS Date), N'Agrabad, Chittagong', 1)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (2, N'Mubtasim Fuad', N'CSE-2018-002', N'fuad420@gmail.com', N'01725494684', CAST(0x113F0B00 AS Date), N'Chandgaon R/A, Bahadarhat, Chittagong', 1)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (3, N'Hisbullah Hasnat', N'CSE-2018-003', N'Hasnata@gmail.com', N'01515346324', CAST(0x113F0B00 AS Date), N'Andorkilla, Chittagong', 1)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (4, N'Rayhan Mahmud', N'CSE-2018-004', N'raihnaborobhai@yahoo.com', N'01814354564', CAST(0x113F0B00 AS Date), N'Oxyzen, Chittagong', 1)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (5, N'Tanzimul Alam Tanim', N'Pharmacy-2018-005', N'tanzim.iiuc@gmail.com', N'01946134685', CAST(0x113F0B00 AS Date), N'Mehedibag, Chittagong', 3)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (6, N'Hossen Sarwar', N'ELL-2018-006', N'hossainsarwar@gmail.com', N'01534686489', CAST(0x113F0B00 AS Date), N'Agrabad, Chittagong', 4)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (7, N'Alam Tuhin', N'BBA-2018-007', N'alamtuhin@gmail.com', N'01814644561', CAST(0x113F0B00 AS Date), N'Sitakund, Chittagong', 5)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (8, N'Abdur Rahman', N'ETE-2018-008', N'abdurRahmanhg@gmail.com', N'01724679134', CAST(0x113F0B00 AS Date), N'Bahaddarhat, Chittagong', 2)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (9, N'Rimon Hossain', N'Pharmacy-2018-009', N'hossainRimon@outlook.com', N'01814354695', CAST(0x113F0B00 AS Date), N'Chawkbazar, Chittagong', 3)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (10, N'Akibul Islam', N'ELL-2018-010', N'akibul.akib@outlook.com', N'01814354646', CAST(0x113F0B00 AS Date), N'Khulshi, Chittagong', 4)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (11, N'Shafiul Adon', N'ETE-2018-001', N'adon.re@hotmail.com', N'01916234595', CAST(0x113F0B00 AS Date), N'Noakhali', 5)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (12, N'Shuvro Biswas', N'ETE-2015-001', N'shuvro.ae@ymail.com', N'01924613278', CAST(0x113F0B00 AS Date), N'Sitakund, Chittagong', 2)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (13, N'Alex ', N'ELL-2018-27', N'alex@gmail.com', N'01888888888', CAST(0x113F0B00 AS Date), N'1202', 4)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (14, N'Ahsan Habib', N'Pharmacy-2018-14', N'ahsanhabib@gmail.com', N'01888888888', CAST(0x113F0B00 AS Date), N'Halishahar', 3)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (15, N'Minhaj Ahmed', N'BBA-2018-15', N'minhaj@gmail.com', N'01888888888', CAST(0x113F0B00 AS Date), N'Bohutola', 5)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (16, N'Wiley Shams', N'ETE-2018-16', N'Wiley@gmail.com', N'01888888888', CAST(0x123F0B00 AS Date), N'1202/A', 2)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (17, N'Shahriar Nafis', N'Pharmacy-2018-017', N'shahriarnafis@gmail.com', N'01839698590', CAST(0x123F0B00 AS Date), N'Shantibag R/A, 1202/A', 3)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (18, N'Rayhan Mahud', N'CSE-2018-018', N'rayhanmahmud@gmail.com', N'01888888888', CAST(0x133F0B00 AS Date), N'Nimtola', 1)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (19, N'Jahid Islam', N'Pharmacy-2018-019', N'jahidislam@gmail.com', N'01855888888', CAST(0x133F0B00 AS Date), N'Nimtola', 3)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (20, N'Atique Sahariar', N'EB-2018-020', N'atiquesahariar@gmail.com', N'01558920432', CAST(0x163F0B00 AS Date), N'Ramu,Cox''s Bazar', 6)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (21, N'Shahed Anwar', N'BBA-2018-021', N'shahedanwar@gmail.con', N'01558919210', CAST(0x173F0B00 AS Date), N'1202 Jhautola', 5)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (1021, N'Zia Uddin', N'BBA-2018-022', N'ziakhaleda@gmail.com', N'01536545874', CAST(0x183F0B00 AS Date), N'IIUC, CTG', 5)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (1022, N'Kafi Hasan', N'EB-2018-1022', N'kafihasan@gmail.com', N'01556253485', CAST(0x183F0B00 AS Date), N'Hasan Para', 6)
SET IDENTITY_INSERT [dbo].[Student] OFF
SET IDENTITY_INSERT [dbo].[Teacher] ON 

INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (1, N'Saiful Islam', N'Cox''sBazar', N'safiullah@gmail.com', N'01534698265', N'Assistant Professor', 1, CAST(17.00 AS Decimal(18, 2)), CAST(2.50 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (2, N'Mohammed Mohiuddin', N'Marine City Complex,Cox''sBazar', N'mohiuddin@yahoo.com', N'014235675864', N'Assistant Professor', 1, CAST(17.00 AS Decimal(18, 2)), CAST(14.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (3, N'Mahmudur Rahman', N'Agrabad H/A', N'prova@yahoo.com', N'01453625789', N'Lecturer', 1, CAST(15.00 AS Decimal(18, 2)), CAST(12.50 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (4, N'Shahid Nayem', N'Bohutola Colony', N'nayem@iiuc.ac.bd', N'01534625896', N'Assistant Professor', 1, CAST(7.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (5, N'Sajib Hasan', N'Anderbazar', N'sajib@gmail.com', N'01995213456', N'Lecturer', 3, CAST(7.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (6, N'Chandan Chy', N'Shahi Goli, 2008', N'chandan@cu.ac.bd', N'01713224566', N'Associate Professor', 3, CAST(15.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (7, N'Dr. Sumon Saha', N'Poshchim Jatrabari', N'suman@iiuc.ac.bd', N'01926197002', N'Assistant Professor', 3, CAST(13.00 AS Decimal(18, 2)), CAST(9.50 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (8, N'Sajjad Shahriar', N'1202 Kolatoli', N'shahriar@gmail.com', N'01861304622', N'Professor', 3, CAST(17.00 AS Decimal(18, 2)), CAST(14.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (9, N'Tabib Islam', N'Eden Bazar', N'tabibkhan@outlook.com', N'01513462464', N'Professor', 2, CAST(17.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (10, N'Khondokar Moshtak', N'East Pakistan', N'eastpakistani@gmail.com', N'01515346457', N'Associate Professor', 2, CAST(15.00 AS Decimal(18, 2)), CAST(12.50 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (11, N'Haleem Uddin', N'Shahi Lane', N'haleemgorom@gmail.com', N'01515346962', N'Associate Professor', 2, CAST(13.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (12, N'Gazi Kibriya', N'Jadur Goli', N'Shamsulbhai@gmail.com', N'01515346724', N'Lecturer', 2, CAST(6.00 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (13, N'Shamsul Alam', N'Bhuter Bari', N'rabiulbd@hotmail.com', N'01721750743', N'Professor', 4, CAST(17.00 AS Decimal(18, 2)), CAST(14.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (14, N'Kader Ali', N'Jadur Hari, 1203', N'kaderaliThakiAbudhabi@gmail.com', N'61470647883', N'Assistant Professor', 4, CAST(15.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (15, N'Shan-A-Alahi', N'Aampara', N'shan-elahi@gmail.con', N'01921619385', N'Associate Professor', 4, CAST(15.00 AS Decimal(18, 2)), CAST(11.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (16, N'Bhoumik Sarkar', N'Murshidabad', N'bhoumikindian@gmail.com', N'01814647896', N'Lecturer', 4, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (18, N'Jashim Talukdar', N'Sandwip', N'jashim@gmail.com', N'01626737251', N'Assistant Professor', 6, CAST(5.00 AS Decimal(18, 2)), CAST(-4.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (19, N'Arif Hasnat', N'120/Chipagoli', N'hasnat@gmail.com', N'01256548952', N'Associate Professor', 7, CAST(5.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Teacher] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Course]    Script Date: 12/21/2018 5:18:54 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Course] ON [dbo].[Course]
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Course_1]    Script Date: 12/21/2018 5:18:54 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Course_1] ON [dbo].[Course]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Department]    Script Date: 12/21/2018 5:18:54 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Department] ON [dbo].[Department]
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Department_1]    Script Date: 12/21/2018 5:18:54 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Department_1] ON [dbo].[Department]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Designation]    Script Date: 12/21/2018 5:18:54 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Designation] ON [dbo].[Designation]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Student]    Script Date: 12/21/2018 5:18:54 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Student] ON [dbo].[Student]
(
	[RegNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Student_1]    Script Date: 12/21/2018 5:18:54 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Student_1] ON [dbo].[Student]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Teacher]    Script Date: 12/21/2018 5:18:54 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Teacher] ON [dbo].[Teacher]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AssignCourse]  WITH CHECK ADD  CONSTRAINT [FK_CourseAssignment_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([Id])
GO
ALTER TABLE [dbo].[AssignCourse] CHECK CONSTRAINT [FK_CourseAssignment_Course]
GO
ALTER TABLE [dbo].[AssignCourse]  WITH CHECK ADD  CONSTRAINT [FK_CourseAssignment_Teacher] FOREIGN KEY([TeacherId])
REFERENCES [dbo].[Teacher] ([Id])
GO
ALTER TABLE [dbo].[AssignCourse] CHECK CONSTRAINT [FK_CourseAssignment_Teacher]
GO
ALTER TABLE [dbo].[ClassAllocation]  WITH CHECK ADD  CONSTRAINT [FK_ClassRoomAllocation_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([Id])
GO
ALTER TABLE [dbo].[ClassAllocation] CHECK CONSTRAINT [FK_ClassRoomAllocation_Course]
GO
ALTER TABLE [dbo].[ClassAllocation]  WITH CHECK ADD  CONSTRAINT [FK_ClassRoomAllocation_Department] FOREIGN KEY([DeptId])
REFERENCES [dbo].[Department] ([Id])
GO
ALTER TABLE [dbo].[ClassAllocation] CHECK CONSTRAINT [FK_ClassRoomAllocation_Department]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Department] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Department] ([Id])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Department]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Semester] FOREIGN KEY([SemesterId])
REFERENCES [dbo].[Semester] ([Id])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Semester]
GO
ALTER TABLE [dbo].[CourseEnrollment]  WITH CHECK ADD  CONSTRAINT [FK_CourseEnrollment_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([Id])
GO
ALTER TABLE [dbo].[CourseEnrollment] CHECK CONSTRAINT [FK_CourseEnrollment_Course]
GO
ALTER TABLE [dbo].[CourseEnrollment]  WITH CHECK ADD  CONSTRAINT [FK_CourseEnrollment_Student] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Student] ([Id])
GO
ALTER TABLE [dbo].[CourseEnrollment] CHECK CONSTRAINT [FK_CourseEnrollment_Student]
GO
ALTER TABLE [dbo].[Teacher]  WITH CHECK ADD  CONSTRAINT [FK_Teacher_Department] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Department] ([Id])
GO
ALTER TABLE [dbo].[Teacher] CHECK CONSTRAINT [FK_Teacher_Department]
GO
USE [master]
GO
ALTER DATABASE [UniversityManagementSystemDB] SET  READ_WRITE 
GO
