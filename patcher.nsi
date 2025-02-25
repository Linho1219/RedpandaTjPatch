; 本文件使用 GBK 编码。如果你看到乱码，请检查文本编辑器的编码设置。
; This script is encoded in GBK. If you see garbled text, check your text editor's settings.

!include "StrFunc.nsh"
${StrRep}

!define ERRORINFO "文件操作失败！请确认配置文件是否缺失或被占用。"

Name "RedPanda Modifier"
OutFile "RedPandaTJPatch.exe"

; when debugging, comment out the following line to avoid compression
SetCompressor /SOLID lzma

Section "Add Compiler"
    CreateDirectory "C:\Program Files\RedPanda-Cpp\MinGW64-TDM"
    SetOutPath "C:\Program Files\RedPanda-Cpp\MinGW64-TDM"
    File /r ".\MinGW64-TDM\*.*"
SectionEnd

Section "Modify Configuration"
    ReadINIStr $0 "$APPDATA\RedPandaIDE\redpandacpp.ini" "CompilerSets" "count"
    IntOp $1 $0 + 0  ; str to int

    IntOp $2 $1 + 4 ; compiler count+=4
    WriteINIStr "$APPDATA\RedPandaIDE\redpandacpp.ini" "CompilerSets" "count" $2

    StrCpy $R4 $1    ; $R4=count
    IntOp $R5 $1 + 1 ; $R5=count+1
    IntOp $R6 $1 + 2 ; $R6=count+2
    IntOp $R7 $1 + 3 ; $R7=count+3

    SetOutPath "$PLUGINSDIR"
    File "template.ini"  ; put template.ini to temp dir

    FileOpen $0 "$PLUGINSDIR\template.ini" r
    FileOpen $1 "$APPDATA\RedPandaIDE\redpandacpp.ini" a ; append mode
    FileSeek $1 0 END
    FileWrite $1 "$\r$\n"

    ${If} $0 <> 0
    ${AndIf} $1 <> 0
        loop:
            ClearErrors
            FileRead $0 $9  ; read one line at a time
            IfErrors done
            ${StrRep} $9 $9 "{{INDEX0}}" $R4
            ${StrRep} $9 $9 "{{INDEX1}}" $R5
            ${StrRep} $9 $9 "{{INDEX2}}" $R6
            ${StrRep} $9 $9 "{{INDEX3}}" $R7
            FileWrite $1 $9
            Goto loop
        done:
            FileClose $0
            FileClose $1
    ${Else}
        MessageBox MB_ICONSTOP "${ERRORINFO}"
        Abort
    ${EndIf}
SectionEnd