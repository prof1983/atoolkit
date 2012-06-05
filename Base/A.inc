{
Abstract(A define)
Author(Prof1983 prof1983@ya.ru)
Created(18.06.2011)
LastMod(05.06.2012)
Version(0.5)
}

  // RadStudio XE2
  {$IFDEF VER230}
    {$DEFINE COMPILER_15}
    {$DEFINE DELPHI}
    {$DEFINE DELPHI_15}
    {$DEFINE DELPHI_XE2}
  {$ENDIF}

  // Rad Studio XE
  {$IFDEF VER220}
    {$DEFINE COMPILER_15}
    {$DEFINE DELPHI}
    {$DEFINE DELPHI_15}
    {$DEFINE DELPHI_2011}
    {$DEFINE DELPHI_XE}
  {$ENDIF}

  // Delphi 2010
  {$IFDEF VER210}
    {$DEFINE COMPILER_13}
    {$DEFINE DELPHI}
    {$DEFINE DELPHI_13}
    {$DEFINE DELPHI_2010}
  {$ENDIF}

  // Delphi 2009
  {$IFDEF VER200}
    {$DEFINE COMPILER_12}
    {$DEFINE DELPHI}
    {$DEFINE DELPHI_12}
    {$DEFINE DELPHI_2009}
  {$ENDIF}

  // Delphi 2007
  {$IFDEF VER190}
    {$DEFINE COMPILER_11}
    {$DEFINE DELPHI}
    {$DEFINE DELPHI_11}
    {$DEFINE DELPHI_2007}
  {$ENDIF}

  // Delphi 2006
  {$IFDEF VER180}
    {$define COMPILER_10}
    {$define DELPHI}
    {$define DELPHI_10}
  {$ENDIF}

  // Delphi 2005
  {$IFDEF VER170}
    {$define COMPILER_9}
    {$define DELPHI}
    {$define DELPHI_9}
  {$ENDIF}

  // Delphi 7
  {$IFDEF VER150}
    {$define COMPILER_7}
    {$define DELPHI}
    {$define DELPHI_7}
  {$ENDIF}

  // Delphi 6
  {$IFDEF VER140}
    {$define COMPILER_6}
    {$ifdef BCB}
      {$define CPPB}
      {$define CPPB_6}
    {$else}
      {$define DELPHI}
      {$define DELPHI_6}
    {$endif}
  {$ENDIF}

  {$IFDEF VER130}
    {$define COMPILER_5}
    {$ifdef BCB}
      {$define CPPB}
      {$define CPPB_5}
    {$else}
      {$define DELPHI}
      {$define DELPHI_5}
    {$endif}
  {$ENDIF}

  {$IFDEF VER125}
    {$define COMPILER_4}
    {$define CPPB}
    {$define CPPB_4}
  {$ENDIF}

  {$IFDEF VER120}
    {$define COMPILER_4}
    {$define DELPHI}
    {$define DELPHI_4}
  {$ENDIF}

  {$IFDEF VER110}
    {$define COMPILER_3}
    {$define CPPB}
    {$define CPPB_3}
  {$ENDIF}

  {$IFDEF VER100}
    {$define COMPILER_3}
    {$define DELPHI}
    {$define DELPHI_3}
  {$ENDIF}

  {$IFDEF VER93}
    {$define COMPILER_2} // C++ Builder v1 compiler is really v2
    {$define CPPB}
    {$define CPPB_1}
  {$ENDIF}

  {$IFDEF VER90}
    {$define COMPILER_2}
    {$define DELPHI}
    {$define DELPHI_2}
  {$ENDIF}

  {$IFDEF VER80}
    {$define COMPILER_1}
    {$define DELPHI}
    {$define DELPHI_1}
  {$ENDIF}

  {$IFDEF DELPHI_2} {$DEFINE DELPHI_2_UP} {$ENDIF}
  {$IFDEF DELPHI_3} {$DEFINE DELPHI_3_UP} {$ENDIF}
  {$IFDEF DELPHI_4} {$DEFINE DELPHI_4_UP} {$ENDIF}
  {$IFDEF DELPHI_5} {$DEFINE DELPHI_5_UP} {$ENDIF}
  {$IFDEF DELPHI_6} {$DEFINE DELPHI_6_UP} {$ENDIF}
  {$IFDEF DELPHI_7} {$DEFINE DELPHI_7_UP} {$ENDIF}
  {$IFDEF DELPHI_9} {$DEFINE DELPHI_9_UP} {$ENDIF}
  {$IFDEF DELPHI_10} {$DEFINE DELPHI_10_UP} {$ENDIF}
  {$IFDEF DELPHI_11} {$DEFINE DELPHI_11_UP} {$ENDIF}
  {$IFDEF DELPHI_12} {$DEFINE DELPHI_12_UP} {$ENDIF}
  {$IFDEF DELPHI_13} {$DEFINE DELPHI_13_UP} {$ENDIF}
  {$IFDEF DELPHI_15} {$DEFINE DELPHI_15_UP} {$ENDIF}

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

  {$IFDEF DELPHI_2005} {$DEFINE DELPHI_2005_UP} {$ENDIF}
  {$IFDEF DELPHI_2006} {$DEFINE DELPHI_2006_UP} {$ENDIF}
  {$IFDEF DELPHI_2007} {$DEFINE DELPHI_2007_UP} {$ENDIF}
  {$IFDEF DELPHI_2010} {$DEFINE DELPHI_2010_UP} {$ENDIF}
  {$IFDEF DELPHI_2011} {$DEFINE DELPHI_2011_UP} {$ENDIF}
  {$IFDEF DELPHI_XE} {$DEFINE DELPHI_XE_UP} {$ENDIF}
  {$IFDEF DELPHI_XE2} {$DEFINE DELPHI_XE2_UP} {$ENDIF}

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
{$IFDEF COMPILER_1} {$DEFINE COMPILER_1_UP} {$ENDIF}
{$IFDEF COMPILER_2} {$DEFINE COMPILER_2_UP} {$ENDIF}
{$IFDEF COMPILER_3} {$DEFINE COMPILER_3_UP} {$ENDIF}
{$IFDEF COMPILER_4} {$DEFINE COMPILER_4_UP} {$ENDIF}
{$IFDEF COMPILER_5} {$DEFINE COMPILER_5_UP} {$ENDIF}
{$IFDEF COMPILER_6} {$DEFINE COMPILER_6_UP} {$ENDIF}
{$IFDEF COMPILER_7} {$DEFINE COMPILER_7_UP} {$ENDIF}
{$IFDEF COMPILER_9} {$DEFINE COMPILER_9_UP} {$ENDIF}
{$IFDEF COMPILER_10} {$DEFINE COMPILER_10_UP} {$ENDIF}
{$IFDEF COMPILER_11} {$DEFINE COMPILER_11_UP} {$ENDIF}
{$IFDEF COMPILER_12} {$DEFINE COMPILER_12_UP} {$ENDIF}
{$IFDEF COMPILER_13} {$DEFINE COMPILER_13_UP} {$ENDIF}
{$IFDEF COMPILER_15} {$DEFINE COMPILER_15_UP} {$ENDIF}

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

{$IFDEF ver100} {$DEFINE Delphi3} {$ENDIF}
{$IFDEF ver110} {$DEFINE Delphi3} {$ENDIF}
{$IFDEF ver120} {$DEFINE Delphi4} {$ENDIF}
{$IFDEF VER125} {$DEFINE Delphi4} {$ENDIF}
{$IFDEF VER130} {$DEFINE Delphi5} {$ENDIF}
{$IFDEF VER140} {$DEFINE Delphi6} {$ENDIF}
{$IFDEF VER150} {$DEFINE Delphi7} {$ENDIF}
{$IFDEF VER160} {$DEFINE Delphi8} {$ENDIF}
{$IFDEF VER170} {$DEFINE Delphi9} {$ENDIF}
{$IFDEF CLR} {$DEFINE DOTNET} {$ENDIF}     
// -----------------------------------------------------------------------------
{$IFDEF Delphi3}
  {$DEFINE Delphi3Up}
{$ENDIF}
{$IFDEF Delphi4}
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
{$ENDIF}
{$IFDEF Delphi5}
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
{$ENDIF}
{$IFDEF Delphi6}
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
{$ENDIF}
{$IFDEF Delphi7}
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
{$ENDIF}
{$IFDEF Delphi8}
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
{$ENDIF}
{$IFDEF Delphi9}
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
{$ENDIF}

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