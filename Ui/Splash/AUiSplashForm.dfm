object StartForm: TStartForm
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Assistant'
  ClientHeight = 295
  ClientWidth = 573
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object LogRichEdit: TRichEdit
    Left = 8
    Top = 63
    Width = 557
    Height = 224
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 557
    Height = 49
    Caption = 'Multi Agent System'
    Color = clWhite
    TabOrder = 1
    object Image1: TImage
      Left = 1
      Top = 1
      Width = 555
      Height = 47
      Align = alClient
      Center = True
    end
  end
end
