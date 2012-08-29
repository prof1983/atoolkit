/*  AUiControl functions
    Author Prof1983 <prof1983@ya.ru>
    Created 29.08.2012
    LastMod 29.08.2012 */

#include "ABase"
#include "AUi.h"

AError
afunc AUiControl_Free(AControl Control);

AError
afunc AUiControl_FreeAndNil(AControl* Control);

AColor
afunc AUiControl_GetColor(AControl Control);

ABoolean
afunc AUiControl_GetEnabled(AControl Control);

AInt
afunc AUiControl_GetHeight(AControl Control);

AError
afunc AUiControl_GetHintA(AControl Control, AStr Value, AInt MaxLength);

AMenu
afunc AUiControl_GetMenu(AControl Control);

AError
afunc AUiControl_GetNameA(AControl Control, AStr Value, AInt MaxLength);

AError
afunc AUiControl_GetPosition(AControl Control, AInt* Left, AInt* Top);

AError
afunc AUiControl_GetTextA(AControl Control, AStr Value, AInt MaxLength);

ABoolean
afunc AUiControl_GetVisible(AControl Control);

AInt
afunc AUiControl_GetWidth(AControl Control);

AError
afunc AUiControl_SetAlign(AControl Control, AUiAlign Align);

AError
afunc AUiControl_SetClientSize(AControl Control, AInt ClientWidth, AInt ClientHeight);

AError
afunc AUiControl_SetColor(AControl Control, AColor Color);

AError
afunc AUiControl_SetEnabled(AControl Control, ABoolean Value);

ABoolean
afunc AUiControl_SetFocus(AControl Control);

AError
afunc AUiControl_SetFont1A(AControl Control, AStr FontName, AInt FontSize);

AInt
afunc AUiControl_SetHeight(AControl Control, AInt Value);

AError
afunc AUiControl_SetHintA(AControl Control, AStr Value);

AError
afunc AUiControl_SetNameA(AControl Control, AStr Value);

AError
afunc AUiControl_SetOnClick(AControl Control, ACallbackProc Value);

AError
afunc AUiControl_SetOnClick02(AControl Control, ACallbackProc02 Value);

AError
afunc AUiControl_SetOnClick03(AControl Control, ACallbackProc03 Value);

AError
afunc AUiControl_SetPosition(AControl Control, AInt Left, AInt Top);

AError
afunc AUiControl_SetSize(AControl Control, AInt Width, AInt Height);

AError
afunc AUiControl_SetTextA(AControl Control, AStr Value);

AError
afunc AUiControl_SetVisible(AControl Control, ABoolean Value);

AInt
afunc AUiControl_SetWidth(AControl Control, AInt Value);
