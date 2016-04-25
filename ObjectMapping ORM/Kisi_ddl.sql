
CREATE TABLE [dbo].[Kisi](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[adi] [varchar](20) NULL,
	[soyadi] [varchar](20) NULL,
	[yasi] [smallint] NULL,
	[dogumTarihi] [smalldatetime] NULL,
 CONSTRAINT [PK_Kisi] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO