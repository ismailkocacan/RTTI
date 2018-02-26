object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 343
  ClientWidth = 627
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnXmlSerialize: TButton
    Left = 0
    Top = 0
    Width = 627
    Height = 49
    Align = alTop
    Caption = 'Xml Serialize'
    TabOrder = 0
    OnClick = btnXmlSerializeClick
  end
  object Memo1: TMemo
    Left = 0
    Top = 49
    Width = 627
    Height = 294
    Align = alClient
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
  end
end
