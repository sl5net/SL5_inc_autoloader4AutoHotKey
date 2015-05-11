;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; warning: this is a copy only! never edit in this file! thanks :-)
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; subroutinen m�ssen ans ende sonst blocken die
; #Include functions_global_dateiende.inc.ahk
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<



;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
ModiTime_functions_global_OLD:=0
UPDATEDSCRIPTfunctions_global:
  ScriptName :="functions_global.inc.ahk" 
  ScriptFullPath:= A_ScriptDir . "/" . ScriptName
  FileGetAttrib,attribs,%ScriptFullPath%
  FileGetTime, ModiTime_functions_global, %ScriptFullPath%, M
  if(ModiTime_functions_global_OLD > 0 AND ModiTime_functions_global > ModiTime_functions_global_OLD)
  {    
    preParser(A_ScriptDir, ScriptName, ScriptFullPath)
    Sleep,500           
    FileSetAttrib,-A,%ScriptFullPath%
    SplashTextOn,,,Updated functions_global,
    Sleep,500
    Reload      ; Script wird neu geladen,neu ausgef�hrt
  }
  ModiTime_functions_global_OLD := ModiTime_functions_global
  SplashTextOff
Return
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


RemoveToolTip:
	tooltip,
return

