/*  AUi
    Author Prof1983 <prof1983@ya.ru>
    Created 29.08.2012
    LastMod 29.08.2012 */

#include "AUiControls.h"
#include "AUiLibImp.h"

typedef AError
afunc (*AUiControl_Free_Proc)(AControl Control);

typedef AColor
afunc (*AUiControl_GetColor_Proc)(AControl Control);

typedef ABoolean
afunc (*AUiControl_GetEnabled_Proc)(AControl Control);

typedef AInt
afunc (*AUiControl_GetHeight_Proc)(AControl Control);

typedef AError
afunc (*AUiControl_GetHintA_Proc)(AControl Control, AStr Value, AInt MaxLength);

typedef AMenu
afunc (*AUiControl_GetMenu_Proc)(AControl Control);

typedef AError
afunc (*AUiControl_GetNameA_Proc)(AControl Control, AStr Value, AInt MaxLength);

typedef AError
afunc (*AUiControl_GetPosition_Proc)(AControl Control, AInt* Left, AInt* Top);

typedef AError
afunc (*AUiControl_GetTextA_Proc)(AControl Control, AStr Value, AInt MaxLength);

typedef ABoolean
afunc (*AUiControl_GetVisible_Proc)(AControl Control);

typedef AInt
afunc (*AUiControl_GetWidth_Proc)(AControl Control);

typedef AError
afunc (*AUiControl_SetAlign_Proc)(AControl Control, AUiAlign Align);

typedef AError
afunc (*AUiControl_SetClientSize_Proc)(AControl Control, AInt ClientWidth, AInt ClientHeight);

typedef AError
afunc (*AUiControl_SetColor_Proc)(AControl Control, AColor Color);

typedef AError
afunc (*AUiControl_SetEnabled_Proc)(AControl Control, ABoolean Value);

typedef ABoolean
afunc (*AUiControl_SetFocus_Proc)(AControl Control);

typedef AError
afunc (*AUiControl_SetFont1A_Proc)(AControl Control, AStr FontName, AInt FontSize);

typedef AInt
afunc (*AUiControl_SetHeight_Proc)(AControl Control, AInt Value);

typedef AError
afunc (*AUiControl_SetHintA_Proc)(AControl Control, AStr Value);

typedef AError
afunc (*AUiControl_SetNameA_Proc)(AControl Control, AStr Value);

typedef AError
afunc (*AUiControl_SetOnClick_Proc)(AControl Control, ACallbackProc Value);

typedef AError
afunc (*AUiControl_SetPosition_Proc)(AControl Control, AInt Left, AInt Top);

typedef AError
afunc (*AUiControl_SetSize_Proc)(AControl Control, AInt Width, AInt Height);

typedef AError
afunc (*AUiControl_SetTextA_Proc)(AControl Control, AStr Value);

typedef AError
afunc (*AUiControl_SetVisible_Proc)(AControl Control, ABoolean Value);

typedef AInt
afunc (*AUiControl_SetWidth_Proc)(AControl Control, AInt Value);

// ----

AUiControl_Free_Proc _AUiControl_Free;
AUiControl_GetColor_Proc _AUiControl_GetColor;
AUiControl_GetEnabled_Proc _AUiControl_GetEnabled;
AUiControl_GetHeight_Proc _AUiControl_GetHeight;
AUiControl_GetHintA_Proc _AUiControl_GetHintA;
AUiControl_GetMenu_Proc _AUiControl_GetMenu;
AUiControl_GetNameA_Proc _AUiControl_GetNameA;
AUiControl_GetPosition_Proc _AUiControl_GetPosition;
AUiControl_GetTextA_Proc _AUiControl_GetTextA;
AUiControl_GetVisible_Proc _AUiControl_GetVisible;
AUiControl_GetWidth_Proc _AUiControl_GetWidth;
AUiControl_SetAlign_Proc _AUiControl_SetAlign;
AUiControl_SetClientSize_Proc _AUiControl_SetClientSize;
AUiControl_SetColor_Proc _AUiControl_SetColor;
AUiControl_SetEnabled_Proc _AUiControl_SetEnabled;
AUiControl_SetFocus_Proc _AUiControl_SetFocus;
AUiControl_SetFont1A_Proc _AUiControl_SetFont1A;
AUiControl_SetHeight_Proc _AUiControl_SetHeight;
AUiControl_SetHintA_Proc _AUiControl_SetHintA;
AUiControl_SetNameA_Proc _AUiControl_SetNameA;
AUiControl_SetOnClick_Proc _AUiControl_SetOnClick;
AUiControl_SetPosition_Proc _AUiControl_SetPosition;
AUiControl_SetSize_Proc _AUiControl_SetSize;
AUiControl_SetTextA_Proc _AUiControl_SetTextA;
AUiControl_SetVisible_Proc _AUiControl_SetVisible;
AUiControl_SetWidth_Proc _AUiControl_SetWidth;

// ----

AError
afunc AUi_Boot(ALibrary Lib)
{
    _AUiControl_Free = (AUiControl_Free_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_Free");
    _AUiControl_GetColor = (AUiControl_GetColor_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_GetColor");
    _AUiControl_GetEnabled = (AUiControl_GetEnabled_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_GetEnabled");
    _AUiControl_GetHeight = (AUiControl_GetHeight_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_GetHeight");
    _AUiControl_GetHintA = (AUiControl_GetHintA_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_GetHintA");
    _AUiControl_GetMenu = (AUiControl_GetMenu_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_GetMenu");
    _AUiControl_GetNameA = (AUiControl_GetNameA_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_GetNameA");
    _AUiControl_GetPosition = (AUiControl_GetPosition_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_GetPosition");
    _AUiControl_GetTextA = (AUiControl_GetTextA_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_GetTextA");
    _AUiControl_GetVisible = (AUiControl_GetVisible_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_GetVisible");
    _AUiControl_GetWidth = (AUiControl_GetWidth_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_GetWidth");
    _AUiControl_SetAlign = (AUiControl_SetAlign_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_SetAlign");
    _AUiControl_SetClientSize = (AUiControl_SetClientSize_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_SetClientSize");
    _AUiControl_SetColor = (AUiControl_SetColor_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_SetColor");
    _AUiControl_SetEnabled = (AUiControl_SetEnabled_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_SetEnabled");
    _AUiControl_SetFocus = (AUiControl_SetFocus_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_SetFocus");
    _AUiControl_SetFont1A = (AUiControl_SetFont1A_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_SetFont1A");
    _AUiControl_SetHeight = (AUiControl_SetHeight_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_SetHeight");
    _AUiControl_SetHintA = (AUiControl_SetHintA_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_SetHintA");
    _AUiControl_SetNameA = (AUiControl_SetNameA_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_SetNameA");
    _AUiControl_SetOnClick = (AUiControl_SetOnClick_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_SetOnClick");
    _AUiControl_SetPosition = (AUiControl_SetPosition_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_SetPosition");
    _AUiControl_SetSize = (AUiControl_SetSize_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_SetSize");
    _AUiControl_SetTextA = (AUiControl_SetTextA_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_SetTextA");
    _AUiControl_SetVisible = (AUiControl_SetVisible_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_SetVisible");
    _AUiControl_SetWidth = (AUiControl_SetWidth_Proc)ALibrary_GetProcAddressA(Lib, "AUiControl_SetWidth");
    return 0;
}
