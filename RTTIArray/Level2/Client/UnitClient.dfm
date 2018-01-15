object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Client'
  ClientHeight = 317
  ClientWidth = 435
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnCreateDataset: TButton
    Left = 24
    Top = 279
    Width = 393
    Height = 26
    Caption = '2- Create Dataset'
    TabOrder = 0
    OnClick = btnCreateDatasetClick
  end
  object DBGrid1: TDBGrid
    Left = 24
    Top = 8
    Width = 393
    Height = 229
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnCallWebService: TButton
    Left = 24
    Top = 248
    Width = 393
    Height = 25
    Caption = '1- Call Web Service'
    TabOrder = 2
    OnClick = btnCallWebServiceClick
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 212
    Top = 176
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 132
    Top = 192
  end
end
