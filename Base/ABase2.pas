{**
@Author Prof1983 <prof1983@ya.ru>
@Created 06.06.2004
@LastMod 04.02.2013
}
unit ABase2;

{$I A.inc}

interface

uses
  ABase;
  //ATypes;

// --- Simple types ---
type
  Char08 = Char;
  Char16 = WideChar;
  Char016 = WideChar;
  {$ifdef ADepr}
  Int008 = AInt08;
  Int016 = AInt16;
  Int032 = AInt32;
  Int064 = AInt64;
  {$endif}
  Int128 = record I1, I2: AInt64 end;
  Int256 = record I1, I2: Int128 end;
  Float32 = Single;
  Float64 = Double;
  {$ifdef ADepr}
  UInt008 = AUInt08;
  UInt016 = AUInt16;
  UInt032 = AUInt32;
  UInt064 = AUInt64;
  {$endif}
  {$ifdef DELPHI_5}
  UInt64 = Int64;
  {$endif}
  UInt128 = record I1, I2: AUInt64 end;
  UInt256 = record I1, I2: UInt128 end;

// --- Constants ---

const
  HighInt08 = High(AInt08);
  HighInt16 = High(AInt16);
  HighInt32 = High(AInt32);
  HighInt64 = High(AInt64);
  HighUInt08 = High(AUInt08);
  HighUInt16 = High(AUInt16);
  HighUInt32 = High(AUInt32);
  HighUInt64 = High(AUInt64);
  LowInt08 = Low(AInt08);
  LowInt16 = Low(AInt16);
  LowInt32 = Low(AInt32);

  // --- Time constsnts ---
  DateTimeDay = 1;
  DateTimeHour = DateTimeDay / 24;
  DateTimeMinute = DateTimeHour / 60;
  DateTimeSecond = DateTimeMinute / 60;

  HighInt008 = HighInt08;
  HighInt016 = HighInt16;
  HighInt032 = HighInt32;
  HighInt064 = HighInt64;
  HighUInt008 = HighUInt08;
  HighUInt016 = HighUInt16;
  HighUInt032 = HighUInt32;
  HighUInt064 = HighUInt64;
  LowInt008 = LowInt08;
  LowInt016 = LowInt16;
  LowInt032 = LowInt32;
  //LowInt064 = -9223372036854775808
  timeHour = DateTimeHour;
  timeMin = DateTimeMinute;
  timeSec = DateTimeSecond;

//type // --- ALog callback object func ---
  //TProfAddToLog = function(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg, AParams: WideString; AParentId: Integer): Integer of object;

type
  THandle32 = Integer;

type
  TArrayChar08 = array of AChar;
  TArrayStr = array of string;
  {** Convert type: 0-Date+Time, 1-Date, 2-Time }
  TConvertDT = type AUInt32;
  {** Simple proc type }
  TProc = procedure;
  {** Simple info proc.
      First char of Str:
      #0 - clear all,
      #1 - write string,
      #2 - write substring
      #3#v - set progress (v = [0..255] - progress value),
      #4#n#v - set progress n=[1..] - progress bar num, v - [0..255] progress value,
      #4#0 - clear all progress }
  TProcInfo = procedure(Str: string);

implementation

end.
