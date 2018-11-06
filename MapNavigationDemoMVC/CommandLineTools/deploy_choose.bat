echo off
setlocal enabledelayedexpansion
set /a count=0
set projfile=''

for /f "delims=" %%i in ('dir /b /on /a-d ..\*.csproj') do (
    set projfile=%%i
)

for /f "delims=" %%i in ('dir /b /on /a-d ..\Properties\PublishProfiles\*.pubxml') do (
    set /a count=!count!+1
    echo !count!  %%~ni
)

set /p profile_choice=��ѡ�������ļ���
set /a count=0
set chosen_file=''

for /f "delims=" %%i in ('dir /b /on /a-d ..\Properties\PublishProfiles\*.pubxml') do (
    set /a count=!count!+1
    if !count! == %profile_choice%  set chosen_file=%%~ni
)

set hostname=''
set username=''
set password=''
set /a count=0

for /f "tokens=1-3 delims=," %%i in (account.txt) do (
    set /a count=!count!+1
    set  hostname=%%i
    echo !count! !hostname!
)
set /p host_choice=��ѡ��������
set /a count=0
set chosen_username=''
set chosen_password=''

for /f "tokens=1-3 delims=," %%i in (account.txt) do (
    set /a count=!count!+1
   
    if !count! == %host_choice%  (
        setlocal disabledelayedexpansion  
        set chosen_username=%%j
        set chosen_password=%%k
        setlocal enabledelayedexpansion
    )
)
setlocal disabledelayedexpansion  
REM ��һ�йر��ӳٱ��������������е� ! ����Ϊ������ű������ˣ�
"C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\MSBuild.exe" ..\%projfile%  /p:DeployOnBuild=true /p:Configuration=Release /p:PublishProfile=%chosen_file% /p:username=%chosen_username% /p:password=%chosen_password%
