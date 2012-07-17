/* Dirent functions
 * Author Prof1983 <prof1983@ya.ru>
 * Created 17.07.2012
 * LastMod 17.07.2012
 * Version 0.5
 */

#include "AIoDir"

AInt
func ADir_Close(ADir Dir)
{
	return closedir(Dir);
}

AInt
func ADir_CloseW(ADirW Dir)
{
	return _wclosedir(Dir);
}

AError
func ADir_GetList(AStr DirName)
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
func ADir_Open(AStr DirName)
{
	return opendir(DirName);
}

ADirW
func ADir_OpenW(const AStrW DirName)
{
	return _wopendir(DirName);
}

ADirent //struct dirent*
func ADir_Read(ADir Dir)
{
	return readdir(Dir);
}

ADirentW
func ADir_ReadW(ADirW Dir)
{
	return _wreaddir(Dir);
}

AError //void
func ADir_Rewind(ADir Dir)
{
	rewinddir(Dir);
	return 0;
}

AError
func ADir_RewindW(ADirW Dir)
{
	_wrewinddir(Dir);
	return 0;
}

AError //void
func ADir_Seek(ADir Dir, AInt/*long*/ Pos)
{
	seekdir(Dir, Pos);
	return 0;
}


AError
ADir_SeekW(ADirW Dir, AInt/*long*/ Pos)
{
	_wseekdir(Dir, Pos);
	return 0;
}

AInt //long
func ADir_Tell(ADir Dir)
{
	return telldir(Dir);
}
AInt //long
func ADir_TellW(ADirW Dir)
{
	return _wtelldir(Dir);
}
