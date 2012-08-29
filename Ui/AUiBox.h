/*  AUiBox functions
    Author Prof1983 <prof1983@ya.ru>
    Created 29.08.2012
    LastMod 29.08.2012 */

#ifndef AUiBox_H
#define AUiBox_H

#include "AUiBase.h"

/** Creates a new panel
    @param BoxType: 0 - Simple; 1 - HBox; 2 - VBox */
AControl
afunc AUiBox_New(AControl Parent, AInt BoxType);

#endif