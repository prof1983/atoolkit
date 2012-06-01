object FilterForm: TFilterForm
  Left = 204
  Top = 103
  Caption = #1042#1099#1073#1086#1088' '#1076#1080#1072#1087#1072#1079#1086#1085#1072' '#1092#1080#1083#1100#1090#1088#1072#1094#1080#1080' '#1079#1072#1087#1080#1089#1077#1081
  ClientHeight = 156
  ClientWidth = 350
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 176
    Top = 64
    Width = 6
    Height = 13
    Caption = #1089
  end
  object Label2: TLabel
    Left = 176
    Top = 88
    Width = 12
    Height = 13
    Caption = #1087#1086
  end
  object InfoMemo: TMemo
    Left = 0
    Top = 0
    Width = 350
    Height = 41
    Align = alTop
    Color = clScrollBar
    Lines.Strings = (
      #1042#1099#1073#1077#1088#1080#1090#1077' '#1076#1080#1072#1087#1072#1079#1086#1085' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1079#1072#1087#1080#1089#1077#1081'.')
    ReadOnly = True
    TabOrder = 0
  end
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 48
    Width = 153
    Height = 89
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1079#1072#1087#1080#1089#1080
    ItemIndex = 0
    Items.Strings = (
      #1074#1089#1077
      #1079#1072' '#1075#1086#1076
      #1079#1072' '#1084#1077#1089#1103#1094
      #1087#1088#1086#1080#1079#1074#1086#1083#1100#1085#1086)
    TabOrder = 1
    OnClick = RadioGroup1Click
  end
  object OkButton: TBitBtn
    Left = 176
    Top = 112
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkOK
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 2
  end
  object CancelButton: TBitBtn
    Left = 256
    Top = 112
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    DoubleBuffered = True
    Kind = bkCancel
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 3
  end
  object DateTimePicker1: TDateTimePicker
    Left = 192
    Top = 56
    Width = 97
    Height = 21
    Date = 39664.590028020830000000
    Time = 39664.590028020830000000
    Enabled = False
    TabOrder = 4
  end
  object DateTimePicker2: TDateTimePicker
    Left = 192
    Top = 80
    Width = 97
    Height = 21
    Date = 39664.590157696760000000
    Time = 39664.590157696760000000
    Enabled = False
    TabOrder = 5
  end
end
