/* ADirent functions
 * Author Prof1983 <prof1983@ya.ru>
 * Created 17.07.2012
 * LastMod 04.03.2013
 */

#ifndef ADir_H
#define ADir_H

#include "dirent.h"
#include "ABase"

typedef DIR* ADir;
//typedef _WDIR* ADirW;
typedef struct dirent* ADirent;
typedef struct _wdirent* ADirentW;

AInt
afunc ADir_Close(ADir Dir);

AError
afunc ADir_GetList(AStr DirName);

ADir
afunc ADir_Open(AStr DirName);

ADirent
afunc ADir_Read(ADir Dir);

AError
afunc ADir_Rewind(ADir Dir);

AError
afunc ADir_Seek(ADir Dir, AInt Pos);

AInt
afunc ADir_Tell(ADir Dir);

#endif // ADir_H
