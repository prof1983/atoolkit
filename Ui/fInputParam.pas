{
Author:  Prof1983 prof1983@yandex.ru
Created: 09.11.2009
Lastmod: 12.01.2010
}
unit fInputParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, InputParam, MyEdit;

type
  TInParamsFrm = class(TForm)
    PPanel: TPanel;
    BPanel: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure btnOkClick(Sender: TObject);
  private
    FParams: TInputParams;
    procedure BtnClick(Sender: TObject);
    function CheckRules: boolean;
  public
    procedure CheckNewVal(Sender: TObject);
    function GetEditByNum(PNum: Integer): TMaskEdit;
    function GetBtnByNum(PNum: Integer): TButton;
    procedure EnterClick(Sender: TObject; var Key: Char);
  public
    function CreateBtn(PNum: Integer; var CurPos, MaxWidth, CurLeft: Integer): Boolean;
    function CreateCheckBox(PNum: Integer; var CurPos, MaxWidth, CurLeft: Integer): Boolean;
    function CreateMaskEdit(PNum: Integer; var CurPos, MaxWidth, CurLeft: Integer): Boolean;
    function CreateMaskEditWithBtn(PNum: Integer; var CurPos, MaxWidth, CurLeft: Integer): Boolean;
    function CreateRadioGroup(PNum: Integer; var CurPos, MaxWidth, CurLeft: Integer): Boolean;
    procedure Init(Params: TInputParams);
  end;

function InputParameters(Params: TInputParams; const FormCaption: string): TModalResult;
function InputParametersChoise(const Caption, Text: string; out Res: Integer): Boolean;
function InputYearAndMonth(const Caption: string; var Year, Month: Word): Boolean;

function CreatePeriod(Prms: TInputParams; P1Name, P2Name, P1Caption, DefValues, ErrMsg: string; SameLine: Boolean): Boolean; //True - OK
function Max(a, b: Integer): Integer;

implementation

uses
  UElemF;

{$R *.DFM}

function CreatePeriod(Prms: TInputParams; P1Name, P2Name, P1Caption, DefValues, ErrMsg: string; SameLine: Boolean): Boolean;
var
   P : TInputParam;
   v,v1:String;
begin
     Result := False;
     v := Token(DefValues,1,';');
     v1 := Token(DefValues,2,';');

     P := Prms.AddParam( ipDate , P1Name , P1Caption , '' , v ,
                            6 , 0 , SameLine );
     if ( P = nil ) then
        exit;
     P := Prms.AddParam( ipDate , P2Name , '' , '' , v1 ,
                            6 , 0 , True );
     if ( P = nil ) then
        exit;
     Prms.Rules.Add( '[' + P1Name + ']<=[' + P2Name + '];' + ErrMsg );
     Result := not False;
end;

function InputParameters(Params: TInputParams; const FormCaption: string): TModalResult;
var
  Frm: TInParamsFrm;
  i: Integer;
  CurPos: Integer;
  MaxWidth: Integer;
  CtrlOK: Boolean;
  CurLinePos,
  MaxLH: Integer;
  CurLeft: Integer;
begin
  Result := mrNone;
  CurPos := 5;
  CurLinePos := 5;
  MaxLH := 0;
  MaxWidth := 0;
  CurLeft := 5;
  Frm := TInParamsFrm.Create(nil);
  Frm.Init(Params);
  try
    for i := 0 to (Params.Count - 1) do
    begin
      CtrlOK := False;
      if not(Params.Params[i].SameLine) then
      begin
        CurPos := CurPos + MaxLH;
        CurLinePos := CurPos;
        CurLeft := 5;
        MaxLH := 0;
      end;
      case Params.Params[i].ParamType of
        ipText, ipInteger, ipSum, ipDate:
          begin
            CtrlOK := Frm.CreateMaskEdit(i, CurPos, MaxWidth, CurLeft);
          end;
        ipLookUp, ipLookUpSet:
          begin
            CtrlOK := Frm.CreateMaskEditWithBtn(i, CurPos, MaxWidth, CurLeft);
          end;
        ipSet:
          begin
            CtrlOK := Frm.CreateBtn(i, CurPos, MaxWidth, CurLeft);
          end;
        ipRadioGroup:
          begin
            CtrlOK := Frm.CreateRadioGroup(i, CurPos, MaxWidth, CurLeft);
          end;
        ipCheckBox:
          begin
            CtrlOK := Frm.CreateCheckBox(i, CurPos, MaxWidth, CurLeft);
          end;
       end;
       MaxLH := Max(CurPos - CurLinePos, MaxLH);
       CurPos := CurLinePos;
       if not(CtrlOK) then
         Exit;
    end;
    Frm.Caption := FormCaption;
    Frm.ClientWidth := Max(MaxWidth + 20, 75 * 2 + 15 + 6);
    Frm.ClientHeight := CurPos + MaxLH + 45;
    Frm.btnOk.Left := (Frm.ClientWidth - (75 * 2 + 15)) div 2;
    Frm.btnCancel.Left := Frm.btnOk.Left + 75 + 15;
    Result := Frm.ShowModal;
  finally
    Frm.Free;
  end;
end;

function InputParametersChoise(const Caption, Text: string; out Res: Integer): Boolean;
var
  Params: TInputParams;
  //Form: TInParamsFrm;
begin
  Params := TInputParams.Create;
  try
    Params.AddParam(ipRadioGroup, 'P1', Text, '', '', 25, 0, True);
    Result := (InputParameters(Params, Caption) = mrOk);
    if Result then
      Res := Params.Params[0].LookUpResult;
  finally
    Params.Free;
  end;

  {Form := TInParamsFrm.Create(nil);
  try
    Form.Caption := 'Документы';
    Form.Params.AddParam(ipRadioGroup, 'P1', Text, '', '', 25, 0, True);
    Form.Init();
    Result := (Form.ShowModal = mrOk);
    if Result then
    begin
      Res := Form.Params.Params[0].LookUpResult;
    end;
  finally
    Form.Free;
  end;}
end;

function InputYearAndMonth(const Caption: string; var Year, Month: Word): Boolean;
var
  Params: TInputParams;
  //Form: TInParamsFrm;
begin
  Params := TInputParams.Create;
  try
    Params.AddParam(ipInteger, 'Month1', 'Месяц', '##', IntToStr(Month), 10, 0, False);
    Params.AddParam(ipInteger, 'Year1', 'Год', '####', IntToStr(Year), 10, 0, True);
    Result := (InputParameters(Params, Caption) = mrOk);
    if Result then
    begin
      Month := StrToInt(Params.Params[0].TextValue);
      Year := StrToInt(Params.Params[1].TextValue);
    end;
  finally
    Params.Free;
  end;

  {Form := TInParamsFrm.Create(Self);
  try
    Form.Caption := Caption;
    Form.Params.AddParam(ipInteger, 'Month1', 'Месяц', '##', IntToStr(Month), 10, 0, False);
    Form.Params.AddParam(ipInteger, 'Year1', 'Год', '####', IntToStr(Year), 10, 0, True);
    Form.Init;
    if (Form.ShowModal = mrOk) then
    begin
      Month := StrToInt(Form.Params.Params[0].TextValue);
      Year := StrToInt(Form.Params.Params[1].TextValue);
      RealisReportMonth(Core_GetExePath+'Templates\ActReport.xls', Year, Month);
    end;
  finally
    Form.Free;
  end;}
end;

function Max(a, b: Integer): Integer;
begin
  Result := Ord(a > b) * a + Ord(a <= b) * b;
end;

{ TInParamsFrm }

procedure TInParamsFrm.BtnClick(Sender: TObject);
var
  CurText: string;
  Changed: Boolean;
begin
  if not(Assigned(FParams.DoOnBtnClick)) then Exit;
  if not(Sender is TButton) then Exit;
  CurText := '';
  if (GetEditByNum(TButton(Sender).Tag) <> nil) then
    CurText := GetEditByNum(TButton(Sender).Tag).Text;
  Changed := FParams.DoOnBtnClick(TButton(Sender).Tag, CurText, FParams);
  if ( Changed and ( GetEditByNum( TButton( Sender ).Tag ) <> nil ) ) then
  begin
    GetEditByNum(TButton(Sender).Tag).Text := FParams.Params[TButton(Sender).Tag].TextValue;
  end;
  SelectNext( TWinControl( Sender ) , True , True );
end;

procedure TInParamsFrm.btnOkClick(Sender: TObject);
begin
  if not(CheckRules) then Exit;
  ModalResult := mrOK;
end;

procedure TInParamsFrm.CheckNewVal(Sender: TObject);
var
  OK: Boolean;
begin
  if (Sender is TRadioGroup) then
  begin
    FParams.Params[TRadioGroup(Sender).Tag].LookUpResult := TRadioGroup(Sender).ItemIndex;
  end;
  if (Sender is TCheckBox) then
  begin
    FParams.Params[TCheckBox(Sender).Tag].LookUpResult := Ord(TCheckBox(Sender).Checked);
  end;
  if (not((Sender is TMaskEdit) or (Sender is TFEdit))) then
    Exit;
  OK := True;
  if (Assigned(FParams.NewValueOK)) then
    OK := FParams.NewValueOK(TEdit(Sender).Tag, TEdit(Sender).Text, FParams);
  if not(OK) then
    TEdit(Sender).SetFocus
  else
  begin
    try
      FParams.Params[TEdit(Sender).Tag].TextValue := TEdit(Sender).Text;
    except
      TEdit(Sender).SetFocus;
      Exit;
    end;
  end;
end;

function TInParamsFrm.CheckRules: Boolean;
var
  RuleMess: string;
  Rule: string;
  Mess: string;
  Name1: string;
  Val1: string;
  Val2: string;
  Name2: string;
  Op: string;
  a,b: Variant;
  i: Integer;
  OK: Boolean;
begin
  Result := false;
  for i := 0 to FParams.Rules.Count - 1 do
  begin
    RuleMess := FParams.Rules.Strings[i];
    Rule := Copy(RuleMess, 1, Pos(';', RuleMess) - 1);
    Mess := Copy(RuleMess, Pos(';', RuleMess) + 1, Length(RuleMess) - Pos(';', RuleMess));
    if ((1 < Pos( ']', Rule)) and (Pos('[',Rule) = 1)) then
    begin
      Name1 := Copy( Rule , 2 , Pos( ']' , Rule ) - 2 );
      if (FParams.IndexOf(Name1) < 0) then
        Exit;
      if (FParams.Params[FParams.IndexOf(Name1)].ParamType in [ipLookUp,ipSet,ipLookUpSet,ipRadioGroup,ipCheckBox] ) then
        Val1 := IntToStr(FParams.Params[FParams.IndexOf(Name1)].LookUpResult)
      else
        Val1 := FParams.Params[FParams.IndexOf(Name1)].TextValue;
      Op := Copy(Rule, Pos(']', Rule) + 1, 2);
      Name2 := Copy(Rule, Pos(']', Rule) + 3, Length(Rule) - Length(Name1) - 2 - 2);
      if (Name2[1] = '[') then
      begin
        Name2 := Copy(Name2, 2, Length(Name2) - 2);
        if (FParams.IndexOf(Name2) < 0 ) then
          Exit;
        if (FParams.Params[FParams.IndexOf(Name2)].ParamType in [ipLookUp,ipSet,ipLookUpSet,ipRadioGroup,ipCheckBox]) then
          Val2 := IntToStr(FParams.Params[FParams.IndexOf(Name2)].LookUpResult)
        else
          Val2 := FParams.Params[FParams.IndexOf(Name2)].TextValue;
      end
      else
        Val2 := Name2;
      a := Val1;
      b := Val2;
      if (FParams.Params[FParams.IndexOf(Name1)].ParamType = ipDate) then
      begin
        a := StrToDate(Val1);
        b := StrToDate(Val2);
      end;
      if (FParams.Params[FParams.IndexOf(Name1)].ParamType = ipSum) then
      begin
        a := StrToFloat(Val1);
        b := StrToFloat(Val2);
      end;
      if ( not (( Op = '= ') or (Op = '<>') or (Op = '< ') or (Op = '<=') or (Op = '> ') or (Op = '>='))) then
        Exit;
      OK := false;
      OK := OK or ( ( Op = '= ' ) and ( a = b ) );
      OK := OK or ( ( Op = '< ' ) and ( a < b ) );
      OK := OK or ( ( Op = '<=' ) and ( a <= b ) );
      OK := OK or ( ( Op = '> ' ) and ( a > b ) );
      OK := OK or ( ( Op = '>=' ) and ( a >= b ) );
      OK := OK or ( ( Op = '<>' ) and ( a <> b ) );
      if ( not OK ) then
      begin
        ShowMess(Mess, '');
        Exit;
      end;
    end
    else
      Exit;
  end;
  Result := True;
end;

function TInParamsFrm.CreateBtn(PNum: Integer; var CurPos, MaxWidth, CurLeft: Integer): Boolean;
var
  B: TButton;
begin
  Result := False;
  B := TButton.Create(Self);
  B.Parent := PPanel;
  B.Font.Name := 'MS Sans Serif';
  B.Font.Size := 8;
  B.Font.Style := [];
  B.Height := 35;
  B.Width := FParams.Params[ PNum ].SymbLength * 8 + 4;
  B.Top := CurPos;
  B.Left := CurLeft;
  CurLeft := CurLeft + 15 + B.Width;
  MaxWidth := Max(MaxWidth, CurLeft - 30);
  B.Caption := FParams.Params[PNum].ParamCaption;
  B.Tag := PNum;
  B.OnClick := BtnClick;
  CurPos := CurPos + 36;
  Result := True;
end;

function TInParamsFrm.CreateCheckBox(PNum: Integer; var CurPos, MaxWidth, CurLeft: Integer): Boolean;
var
  CB: TCheckBox;
begin
  Result := False;
  CB := TCheckBox.Create(Self);
  CB.Parent := PPanel;
  CB.Font.Name := 'MS Sans Serif';
  CB.Font.Size := 8;
  CB.Font.Style := [];
  CB.Height := 20;
  CB.Top := CurPos;
  CB.Left := CurLeft;
  CB.Caption := FParams.Params[ PNum ].ParamCaption;
  CB.Width := {20 +} FParams.Params[ PNum ].SymbLength * 8 + 4;
  CurLeft := CurLeft + 15 + CB.Width;
  MaxWidth := Max(MaxWidth, CurLeft - 30);
  CurPos := CurPos + 16;
  CB.Tag := PNum;
  CB.Checked := (FParams.Params[PNum].LookUpResult <> 0);
  CB.OnClick := CheckNewVal;
  Result := True;
end;

function TInParamsFrm.CreateMaskEdit(PNum: Integer; var CurPos, MaxWidth, CurLeft: Integer): Boolean;
var
  L: TLabel;
  ME: TMaskEdit;
  E: TFEdit;
begin
  Result := False;
  L := TLabel.Create(Self);
  L.Parent := PPanel;
  L.Font.Name := 'MS Sans Serif';
  L.Font.Size := 8;
  L.Font.Style := [];
  L.Height := 13;
  L.Top := CurPos;
  if not(FParams.OneStr) then
    CurPos := CurPos + 15;
  L.Left := CurLeft;
  L.AutoSize := True;
  L.Caption := FParams.Params[PNum].ParamCaption;
  if (FParams.OneStr) then
    CurLeft := CurLeft + 15 * 8 + 4;
  if (L.Caption = '') then
  begin
    L.AutoSize := False;
    L.Free;
  end;
  if (FParams.Params[PNum].ParamType = ipSum) then
  begin
    E := TFEdit.Create(Self);
    E.Parent := PPanel;
    E.Font.Name := 'MS Sans Serif';
    E.Font.Size := 8;
    E.Font.Style := [];
    E.Height := 20;
    E.Top := CurPos;
    CurPos := CurPos + 21;
    E.Left := CurLeft;
    E.Width := FParams.Params[PNum].SymbLength * 8 + 4;
    CurLeft := CurLeft + 15 + E.Width;
    MaxWidth := Max(MaxWidth, CurLeft - 30);
    E.Enabled := True;
    E.DisplayFormat := '0.00;- 0.00';
    E.Tag := PNum;
    E.OnExit := CheckNewVal;
    E.Value := 0;
    try
      E.Value := StrToFloat(FParams.Params[PNum].TextValue);
    except
    end;
  end
  else
  begin
    ME := TMaskEdit.Create(Self);
    ME.Parent := PPanel;
    ME.Font.Name := 'MS Sans Serif';
    ME.Font.Size := 8;
    ME.Font.Style := [];
    ME.Height := 20;
    ME.Top := CurPos;
    CurPos := CurPos + 21;
    ME.Left := CurLeft;
    ME.Width := FParams.Params[PNum].SymbLength * 8 + 4;
    CurLeft := CurLeft + 15 + ME.Width;
    MaxWidth := Max(MaxWidth, CurLeft - 30);
    ME.Enabled := True;
    ME.EditMask := FParams.Params[PNum].Mask;
    ME.Tag := PNum;
    ME.OnExit := CheckNewVal;
    ME.Text := FParams.Params[PNum].TextValue;
  end;
  Result := True;
end;

function TInParamsFrm.CreateMaskEditWithBtn(PNum: Integer; var CurPos, MaxWidth, CurLeft: Integer): Boolean;
var
  L: TLabel;
  ME: TMaskEdit;
  B: TButton;
begin
  Result := False;
  L := TLabel.Create(Self);
  L.Parent := PPanel;
  L.Font.Name := 'MS Sans Serif';
  L.Font.Size := 8;
  L.Font.Style := [];
  L.Height := 13;
  L.Top := CurPos;
  if not(FParams.OneStr) then
    CurPos := CurPos + 15;
  L.Left := CurLeft;
  L.AutoSize := True;
  L.Caption := FParams.Params[PNum].ParamCaption;
  if (FParams.OneStr) then
    CurLeft := CurLeft + 15 * 8 + 4;
  ME := TMaskedit.Create(Self);
  ME.Parent := PPanel;
  ME.Font.Name := 'MS Sans Serif';
  ME.Font.Size := 8;
  ME.Font.Style := [];
  ME.Height := 20;
  ME.Top := CurPos;
  ME.Left := CurLeft;
  ME.Width := FParams.Params[PNum].SymbLength * 8 + 4;
  ME.Enabled := True;
  ME.EditMask := '';
  ME.Text := FParams.Params[PNum].TextValue;
  ME.Tag := PNum;
  ME.TabStop := False;
  ME.OnKeyPress := EnterClick;
  //ME.OnExit := Frm.CheckNewVal;
  B := TButton.Create(Self);
  B.Parent := PPanel;
  B.Font.Name := 'MS Sans Serif';
  B.Font.Size := 8;
  B.Font.Style := [];
  B.Height := 18;
  B.Width := 20;
  B.Top := CurPos + 2;
  B.Left := CurLeft + ME.Width - 22;
  CurLeft := CurLeft + 15 + ME.Width;
  MaxWidth := Max(MaxWidth, CurLeft - 30);
  B.Caption := '...';
  B.Tag := PNum;
  B.OnClick := BtnClick;
  CurPos := CurPos + 21;
  Result := True;
end;

function TInParamsFrm.CreateRadioGroup(PNum: Integer; var CurPos, MaxWidth, CurLeft: Integer): Boolean;
var
  RG: TRadioGroup;
  Cap: string;
  MaxItemL: Integer;
begin
  Result := False;
  RG := TRadioGroup.Create(Self);
  RG.Parent := PPanel;
  RG.Font.Name := 'MS Sans Serif';
  RG.Font.Size := 8;
  RG.Font.Style := [];
  RG.Top := CurPos;
  RG.Left := CurLeft;
  Cap := FParams.Params[PNum].ParamCaption;
  RG.Caption := Copy(Cap, 1, Pos(';', Cap) - 1);
  Cap := Copy(Cap, Pos(';', Cap) + 1, Length(Cap) - Pos(';', Cap));
  MaxItemL := 0;
  while (Pos(';', Cap) <> 0) do
  begin
    RG.Items.Add(Copy(Cap , 1 , Pos(';', Cap) - 1));
    MaxItemL := Max(MaxItemL, Length(Copy(Cap, 1, Pos(';', Cap) - 1)));
    Cap := Copy(Cap, Pos(';', Cap) + 1, Length(Cap) - Pos(';', Cap));
  end;
  if (MaxItemL = 0) then
    Exit;
  if (FParams.Params[PNum].SymbLength = 0) then
    RG.Width := 20 * 8 + 4
  else
    RG.Width := {10 +} FParams.Params[PNum].SymbLength * 8 + 4;
  CurLeft := CurLeft + 15 + RG.Width;
  MaxWidth := Max(MaxWidth, CurLeft - 30);
  // PH
  RG.Columns := Max(Round(Int(RG.Width / ({10 + 18 +} MaxItemL * 8 + 4))), 1);
  RG.Height := 14 + 25 * (Round(Int(RG.Items.Count / RG.Columns)) + Ord(((Int(RG.Items.Count / RG.Columns)) - (RG.Items.Count / RG.Columns)) < 0));
  CurPos := CurPos + 1 + RG.Height;
  RG.Tag := PNum;
  RG.ItemIndex := FParams.Params[PNum].LookUpResult;
  RG.OnClick := CheckNewVal;
  Result := True;
end;

procedure TInParamsFrm.EnterClick(Sender: TObject; var Key: Char);
var
  B: TButton;
begin
  if (Key = #13) then
  begin
    B := GetBtnByNum(TEdit(Sender).Tag);
    if (B <> nil) then
      B.OnClick(B);
  end;
end;

function TInParamsFrm.GetBtnByNum(PNum: Integer): TButton;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to (ComponentCount - 1) do
  begin
    if ((Components[i] is TButton) and (TButton(Components[i]).Tag = PNum)) then
    begin
      Result := TButton(Components[i]);
      Exit;
    end;
  end;
end;

function TInParamsFrm.GetEditByNum(PNum: Integer): TMaskEdit;
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if ((Components[i] is TMaskEdit) and (TMaskEdit(Components[i]).Tag = PNum)) then
    begin
      Result := TMaskEdit(Components[i]);
      Exit;
    end;
  end;
  Result := nil;
end;

procedure TInParamsFrm.Init(Params: TInputParams);
begin
  FParams := Params;
end;

end.
