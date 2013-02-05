object frSetDMReplica: TfrSetDMReplica
  Left = 0
  Top = 0
  Width = 320
  Height = 240
  TabOrder = 0
  object btAdd: TSpeedButton
    Left = 248
    Top = 40
    Width = 23
    Height = 22
    Caption = 'Add'
    OnClick = btAddClick
  end
  object btDelete: TSpeedButton
    Left = 248
    Top = 64
    Width = 23
    Height = 22
    Caption = 'Del'
    OnClick = btDeleteClick
  end
  object btUp: TSpeedButton
    Left = 248
    Top = 96
    Width = 23
    Height = 22
    Caption = 'Up'
    OnClick = btUpClick
  end
  object btDown: TSpeedButton
    Left = 248
    Top = 120
    Width = 23
    Height = 22
    Caption = 'Down'
    OnClick = btDownClick
  end
  object ckbEnabled: TCheckBox
    Left = 16
    Top = 16
    Width = 97
    Height = 17
    Caption = 'Enabled'
    TabOrder = 0
  end
  object lbActions: TListBox
    Left = 8
    Top = 40
    Width = 233
    Height = 169
    ItemHeight = 13
    TabOrder = 1
    OnDblClick = lbActionsDblClick
  end
end
