@echo off
setlocal enabledelayedexpansion
set /a count=0

for /f "delims=" %%i in ('dir /b /on /a-d ordermeals_backup_*.txt') do (
    set /a count=!count!+1
    echo !count!  %%i
)

set /p choice=请选择数据库备份文件：
set /a count=0
set chosen_file=''

for /f "delims=" %%i in ('dir /b /on /a-d ordermeals_backup_*.txt') do (
    set /a count=!count!+1
    if !count! == %choice%  set chosen_file=%%i
)

REM 下一行关闭延迟变量（否则密码中的 ! 就作为特殊符号被屏蔽了）
setlocal disabledelayedexpansion
echo 正在导入数据...
C:\xampp\mysql\bin\mysql -u root -p --host localhost --port 3306 --database ordermeals_pro < %chosen_file%
echo -----------------
echo 数据导入完成
echo -----------------
pause