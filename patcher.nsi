!include "StrFunc.nsh"
${StrRep}

Name "RedPanda Modifier"
OutFile "RedPandaTJPatch.exe"

SetCompressor /SOLID lzma

Section "Add Compiler"
    CreateDirectory "C:\Program Files\RedPanda-Cpp\MinGW64-TDM"
    SetOutPath "C:\Program Files\RedPanda-Cpp\MinGW64-TDM"
    File /r ".\MinGW64-TDM\*.*"
SectionEnd

Section "Modify Configuration"
    ; ��ȡԭʼ����������
    ReadINIStr $0 "$APPDATA\RedPandaIDE\redpandacpp.ini" "CompilerSets" "count"
    IntOp $1 $0 + 0  ; ת��Ϊ����

    ; ������ֵ������count
    IntOp $2 $1 + 4
    WriteINIStr "$APPDATA\RedPandaIDE\redpandacpp.ini" "CompilerSets" "count" $2

    ; �����ĸ��µ�����ֵ
    StrCpy $R4 $1    ; ԭʼcountֵ��Ϊ��ʼ����
    IntOp $R5 $1 + 1
    IntOp $R6 $1 + 2
    IntOp $R7 $1 + 3

    ; ����ģ���ļ�
    SetOutPath "$PLUGINSDIR"
    File "template.ini"  ; ��ģ���ļ����Ƶ���ʱĿ¼

    FileOpen $0 "$PLUGINSDIR\template.ini" r
    FileOpen $1 "$APPDATA\RedPandaIDE\redpandacpp.ini" a
    FileSeek $1 0 END
    FileWrite $1 "$\r$\n"

    ${If} $0 <> 0
    ${AndIf} $1 <> 0
        loop:
            ClearErrors
            FileRead $0 $9  ; ��ȡģ����
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
        MessageBox MB_ICONSTOP "�ļ�����ʧ��!"
        Abort
    ${EndIf}
SectionEnd