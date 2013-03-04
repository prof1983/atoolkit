/* ADirent functions
 * Author Prof1983 <prof1983@ya.ru>
 * Created 17.07.2012
 * LastMod 17.07.2012
 * Version 0.5
 */

#ifndef ADir_H
#define ADir_H

#include "dirent.h"
#include "ABase"

typedef DIR* ADir;
typedef _WDIR* ADirW;
typedef struct dirent* ADirent;
typedef struct _wdirent* ADirentW;

AInt
ADir_Close(ADir Dir);

AError
func ADir_GetList(AStr DirName);

ADir
func ADir_Open(AStr DirName);

ADirent
func ADir_Read(ADir Dir);

AError
func ADir_Rewind(ADir Dir);

AError
ADir_Seek(ADir Dir, AInt Pos);

AInt
func ADir_Tell(ADir Dir);

#endif // ADir_H
