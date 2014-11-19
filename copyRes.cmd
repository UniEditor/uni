xcopy res bin\windows\cpp\bin\res\ /E /Q /Y
pause

:c:\windows\system32\cmd.exe xcopy $(ProjectDir)\res $(ProjectDir)\bin\windows\cpp\bin\res\ /E /Q /Y