object frSetVideoCapture: TfrSetVideoCapture
  Left = 0
  Top = 0
  Width = 325
  Height = 155
  TabOrder = 0
  TabStop = True
  object lbVideoDevice: TLabel
    Left = 10
    Top = 48
    Width = 76
    Height = 13
    Caption = 'Camera number'
  end
  object lbVideoFreq: TLabel
    Left = 8
    Top = 80
    Width = 51
    Height = 13
    Caption = 'Frequency'
  end
  object lbQualty: TLabel
    Left = 8
    Top = 120
    Width = 34
    Height = 13
    Caption = 'Quality'
    ParentShowHint = False
    ShowHint = True
  end
  object cbIsVideo: TCheckBox
    Left = 8
    Top = 16
    Width = 297
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Use video'
    TabOrder = 0
  end
  object edVideoDevice: TEdit
    Left = 272
    Top = 48
    Width = 33
    Height = 21
    TabOrder = 2
    Text = 'edVideoDevice'
  end
  object edVideoFreq: TEdit
    Left = 264
    Top = 80
    Width = 41
    Height = 21
    TabOrder = 1
    Text = 'edVideoFreq'
  end
end
