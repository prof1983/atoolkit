/* Stat functions
 * Author Prof1983 <prof1983@ya.ru>
 * Created 17.07.2012
 * LastMod 17.07.2012
 * Version 0.5
 */

#include "AIoStat"

AInt
AIo_GetStat(const AStr FileName, AStat Buf)
{
	return stat(FileName, Buf);
}

AInt
AIo_GetStatF(AInt FileDes, AStat Buf)
{
	return fstat(FileDes, Buf);
}
