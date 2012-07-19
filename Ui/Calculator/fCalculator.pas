{
LastMod: 09.09.2009
Original: Calc.pas
}

{*******************************************************}
{                                                       }
{         Delphi VCL Extensions (RX)                    }
{                                                       }
{         Copyright (c) 1995, 1996 AO ROSNO             }
{                                                       }
{*******************************************************}

unit fCalculator;

interface

uses
{$IFDEF WIN32}
  Windows,
{$ELSE}
  WinTypes, WinProcs,
{$ENDIF}
  SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Menus, ExtCtrls, Buttons, Clipbrd;

type

{ TCalculatorForm }

  TCalcState = (csFirst, csValid, csError);
  TCalculatorForm = class(TForm)
    MainPanel: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    DisplayPanel: TPanel;
    BackButton: TSpeedButton;
    ButtonC: TSpeedButton;
    ButtonMC: TSpeedButton;
    ButtonMR: TSpeedButton;
    ButtonMS: TSpeedButton;
    ButtonMP: TSpeedButton;
    Button9: TSpeedButton;
    Button6: TSpeedButton;
    Button3: TSpeedButton;
    Button7: TSpeedButton;
    Button4: TSpeedButton;
    Button1: TSpeedButton;
    Button0: TSpeedButton;
    Button8: TSpeedButton;
    Button5: TSpeedButton;
    Button2: TSpeedButton;
    ButtonPM: TSpeedButton;
    ButtonPnt: TSpeedButton;
    ButtonDiv: TSpeedButton;
    ButtonMul: TSpeedButton;
    ButtonSub: TSpeedButton;
    ButtonAdd: TSpeedButton;
    ButtonSqrt: TSpeedButton;
    ButtonPercent: TSpeedButton;
    ButtonRev: TSpeedButton;
    ButtonResult: TSpeedButton;
    MemoryLabel: TLabel;
    OkButton: TSpeedButton;
    CancelButton: TSpeedButton;
    DisplayLabel: TLabel;
    PopupMenu: TPopupMenu;
    CopyItem: TMenuItem;
    PasteItem: TMenuItem;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NumButtonClick(Sender: TObject);
    procedure ButtonPntClick(Sender: TObject);
    procedure ButtonDivClick(Sender: TObject);
    procedure ButtonMulClick(Sender: TObject);
    procedure ButtonSubClick(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonResultClick(Sender: TObject);
    procedure ButtonCClick(Sender: TObject);
    procedure BackButtonClick(Sender: TObject);
    procedure ButtonPMClick(Sender: TObject);
    procedure ButtonRevClick(Sender: TObject);
    procedure ButtonPercentClick(Sender: TObject);
    procedure ButtonSqrtClick(Sender: TObject);
    procedure ButtonMCClick(Sender: TObject);
    procedure ButtonMRClick(Sender: TObject);
    procedure ButtonMSClick(Sender: TObject);
    procedure ButtonMPClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CopyItemClick(Sender: TObject);
    procedure PasteItemClick(Sender: TObject);
    procedure CheckFirst;
    procedure OkButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
  private
    FStatus: TCalcState;
    FOperator: Char;
    FOperand: Double;
    FMemory: Double;
    procedure CalcKey(Key: Char);
    procedure Clear;
    procedure Error;
    procedure SetDisplay(R: Double);
    function GetDisplay: Double;
  end;

{ TCalculator }

  TCalculator = class(TComponent)
  private
    FValue: Double;
    FCtl3D: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean;
  published
    property Ctl3D: Boolean read FCtl3D write FCtl3D default True;
    property Value: Double read FValue write FValue;
  end;

  procedure Register;
  
implementation

{$IFNDEF WIN32}
uses Str16;
{$ENDIF}

{$R *.DFM}

const
  VK_0 = $30;
  VK_1 = $31;
  VK_2 = $32;
  VK_3 = $33;
  VK_4 = $34;
  VK_5 = $35;
  VK_6 = $36;
  VK_7 = $37;
  VK_8 = $38;
  VK_9 = $39;

{ TCalculator }

constructor TCalculator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCtl3D := True;
end;

function TCalculator.Execute: Boolean;
begin
  with TCalculatorForm.Create(Application) do
  try
    Ctl3D := FCtl3D;
    if Self.FValue <> 0 then begin
      SetDisplay(Self.FValue);
      FStatus := csFirst;
      FOperator := '=';
    end;
    Result := (ShowModal = mrOk);
    if Result then Self.FValue := StrToFloat(Trim(DisplayLabel.Caption));
  finally
    Free;
  end;
end;

{ TCalculatorForm }

procedure TCalculatorForm.Error;
begin
  FStatus := csError;
  DisplayLabel.Caption := 'Error';
end;

procedure TCalculatorForm.SetDisplay(R: Double);
var
  S: string;
begin
  S := Format('%31.16f', [R]);
  while S[Length(S)] = '0' do Delete(S, Length(S), 1);
  if S[Length(S)] = DecimalSeparator then Delete(S, Length(S), 1);
  DisplayLabel.Caption := Trim(S);
end;

function TCalculatorForm.GetDisplay: Double;
begin
  if FStatus = csError then Result := 0
  else Result := StrToFloat(Trim(DisplayLabel.Caption));
end;

procedure TCalculatorForm.CheckFirst;
begin
  if FStatus = csFirst then begin
    FStatus := csValid;
    DisplayLabel.Caption := '0';
  end;
end;

procedure TCalculatorForm.CalcKey(Key: Char);
var
  R: Double;
begin
  Key := UpCase(Key);
  if (FStatus = csError) and (Key <> 'C') then Key := ' ';
  if Key = DecimalSeparator then begin
    CheckFirst;
    if Pos(DecimalSeparator, DisplayLabel.Caption) = 0 then
      DisplayLabel.Caption := DisplayLabel.Caption + DecimalSeparator;
  end else
    case Key of
      '0'..'9': begin
        CheckFirst;
        if DisplayLabel.Caption = '0' then DisplayLabel.Caption := '';
        if Pos('E', DisplayLabel.Caption) = 0 then
          DisplayLabel.Caption := DisplayLabel.Caption + Key;
      end;
      #8: begin
        CheckFirst;
        if (Length(DisplayLabel.Caption) = 1) or
          ((Length(DisplayLabel.Caption) = 2) and
          (DisplayLabel.Caption[1] = '-'))
        then
          DisplayLabel.Caption := '0'
        else
          DisplayLabel.Caption := Copy(DisplayLabel.Caption, 1,
            Length(DisplayLabel.Caption) - 1);
      end;
      '_': SetDisplay(-GetDisplay);
      '+', '-', '*', '/', '=', '%', #13: begin
        if FStatus = csValid then begin
          FStatus := csFirst;
          R := GetDisplay;
          if Key = '%' then
            case FOperator of
              '+', '-': R := FOperand * R / 100;
              '*', '/': R := R / 100;
            end;
          case FOperator of
            '+': SetDisplay(FOperand + R);
            '-': SetDisplay(FOperand - R);
            '*': SetDisplay(FOperand * R);
            '/': if R = 0 then Error else SetDisplay(FOperand / R);
          end;
        end;
        FOperator := Key;
        FOperand := GetDisplay;
      end;
      'C': Clear;
    end;
end;

procedure TCalculatorForm.Clear;
begin
  FStatus := csFirst;
  DisplayLabel.Caption := '0';
  FOperator := '=';
end;

procedure TCalculatorForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_0..VK_9: CalcKey(Char(Key));
    VK_NUMPAD0..VK_NUMPAD9: CalcKey(Char(Key - VK_NUMPAD0 + Ord('0')));
    VK_BACK: BackButtonClick(Self);
    VK_ESCAPE: ButtonCClick(Self);
    187, VK_RETURN: ButtonResultClick(Self);
    VK_DIVIDE: ButtonDivClick(Self);
    VK_MULTIPLY: ButtonMulClick(Self);
    VK_SUBTRACT	: ButtonSubClick(Self);
    VK_ADD: ButtonAddClick(Self);
    188, 190, VK_DECIMAL: ButtonPntClick(Self);
  end;
end;

procedure TCalculatorForm.NumButtonClick(Sender: TObject);
begin
  CalcKey(Char(TComponent(Sender).Tag + Ord('0')));
end;

procedure TCalculatorForm.ButtonPntClick(Sender: TObject);
begin
  CalcKey(DecimalSeparator);
end;

procedure TCalculatorForm.ButtonDivClick(Sender: TObject);
begin
  CalcKey('/');
end;

procedure TCalculatorForm.ButtonMulClick(Sender: TObject);
begin
  CalcKey('*');
end;

procedure TCalculatorForm.ButtonSubClick(Sender: TObject);
begin
  CalcKey('-');
end;

procedure TCalculatorForm.ButtonAddClick(Sender: TObject);
begin
  CalcKey('+');
end;

procedure TCalculatorForm.ButtonResultClick(Sender: TObject);
begin
  CalcKey('=');
end;

procedure TCalculatorForm.ButtonCClick(Sender: TObject);
begin
  CalcKey('C');
end;

procedure TCalculatorForm.BackButtonClick(Sender: TObject);
begin
  CalcKey(#8);
end;

procedure TCalculatorForm.ButtonPMClick(Sender: TObject);
begin
  CalcKey('_');
end;

procedure TCalculatorForm.ButtonPercentClick(Sender: TObject);
begin
  CalcKey('%');
end;

procedure TCalculatorForm.ButtonRevClick(Sender: TObject);
begin
  FStatus := csFirst;
  if GetDisplay = 0 then Error else SetDisplay(1.0 / GetDisplay);
end;

procedure TCalculatorForm.ButtonSqrtClick(Sender: TObject);
begin
  FStatus := csFirst;
  if GetDisplay < 0 then Error else SetDisplay(Sqrt(GetDisplay));
end;

procedure TCalculatorForm.ButtonMCClick(Sender: TObject);
begin
  FMemory := 0.0;
  MemoryLabel.Caption := '';
end;

procedure TCalculatorForm.ButtonMRClick(Sender: TObject);
begin
  if (FStatus = csValid) or (FStatus = csFirst) then begin
    FStatus := csFirst;
    CheckFirst;
    SetDisplay(FMemory);
  end;
end;

procedure TCalculatorForm.ButtonMSClick(Sender: TObject);
begin
  if (FStatus = csValid) or (FStatus = csFirst) then begin
    FStatus := csFirst;
    FMemory := GetDisplay;
    if FMemory <> 0 then MemoryLabel.Caption := 'M'
    else MemoryLabel.Caption := '';
  end;
end;

procedure TCalculatorForm.ButtonMPClick(Sender: TObject);
begin
  if (FStatus = csValid) or (FStatus = csFirst) then begin
    FStatus := csFirst;
    FMemory := FMemory + GetDisplay;
    if FMemory <> 0 then MemoryLabel.Caption := 'M'
    else MemoryLabel.Caption := '';
  end;
end;

procedure TCalculatorForm.FormCreate(Sender: TObject);
begin
  FMemory := 0.0;
end;

procedure TCalculatorForm.CopyItemClick(Sender: TObject);
begin
  Clipboard.AsText := DisplayLabel.Caption;
end;

procedure TCalculatorForm.PasteItemClick(Sender: TObject);
begin
  try
    SetDisplay(StrToFloat(Trim(Clipboard.AsText)));
  except
    DisplayLabel.Caption := '0';
  end;
end;

procedure TCalculatorForm.OkButtonClick(Sender: TObject);
begin
  StrToFloat(Trim(DisplayLabel.Caption)); { to raise exception on error }
  Clipboard.AsText := DisplayLabel.Caption;
  ModalResult := mrOk;
end;

procedure TCalculatorForm.CancelButtonClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TCalculatorForm.PopupMenuPopup(Sender: TObject);
begin
  PasteItem.Enabled := Clipboard.HasFormat(CF_TEXT);
end;

procedure Register;
begin
	RegisterComponents('VladPage', [TCalculator]);
end;

end.
