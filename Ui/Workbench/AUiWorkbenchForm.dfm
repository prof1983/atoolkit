object WorkbenchForm: TWorkbenchForm
  Left = 0
  Top = 0
  Width = 732
  Height = 514
  Caption = 'AIAssistant'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object BottomSplitter: TSplitter
    Left = 0
    Top = 341
    Width = 724
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object LeftSplitter: TSplitter
    Left = 153
    Top = 29
    Height = 312
  end
  object RightSplitter: TSplitter
    Left = 576
    Top = 29
    Height = 312
    Align = alRight
  end
  object MainPanel: TPanel
    Left = 156
    Top = 29
    Width = 420
    Height = 312
    Align = alClient
    TabOrder = 0
  end
  object BottomToolPanel: TPanel
    Left = 0
    Top = 344
    Width = 724
    Height = 124
    Align = alBottom
    TabOrder = 1
    object PersonageImage: TImage
      Left = 1
      Top = 1
      Width = 121
      Height = 122
      Align = alLeft
      Stretch = True
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 468
    Width = 724
    Height = 19
    Panels = <>
  end
  object LeftToolPanel: TPanel
    Left = 0
    Top = 29
    Width = 153
    Height = 312
    Align = alLeft
    TabOrder = 3
  end
  object RightToolPanel: TPanel
    Left = 579
    Top = 29
    Width = 145
    Height = 312
    Align = alRight
    TabOrder = 4
  end
  object ActionMainMenuBar1: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 724
    Height = 29
    Caption = 'ActionMainMenuBar1'
    ColorMap.HighlightColor = 14410210
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = 14410210
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Spacing = 0
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items.CaptionOptions = coAll
        Items = <>
      end
      item
      end>
    Left = 176
    Top = 80
    StyleName = 'XP Style'
  end
end
