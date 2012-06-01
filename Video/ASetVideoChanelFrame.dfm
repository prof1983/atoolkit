object frSetVideoChanel: TfrSetVideoChanel
  Left = 0
  Top = 0
  Width = 311
  Height = 158
  TabOrder = 0
  TabStop = True
  object lbSource: TLabel
    Left = 8
    Top = 88
    Width = 149
    Height = 13
    Caption = #1048#1089#1090#1086#1095#1085#1080#1082' '#1074#1080#1076#1077#1086#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103
  end
  object Label2: TLabel
    Left = 8
    Top = 16
    Width = 31
    Height = 13
    Caption = #1050#1072#1085#1072#1083
  end
  object lbNumCamera: TLabel
    Left = 8
    Top = 136
    Width = 72
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1082#1072#1084#1077#1088#1099
  end
  object ckbSave: TCheckBox
    Left = 8
    Top = 64
    Width = 233
    Height = 17
    Caption = #1057#1086#1093#1088#1072#1085#1103#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
    TabOrder = 0
  end
  object ckbEnabled: TCheckBox
    Left = 8
    Top = 40
    Width = 121
    Height = 17
    Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1082#1072#1085#1072#1083
    TabOrder = 1
  end
  object cbSource: TComboBox
    Left = 8
    Top = 104
    Width = 273
    Height = 21
    ItemHeight = 13
    TabOrder = 2
  end
  object cbChanel: TComboBox
    Left = 48
    Top = 8
    Width = 81
    Height = 21
    ItemHeight = 13
    TabOrder = 3
    OnChange = cbChanelChange
  end
  object btAddChanel: TButton
    Left = 144
    Top = 8
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 4
    OnClick = btAddChanelClick
  end
end
