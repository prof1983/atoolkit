{
Abstract AToolkit define
Author Prof1983 <prof1983@ya.ru>
Created 18.06.2011
LastMod 15.02.2013
}

  // RadStudio XE3
  {$ifdef VER240}
    {$define Compiler_17}
    {$define Compiler_17_Up}
    {$define Delphi}
    {$define Delphi17}
    {$define Delphi17Up}
    {$define DelphiXE3}
    {$define DelphiXE3Up}
    {$define Delphi_17}
    {$define Delphi_17_Up}
    {$define Delphi_XE3}
    {$define Delphi_XE3_Up}
  {$endif}

  // RadStudio XE2
  {$ifdef VER230}
    {$define Compiler_16}
    {$define Compiler_16_Up}
    {$define Delphi}
    {$define Delphi16}
    {$define Delphi16Up}
    {$define DelphiXE2}
    {$define DelphiXE2Up}
    {$define Delphi_16}
    {$define Delphi_16_Up}
    {$define Delphi_XE2}
    {$define Delphi_XE2_Up}
  {$endif}

  // Rad Studio XE
  {$ifdef VER220}
    {$define Compiler_15}
    {$define Compiler_15_Up}
    {$define Delphi}
    {$define Delphi15}
    {$define Delphi15Up}
    {$define DelphiXE}
    {$define DelphiXEUp}
    {$define Delphi_15}
    {$define Delphi_15_Up}
    {$define Delphi_2011}
    {$define Delphi_2011_Up}
    {$define Delphi_XE}
    {$define Delphi_XE_Up}
  {$endif}

  // Delphi 2010
  {$ifdef VER210}
    {$define Compiler_13}
    {$define Compiler_13_Up}
    {$define Delphi}
    {$define Delphi13}
    {$define Delphi13Up}
    {$define Delphi2010}
    {$define Delphi2010Up}
    {$define Delphi_13}
    {$define Delphi_13_Up}
    {$define Delphi_2010}
    {$define Delphi_2010_Up}
  {$endif}

  // Delphi 2009
  {$ifdef VER200}
    {$define Compiler_12}
    {$define Compiler_12_Up}
    {$define Delphi}
    {$define Delphi12}
    {$define Delphi12Up}
    {$define Delphi2009}
    {$define Delphi2009Up}
    {$define Delphi_12}
    {$define Delphi_12_Up}
    {$define Delphi_2009}
    {$define Delphi_2009_Up}
  {$endif}

  // Delphi 2007
  {$ifdef VER190}
    {$define Compiler_11}
    {$define Compiler_11_Up}
    {$define Delphi}
    {$define Delphi11}
    {$define Delphi11Up}
    {$define Delphi2007}
    {$define Delphi2007Up}
    {$define Delphi_11}
    {$define Delphi_11_Up}
    {$define Delphi_2007}
    {$define Delphi_2007_Up}
  {$ENDIF}

  // Delphi 2006
  {$ifdef VER180}
    {$define Compiler_10}
    {$define Compiler_10_Up}
    {$define Delphi}
    {$define Delphi10}
    {$define Delphi10Up}
    {$define Delphi2006}
    {$define Delphi2006Up}
    {$define Delphi_10}
    {$define Delphi_10_Up}
    {$define Delphi_2006}
    {$define Delphi_2006_Up}
  {$endif}

  // Delphi 2005
  {$ifdef VER170}
    {$define Compiler_9}
    {$define Compiler_9_Up}
    {$define Delphi}
    {$define Delphi9}
    {$define Delphi9Up}
    {$define Delphi2005}
    {$define Delphi2005Up}
    {$define Delphi_9}
    {$define Delphi_9_Up}
    {$define Delphi_2005}
    {$define Delphi_2005_Up}
  {$endif}

  {$ifdef VER160}
    {$define Delphi8}
    {$define Delphi8Up}
  {$endif}

  // Delphi 7
  {$ifdef VER150}
    {$define Compiler_7}
    {$define Compiler_7_Up}
    {$define Delphi}
    {$define Delphi7}
    {$define Delphi7Up}
    {$define Delphi_7}
    {$define Delphi_7_Up}
  {$endif}

  // Delphi 6
  {$IFDEF VER140}
    {$define Compiler_6}
    {$define Compiler_6_Up}
    {$ifdef BCB}
      {$define CPPB}
      {$define CPPB_6}
    {$else}
      {$define Delphi}
      {$define Delphi6}
      {$define Delphi_6}
      {$define Delphi_6_Up}
    {$endif}
  {$ENDIF}

  {$ifdef VER130}
    {$define Compiler_5}
    {$define Compiler_5_Up}
    {$ifdef BCB}
      {$define CPPB}
      {$define CPPB_5}
    {$else}
      {$define Delphi}
      {$define Delphi5}
      {$define Delphi_5}
      {$define Delphi_5_Up}
    {$endif}
  {$endif}

  {$ifdef VER125}
    {$define Compiler_4}
    {$define Compiler_4_Up}
    {$define CPPB}
    {$define CPPB_4}
    {$define Delphi4}
  {$endif}

  {$ifdef VER120}
    {$define Compiler_4}
    {$define Delphi}
    {$define Delphi4}
    {$define Delphi4Up}
    {$define Delphi_4}
    {$define Delphi_4_Up}
  {$endif}

  {$ifdef VER110}
    {$define COMPILER_3}
    {$define CPPB}
    {$define CPPB_3}
    {$define Delphi3}
  {$endif}

  {$ifdef VER100}
    {$define Compiler_3}
    {$define Compiler_3_Up}
    {$define Delphi}
    {$define Delphi3}
    {$define Delphi3Up}
    {$define Delphi_3}
    {$define Delphi_3_Up}
  {$endif}

  {$ifdef VER93}
    {$define Compiler_2} // C++ Builder v1 compiler is really v2
    {$define Compiler_2_Up}
    {$define CPPB}
    {$define CPPB_1}
  {$endif}

  {$ifdef VER90}
    {$define Compiler_2}
    {$define Compiler_2_Up}
    {$define Delphi}
    {$define Delphi2}
    {$define Delphi2Up}
    {$define Delphi_2}
    {$define Delphi_2_Up}
  {$endif}

  {$ifdef VER80}
    {$define Compiler_1}
    {$define Compiler_1_Up}
    {$define Delphi}
    {$define Delphi1}
    {$define Delphi_1}
  {$endif}

  {$ifdef Delphi17Up} {$define Delphi16Up} {$endif}
  {$ifdef Delphi16Up} {$define Delphi15Up} {$endif}
  {$ifdef Delphi15Up} {$define Delphi13Up} {$endif}
  {$ifdef Delphi13Up} {$define Delphi12Up} {$endif}
  {$ifdef Delphi12Up} {$define Delphi11Up} {$endif}
  {$ifdef Delphi11Up} {$define Delphi10Up} {$endif}
  {$ifdef Delphi10Up} {$define Delphi9Up} {$endif}
  {$ifdef Delphi9Up} {$define Delphi8Up} {$endif}
  {$ifdef Delphi8Up} {$define Delphi7Up} {$endif}
  {$ifdef Delphi7Up} {$define Delphi6Up} {$endif}
  {$ifdef Delphi6Up} {$define Delphi5Up} {$endif}
  {$ifdef Delphi5Up} {$define Delphi4Up} {$endif}
  {$ifdef Delphi4Up} {$define Delphi3Up} {$endif}
  {$ifdef Delphi3Up} {$define Delphi2Up} {$endif}
  {$ifdef Delphi2Up} {$define Delphi1Up} {$endif}

  {$IFDEF DELPHI_17_UP} {$DEFINE DELPHI_16_UP} {$ENDIF}
  {$IFDEF DELPHI_16_UP} {$DEFINE DELPHI_15_UP} {$ENDIF}
  {$IFDEF DELPHI_15_UP} {$DEFINE DELPHI_13_UP} {$ENDIF}
  {$IFDEF DELPHI_13_UP} {$DEFINE DELPHI_12_UP} {$ENDIF}
  {$IFDEF DELPHI_12_UP} {$DEFINE DELPHI_11_UP} {$ENDIF}
  {$IFDEF DELPHI_11_UP} {$DEFINE DELPHI_10_UP} {$ENDIF}
  {$IFDEF DELPHI_10_UP} {$DEFINE DELPHI_9_UP} {$ENDIF}
  {$IFDEF DELPHI_9_UP} {$DEFINE DELPHI_8_UP} {$ENDIF}
  {$IFDEF DELPHI_8_UP} {$DEFINE DELPHI_7_UP} {$ENDIF}
  {$IFDEF DELPHI_7_UP} {$DEFINE DELPHI_6_UP} {$ENDIF}
  {$IFDEF DELPHI_6_UP} {$DEFINE DELPHI_5_UP} {$ENDIF}
  {$IFDEF DELPHI_5_UP} {$DEFINE DELPHI_4_UP} {$ENDIF}
  {$IFDEF DELPHI_4_UP} {$DEFINE DELPHI_3_UP} {$ENDIF}
  {$IFDEF DELPHI_3_UP} {$DEFINE DELPHI_2_UP} {$ENDIF}
  {$IFDEF DELPHI_2_UP} {$DEFINE DELPHI_1_UP} {$ENDIF}

  {$ifdef DelphiXE3Up} {$define DelphiXE2Up} {$endif}
  {$ifdef DelphiXE2Up} {$define DelphiXEUp} {$endif}
  {$ifdef DelphiXEUp} {$define Delphi2010Up} {$endif}
  {$ifdef Delphi2010Up} {$define Delphi2007Up} {$endif}
  {$ifdef Delphi2007Up} {$define Delphi2006Up} {$endif}
  {$ifdef Delphi2006Up} {$define Delphi2005Up} {$endif}

  {$IFDEF DELPHI_XE3_UP} {$DEFINE DELPHI_XE2_UP} {$ENDIF}
  {$IFDEF DELPHI_XE2_UP} {$DEFINE DELPHI_XE_UP} {$ENDIF}
  {$IFDEF DELPHI_XE_UP} {$DEFINE DELPHI_2011_UP} {$ENDIF}
  {$IFDEF DELPHI_2011_UP} {$DEFINE DELPHI_2010_UP} {$ENDIF}
  {$IFDEF DELPHI_2010_UP} {$DEFINE DELPHI_2007_UP} {$ENDIF}
  {$IFDEF DELPHI_2007_UP} {$DEFINE DELPHI_2006_UP} {$ENDIF}
  {$IFDEF DELPHI_2006_UP} {$DEFINE DELPHI_2005_UP} {$ENDIF}

  {$ifdef CPPB_3}
    {$define CPPB_3_UP}
  {$endif}

  {$ifdef CPPB_4}
    {$define CPPB_3_UP}
    {$define CPPB_4_UP}
  {$endif}

  {$ifdef CPPB_5}
    {$define CPPB_3_UP}
    {$define CPPB_4_UP}
    {$define CPPB_5_UP}
  {$endif}

  {$ifdef CPPB_6}
    {$define CPPB_3_UP}
    {$define CPPB_4_UP}
    {$define CPPB_5_UP}
    {$define CPPB_6_UP}
  {$endif}

  {$ifdef CPPB_3_UP}
    // C++ Builder requires this if you use Delphi components in run-time packages.
    {$ObjExportAll On}
  {$endif}

// -------------------------------------------------------------------------------------------------

// Compiler defines common to all platforms.
{$IFDEF COMPILER_17_UP} {$DEFINE COMPILER_16_UP} {$ENDIF}
{$IFDEF COMPILER_16_UP} {$DEFINE COMPILER_15_UP} {$ENDIF}
{$IFDEF COMPILER_15_UP} {$DEFINE COMPILER_13_UP} {$ENDIF}
{$IFDEF COMPILER_13_UP} {$DEFINE COMPILER_12_UP} {$ENDIF}
{$IFDEF COMPILER_12_UP} {$DEFINE COMPILER_11_UP} {$ENDIF}
{$IFDEF COMPILER_11_UP} {$DEFINE COMPILER_10_UP} {$ENDIF}
{$IFDEF COMPILER_10_UP} {$DEFINE COMPILER_9_UP} {$ENDIF}
{$IFDEF COMPILER_9_UP} {$DEFINE COMPILER_8_UP} {$ENDIF}
{$IFDEF COMPILER_8_UP} {$DEFINE COMPILER_7_UP} {$ENDIF}
{$IFDEF COMPILER_7_UP} {$DEFINE COMPILER_6_UP} {$ENDIF}
{$IFDEF COMPILER_6_UP} {$DEFINE COMPILER_5_UP} {$ENDIF}
{$IFDEF COMPILER_5_UP} {$DEFINE COMPILER_4_UP} {$ENDIF}
{$IFDEF COMPILER_4_UP} {$DEFINE COMPILER_3_UP} {$ENDIF}
{$IFDEF COMPILER_3_UP} {$DEFINE COMPILER_2_UP} {$ENDIF}

// -------------------------------------------------------------------------------------------------

{$IFDEF CLR} {$DEFINE DOTNET} {$ENDIF}

// -------------------------------------------------------------------------------------------------

{ALIGN ON}
{BOOLEVAL OFF}

{$IFDEF COMPILER_6_UP}
  {$WARN SYMBOL_PLATFORM OFF} { We are going to use Win32 specific symbols! }
{$ENDIF}

{$IFDEF COMPILER_7_UP}
  {$WARN UNSAFE_CODE OFF} { We are not going to be "safe"! }
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CAST OFF}
{$ENDIF}