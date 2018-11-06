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

set /p profile_choice=请选择配置文件：
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
set /p host_choice=请选择主机：
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
REM 下一行关闭延迟变量（否则密码中的 ! 就作为特殊符号被屏蔽了）
"C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\MSBuild.exe" ..\%projfile%  /p:DeployOnBuild=true /p:Configuration=Release /p:PublishProfile=%chosen_file% /p:username=%chosen_username% /p:password=%chosen_password%
