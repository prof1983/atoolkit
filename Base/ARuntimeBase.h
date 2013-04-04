/*  ARuntime base consts and types
 *  Author Prof1983 <prof1983@ya.ru>
 *  Created 04.03.2013
 *  LastMod 04.04.2013
 */

#ifndef ARuntimeBaseH
#define ARuntimeBaseH

#include "ABase.h"

// --- Types ---------------------------------------------------------------------------------------

/** Module description */
typedef APointer AModuleDescription;

/** The unique identifier of the module
    Format: $YYMMDDxx, YY - Year, MM - Month, DD - Day, xx - Number */
typedef AInt AModuleUid;

// ----

typedef AError AFunction (*AModuleFinProc)();
typedef AError AFunction (*AModuleInitProc)();
typedef APointer AFunction (*AModuleGetProc)(AStr ProcName);

typedef APointer AFunction (*ARuntime_GetProcByName_Proc)(AStr ModuleName, AStr ProcName);

// --- Module ---

typedef struct {
    /** Module version ($AABBCCDD) */
    AVersion Version;
    /** Module unique identificator $YYMMDDxx YY - Year, MM - Month, DD - Day */
    AModuleUid Uid;
    /** Module unuque name */
    AStr Name;
    /** Module information and description */
    AModuleDescription Description;
    /** Initialize proc */
    AModuleInitProc Init;
    /** Finalize proc */
    AModuleFinProc Fin;
    /** Get proc address */
    AModuleGetProc GetProc;
    /** Module proc list */
    APointer Procs;
} AModule_Type;

typedef AModule_Type* AModule;

#endif
