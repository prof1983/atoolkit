object InputForm: TInputForm
  Left = 252
  Top = 176
  BorderStyle = bsToolWindow
  ClientHeight = 138
  ClientWidth = 277
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 12
    Top = 66
    Width = 249
    Height = 24
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 105
    Width = 277
    Height = 33
    Align = alBottom
    TabOrder = 1
    object btnOk: TBitBtn
      Left = 40
      Top = 4
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object btnCancel: TBitBtn
      Left = 152
      Top = 4
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object Memo: TMemo
    Left = 0
    Top = 0
    Width = 277
    Height = 49
    Align = alTop
    BorderStyle = bsNone
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 2
  end
end
