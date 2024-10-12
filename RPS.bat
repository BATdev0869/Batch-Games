@echo off
:menu
cls
echo Rock, Paper, Scissors Game
echo.
echo Choose:
echo 1. Rock
echo 2. Paper
echo 3. Scissors
set /p choice=Enter your choice (1-3): 

set /a comp=%random% %% 3 + 1

if %choice%==1 set player=Rock
if %choice%==2 set player=Paper
if %choice%==3 set player=Scissors

if %comp%==1 set computer=Rock
if %comp%==2 set computer=Paper
if %comp%==3 set computer=Scissors

echo.
echo You chose: %player%
echo Computer chose: %computer%
echo.

if %choice%==%comp% (
    echo It's a tie!
) else if %choice%==1 if %comp%==3 (
    echo You win!
) else if %choice%==2 if %comp%==1 (
    echo You win!
) else if %choice%==3 if %comp%==2 (
    echo You win!
) else (
    echo You lose!
)

echo.
pause
goto menu
