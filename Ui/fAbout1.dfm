object AboutForm: TAboutForm
  Left = 303
  Top = 125
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 133
  ClientWidth = 312
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    27777777777777777777777700000000A2222222222222222222222700000000
    A2222222222222222222222700000000A2222222222222222222222700000000
    A2222222222222222222222700000000AAAAAAAAAAAAAAAAAAAAAAA200000000
    0000888777777777000000000000000000088888888777770000000000000000
    0008888888888888000000000000000000008888888888888888000000000000
    0000000088888888888880000000000000000000777788888888800000000000
    0000888777777777788800000000000000088888888777770000000000000000
    0008888888888888000000000000000000008888888888888888000000000000
    0000000088888888888880000000000000000000777788888888800000000000
    0000888777777777788800000000000000088888888777770000000000000000
    0008888888800000000000000000000000008888888000000000000000000000
    0000000088800000000000000000000000277777777777777777770000000000
    00A2222222222222222227000000000000A22222222222222222270000000000
    00AAAAAAAAAAAAAAAAAAA200000000000000FFF000FFF0000FFF000000000000
    0000FFF000FFF0000FFF0000000000000000FFF000FFF0000FFF000000000000
    0000FFF000FFF0000FFF0000000000000000FFF000FFF0000FFF00000000F000
    000FF000000FF000000FF000000FF000000FF000000FFF000FFFFE000FFFFE00
    0FFFFF0000FFFFF0007FFFF0007FFF0000FFFE000FFFFE000FFFFF0000FFFFF0
    007FFFF0007FFF0000FFFE000FFFFE01FFFFFF01FFFFFFF1FFFFFC00003FFC00
    003FFC00003FFC00003FFFBEFDFFFF1C78FFFFBEFDFFFFBEFDFFFFBEFDFF}
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    312
    133)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 99
    Width = 312
    Height = 34
    Align = alBottom
    Shape = bsTopLine
  end
  object lbName: TLabel
    Left = 96
    Top = 0
    Width = 215
    Height = 33
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'lbName'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
    WordWrap = True
  end
  object lbWWW: TLabel
    Left = 4
    Top = 85
    Width = 55
    Height = 13
    Cursor = crHandPoint
    Anchors = [akLeft, akBottom]
    Caption = 'aikernel.org'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = lbWWWClick
  end
  object Panel1: TPanel
    Left = 4
    Top = 4
    Width = 83
    Height = 83
    BevelInner = bvLowered
    TabOrder = 0
    object Image1: TImage
      Left = 2
      Top = 2
      Width = 79
      Height = 79
      Align = alClient
      Center = True
      Transparent = True
    end
  end
  object BitBtn1: TBitBtn
    Left = 234
    Top = 106
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
  end
  object DescriptionMemo: TMemo
    Left = 91
    Top = 39
    Width = 220
    Height = 58
    Color = clBtnFace
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
end
