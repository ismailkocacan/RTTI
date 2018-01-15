object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 418
  ClientWidth = 480
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
  object Button1: TButton
    Left = 273
    Top = 16
    Width = 189
    Height = 89
    Caption = 'Pointer Aritmetic'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 261
    Height = 418
    Align = alLeft
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Button2: TButton
    Left = 273
    Top = 111
    Width = 189
    Height = 89
    Caption = 'TValue'
    TabOrder = 2
    OnClick = Button2Click
  end
end
