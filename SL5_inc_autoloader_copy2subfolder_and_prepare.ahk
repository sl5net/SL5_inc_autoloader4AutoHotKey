isDevellopperMode=true
#Include functions_global.inc.ahk ; SL5_inc_autoloader_copy2subfolder_and_prepare.ahk


;~ MsgBox,A_ScriptFullPath=%A_ScriptFullPath% takes time! runs about 30 seconds or so :) enjoy
;~ ExitApp 

; it loop throw alls ahk files not contains ".inc.ahk" in file name.
; copies all needest files out of the root path inside each project path.
; rewrites the include statements during copy that you could be sure the copied files do run

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
doChangeSourceFile:=false
doCopyFilesInSourceFolder:=true
if(doChangeSourceFile)
{
   MsgBox,doChangeSourceFile is not recomandet and not completly implemented jet. ExitApp
   ExitApp
}

Loop, %A_ScriptDir%\*.*,2,1
{
  SubFolders := False, fPath := A_LoopFileLongPath
  Loop, %fPath%\*.*,2,0
   {
     SubFolders := True
     Break
   }
  If ! SubFolders
       FolderList .= fPath ","
}
m=
Loop, Parse, FolderList, `,|;
{
   dNow:=A_LoopField
   if(InStr(dNow,"\."))
      continue
      
   if(InStr(dNow,"\sync-conflict"))
   {
      ;~ MsgBox,dNow=%dNow% `n 
      continue
   }
      

Loop, %dNow%\*.ahk, 1,0
   {
      if(InStr(A_LoopFileName , ".inc.ahk" ))
         continue




      fNow := dNow . "\" . A_LoopFileName 
      source_new:=""
      Loop
      {
         lineNumber:=A_Index
         FileReadLine, line, %fNow%, %lineNumber%
         if ErrorLevel
            break 
         
         
         used_ahk := ""
         used_ahk := RegExReplace(line, "i)(^#include)(\s+)([^;]+).*", "$3") ; case insesitive 


         if(fNow_old = fNow && used_ahk_old = used_ahk)
            continue
         
         copyCodeRememberString := fNow . "#" .  used_ahk
         isAlreadyAddet := InStr(copyCodeRememberStringList , copyCodeRememberString) 
         ;~ MsgBox,isAlreadyAddet=%isAlreadyAddet%
         
            ;~ if(InStr(dNow,"test_area"))
            ;~ MsgBox,%A_LineNumber%: fNow=%fNow% `n 

         
         if( isAlreadyAddet ) 
            continue

            ;~ if(InStr(dNow,"test_area"))
               ;~ MsgBox,%A_LineNumber%: fNow=%fNow% `n 

         if(used_ahk = line)
         {
            if(doChangeSourceFile)
               line_new:=line
         }
         else
         {
            ;~ if(InStr(dNow,"test_area"))
               ;~ MsgBox,%A_LineNumber%: fNow=%fNow% `n 
            
            fNow_old := fNow
            used_ahk_old := used_ahk
            copyCodeRememberStringList .= copyCodeRememberString . ",`n"
            copyCodeRememberString_old := copyCodeRememberString
                  
            if(!InStr(used_ahk,"%")) ; only use simple includes jet
            {
            ;~ if(InStr(dNow,"test_area"))
               ;~ MsgBox,%A_LineNumber%: fNow=%fNow% `n 

               StringReplace,dfiff,dNow,%A_ScriptDir%
                  StringSplit, pathAr, dfiff, \
               if((pathAr0 - 1) > 0 )
               {

                  dirGoUpRelativ := RegExReplace(dfiff, "i)\\[^\\]+", "..\") ; case insesitive 
                  if(doChangeSourceFile)
                  {
                     used_ahk_new := dirGoUpRelativ . used_ahk 
                     StringReplace, line_new, line, %used_ahk%, %used_ahk_new%
                  }
                  if(doCopyFilesInSourceFolder = true)
                  {
                     ;~ used_ahk := A_ScriptDir . "\" . used_ahk
                     exist_used_ahk := FileExist(A_ScriptDir . "\" . used_ahk)
                     exist_dNow := FileExist(dNow)
                     
                     	if(!exist_used_ahk || !exist_dNow  )
                        {
		;~ MsgBox,A_LineNumber=%A_LineNumber% `n exist_used_ahk=%exist_used_ahk% `n exist_dNow = %exist_dNow% `n used_ahk=%used_ahk% `n dirGoUpRelativ=%dirGoUpRelativ% `n dNow=%dNow% 
        
}
else
                     changeAllIncludeDir_and_copy2dir( used_ahk , dirGoUpRelativ, dNow)
                     ;~ MsgBox,used_ahk=%used_ahk% `n
                  m .=  "`n`nchangeAllIncludeDir_and_copy2dir(inc = " . used_ahk . " , copy2dir=" . dirGoUpRelativ . " , dNow = " . dNow . " )"
                  ;~ MsgBox,%A_LineNumber% m=%m%
                  }


                  ;~ msgbox, % (pathAr0 - 1) . " SubFolder Deepth of " . dfiff . " " . dirGoUpRelativ
            ;~ MsgBox,%fNow% `n %lineNumber%: %used_ahk%  `n line=%line% `n dfiff=%dfiff% `n dirGoUpRelativ=%dirGoUpRelativ%
               }
            }
         }
         if(doChangeSourceFile)
            source_new .= line_new . "`n"
      }
      ;~ MsgBox,source_new=%source_new%
      ;~ MsgBox, fNow=%fNow%
   }
}
;~ MsgBox,%A_LineNumber%: m=%m%
MsgBox,%A_LineNumber%: found the following includes. may some of them copied from root to subfolder. `n%copyCodeRememberStringList% `n 
;>>>>>>>>>>>>>>>>>>>>>>>>><>>>>>>>>>>>>>>>>>>>>

MsgBox,End or script Reload
sec:=1000
min:=60*sec
hour:=60*min
Sleep,%hour%
ExitApp
Reload
return



;~ FIX_includes_of_each_subDir()
SetTimer,RemoveTooltip,off
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ FIX_includes_of_each_subDir(){

;~ SL5_inc_autoloader_copy2subfolder_and_prepare.ahk



return

WM_COMMAND = 0x111
ID_FILE_EXIT = 65405      ; (65404 to suspend, 65403 to pause)
DetectHiddenWindows, On

;~ SetTimer, myLabel, 500   ; check every half sec
Return

myLabel:
WinGet, AList, List, ahk_class SunAwtFrame  ; Make a list of all running AutoHotkey scripts
Loop %AList%                  ; Loop through the list
{
   ID := AList%A_Index%
   WinGetTitle, ATitle, ahk_id %ID%
   
   ; check for U#######.ahk where U is an uppercase char and # is a number
   foundPos := RegExMatch(ATitle, "[A-Z]\d{7}\.ahk")      ; check for "to be terminated" script
   If (foundPos)   ; if foundPos != 0
   {
      MsgBox, 3,, %ATitle%`n `n send ?
      IfMsgBox Cancel
         Break
      IfMsgBox Yes
          PostMessage, 0x55, ,, % "ahk_id" AList%A_Index% 
          ;, ahk_ID %Var_WinTitle% ; 0X102 = WM_CHAR ; 0x52 = U

         PostMessage,WM_CHAR,0x52,0,,% "ahk_id" AList%A_Index%  
         ; http://stackoverflow.com/questions/15853732/sending-keystroke-to-another-application-using-winapi
         ;~ PostMessage,WM_COMMAND,ID_FILE_EXIT,0,,% "ahk_id" AList%A_Index%   ; End the process
   }
}
Return


#Include functions_global_dateiende.inc.ahk
;