object PathForm: TPathForm
  Left = 215
  Top = 103
  Width = 462
  Height = 117
  Caption = #1042#1099#1073#1086#1088' '#1087#1091#1090#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 8
    Top = 16
    Width = 409
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 120
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 224
    Top = 48
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
  object Button3: TButton
    Left = 424
    Top = 16
    Width = 21
    Height = 21
    Caption = '...'
    TabOrder = 3
    OnClick = Button3Click
  end
end
