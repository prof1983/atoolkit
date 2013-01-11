object WaitForm: TWaitForm
  Left = 506
  Top = 231
  BorderStyle = bsSizeToolWin
  Caption = 'WaitForm'
  ClientHeight = 52
  ClientWidth = 378
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblText: TLabel
    Left = 152
    Top = 0
    Width = 84
    Height = 16
    Alignment = taCenter
    Caption = #1055#1086#1076#1086#1078#1076#1080#1090#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ProgressBar: TProgressBar
    Left = 16
    Top = 24
    Width = 353
    Height = 17
    TabOrder = 0
    Visible = False
  end
end
