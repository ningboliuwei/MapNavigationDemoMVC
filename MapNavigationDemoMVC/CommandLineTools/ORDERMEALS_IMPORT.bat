@echo off
setlocal enabledelayedexpansion
set /a count=0

for /f "delims=" %%i in ('dir /b /on /a-d ordermeals_backup_*.txt') do (
    set /a count=!count!+1
    echo !count!  %%i
)

set /p choice=��ѡ�����ݿⱸ���ļ���
set /a count=0
set chosen_file=''

for /f "delims=" %%i in ('dir /b /on /a-d ordermeals_backup_*.txt') do (
    set /a count=!count!+1
    if !count! == %choice%  set chosen_file=%%i
)

REM ��һ�йر��ӳٱ��������������е� ! ����Ϊ������ű������ˣ�
setlocal disabledelayedexpansion
echo ���ڵ�������...
C:\xampp\mysql\bin\mysql -u root -p --host localhost --port 3306 --database ordermeals_pro < %chosen_file%
echo -----------------
echo ���ݵ������
echo -----------------
pause