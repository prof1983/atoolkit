/* Dirent functions
 * Author Prof1983 <prof1983@ya.ru>
 * Created 17.07.2012
 * LastMod 04.03.2013
 */

#ifndef AIoDirC
#define AIoDirC

#include "AIoDir.h"

AInt
afunc ADir_Close(ADir Dir)
{
    return closedir(Dir);
}

/*
AInt
afunc ADir_CloseW(ADirW Dir)
{
    return _wclosedir(Dir);
}
*/

AError
afunc ADir_GetList(AStr DirName)
{
    ADir dp;
    ADirent ep; //struct dirent *ep;

    //stat()

    dp = ADir_Open(DirName);
    if (dp != NULL)
    {
        while (ep = ADir_Read(dp))
            puts(ep->d_name);
        ADir_Close(dp);
    }
    else
        return -2; //perror("Couldn't open the directory");

    return 0;
}

ADir
afunc ADir_Open(AStr DirName)
{
    return opendir(DirName);
}

/*
ADirW
afunc ADir_OpenW(const AStrW DirName)
{
    return _wopendir(DirName);
}
*/

ADirent //struct dirent*
afunc ADir_Read(ADir Dir)
{
    return readdir(Dir);
}

/*
ADirentW
afunc ADir_ReadW(ADirW Dir)
{
    return _wreaddir(Dir);
}
*/

AError //void
afunc ADir_Rewind(ADir Dir)
{
    rewinddir(Dir);
    return 0;
}

/*
AError
func ADir_RewindW(ADirW Dir)
{
    _wrewinddir(Dir);
    return 0;
}
*/

AError //void
afunc ADir_Seek(ADir Dir, AInt Pos)
{
    seekdir(Dir, Pos);
    return 0;
}


/*
AError
ADir_SeekW(ADirW Dir, AInt Pos)
{
    _wseekdir(Dir, Pos);
    return 0;
}
*/

AInt //long
afunc ADir_Tell(ADir Dir)
{
    return telldir(Dir);
}

/*
AInt //long
afunc ADir_TellW(ADirW Dir)
{
    return _wtelldir(Dir);
}
*/

#endif
