object frSetInspector: TfrSetInspector
  Left = 0
  Top = 0
  Width = 325
  Height = 281
  TabOrder = 0
  object lbChanelNumber: TLabel
    Left = 64
    Top = 120
    Width = 72
    Height = 13
    Caption = 'Chanel number'
    Enabled = False
  end
  object lbChanelPicture: TLabel
    Left = 64
    Top = 144
    Width = 69
    Height = 13
    Caption = 'Chanel picture'
    Enabled = False
  end
  object lbCameraNum: TLabel
    Left = 64
    Top = 168
    Width = 76
    Height = 13
    Caption = 'Camera number'
    Enabled = False
  end
  object lbPicturePath: TLabel
    Left = 8
    Top = 184
    Width = 85
    Height = 13
    Caption = 'Save picture path'
    Enabled = False
  end
  object Label6: TLabel
    Left = 136
    Top = 40
    Width = 63
    Height = 13
    Caption = 'Ip/HostName'
    Enabled = False
  end
  object Label7: TLabel
    Left = 72
    Top = 64
    Width = 10
    Height = 13
    Caption = 'Id'
    Enabled = False
  end
  object Label8: TLabel
    Left = 72
    Top = 88
    Width = 20
    Height = 13
    Caption = 'Port'
    Enabled = False
  end
  object lbIntervalPicture: TLabel
    Left = 72
    Top = 232
    Width = 72
    Height = 13
    Caption = 'Picture interval'
    Enabled = False
  end
  object lbIntervalNumber: TLabel
    Left = 72
    Top = 256
    Width = 76
    Height = 13
    Caption = 'Number interval'
    Enabled = False
  end
  object EditPath: TEdit
    Left = 8
    Top = 200
    Width = 305
    Height = 21
    Enabled = False
    TabOrder = 0
  end
  object EditIp: TEdit
    Left = 8
    Top = 32
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 1
    Text = 'localhost'
  end
  object ckbUse: TCheckBox
    Left = 8
    Top = 8
    Width = 185
    Height = 17
    Caption = 'Use Inspector+'
    TabOrder = 2
    OnClick = ckbUseClick
  end
end
