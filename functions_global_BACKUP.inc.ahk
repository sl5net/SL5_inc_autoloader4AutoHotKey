;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; warning: this is a copy only! never edit in this file! thanks :-)
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#SingleInstance force
; n15-05-11_21-41
SetWorkingDir %A_ScriptDir%
;~ EnvSet ZTEMP,%A_ScriptDir%
;~ EnvSet PATH,%path%;%A_ScriptDir%;%A_ScriptDir%\ARCH
;~ RUN ZTW.EXE /Y /ZB /SCO


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
#Include ..\ToolTipSec.inc.ahk  ; automatically replaced by changeAllIncludeDir ; ein kommentar
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


;~ StartLabel:
Last_A_This:=A_ThisFunc . A_ThisLabel
ToolTip1sec(A_LineNumber . " " . A_ScriptName . " " . Last_A_This)
;~ MsgBox,label that is currently executing = %Last_A_This%

SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

HardDriveLetter := SubStr(A_ScriptDir, 1 , 1)


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
changeAllIncludeDir_and_copy2dir(used_ahk,preFix,copy2dir){
	if(!FileExist(copy2dir) )
		MsgBox,copydir=%copydir% preFix=%preFix% copydir=%copydir% 
f:=A_ScriptDir . "\" . used_ahk
source:=""
source:=changeAllIncludeDir(f,preFix)
StrLen_source:=StrLen(source)
if(StrLen_source < 100 )
{
	errormsg=ERROR StrLen(source of %f%) < 100 `n source=%source% `n f=%f% `n
	;~ MsgBox,,,errormsg=%errormsg% `n , 2
	ToolTip,errormsg=%errormsg% `n
	;~ Reload
	return -1
}



 b:=";<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<`n"
 e:=";>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>`n"
 source := b . "; warning: this is a copy only! never edit in this file! thanks :-)`n" . e . source . newLine . "`n"
 ;~ MsgBox, ,,%source%,4
 newFileAdress:= copy2dir . "\" .  used_ahk
 
 FileGetTime, sourceModifiedTime, %f%  ; Retrieves the modification time by default.
exist_newFileAdress:=FileExist(newFileAdress)

if(exist_newFileAdress){
 FileGetTime, targetCreatedTime, %newFileAdress%, C  ; Retrieves the creation time.
 ToolTip,sourceModifiedTime=%sourceModifiedTime%  > %targetCreatedTime% `n
 
 ;~ MsgBox,,,exist_newFileAdress = %exist_newFileAdress% `n`n newFileAdress=%newFileAdress% `nsourceModifiedTime=%sourceModifiedTime% `n targetCreatedTime=%targetCreatedTime% `n,20



sourceNewerDiff := sourceModifiedTime - targetCreatedTime

   if(InStr(f,"test_area"))
   {
      MsgBox,sourceNewerDiff=%sourceNewerDiff% `n  
      ;~ continue
   }


 if(sourceModifiedTime > targetCreatedTime ) 
{
 ;~ MsgBox,sourceModifiedTime=%sourceModifiedTime%  > %targetCreatedTime% `n
	
  FileDelete,%newFileAdress%
	;~ MsgBox,FileDelete %newFileAdress%
}
 else
 {
	; thats ok. if source is older we dont need to copy. it takes time so that the copyied files always little newer.
	; lets do nothing and return -1 means not copied
 ;~ MsgBox,sourceModifiedTime=%sourceModifiedTime%  < %targetCreatedTime% `n newFileAdress=%newFileAdress% `n sourceNewerDiff=%sourceNewerDiff% `n
  if( timeDiff > 9 * 1000 * 1000 ) ; if its much newer we take it back to the root version. all changes overwrite.
   return -1
 }
}

 FileAppend,%source%,%newFileAdress%
exist_newFileAdress:=FileExist(newFileAdress)
if(!exist_newFileAdress)
{
	Clipboard=%newFileAdress%
	MsgBox,%A_LineNumber%: ERROR  (!exist_newFileAdress)  newFileAdress=%newFileAdress% `n copy2dir=%copy2dir% `n f=%f% `n StrLen_source=%StrLen_source% `n
	Reload
}

return 1
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

; whats shift + f5 ?ßß?ß
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
changeAllIncludeDir(f,preFix)
{ 
 source := ""
 Loop
 {
     FileReadLine, line, %f%, %A_Index%
     if ErrorLevel
         break
     newLine := RegExReplace(line, "i)(^#include)(\s+)([^;]+)", "$1$2" . preFix . "\$3 `; automatically replaced by changeAllIncludeDir ") ; case insesitive 
     ;~ newLine := StringReplace(newLine, "\", "\") ; case insesitive 
     StringReplace, newLine, newLine, \, \, All
     
     ;~ source := source . line . "`n"
     source := source . newLine . "`n"
     ;~ if(A_Index > 22)
      ;~ break
     ;~ MsgBox, 4, , Line #%A_Index% is "%line%".  Continue?
     ;~ IfMsgBox, No
         ;~ return
 }
 return source
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


isFile(Path)
{
   Return !InStr(FileExist(Path), "D") 
}

isDir(Path)
{
   Return !!InStr(FileExist(Path), "D") 
}

