@echo off
title Fishing Clicker Game
color 0A

:: Initialize variables
set fish=0
set boots=0
set cans=0
set money=0
set fish_price=10
set rarity_modifier=0
set price_multiplier=1

:: Check for saved game
if exist savegame.txt (
    echo Save file found! Do you want to load it? (Y/N)
    set /p load_choice=
    if /i "%load_choice%"=="Y" call :load_game
)

:main_menu
cls
echo ======================================
echo         Welcome to Fish Clicker!
echo ======================================
echo.
echo You have:
echo    Fish: %fish%
echo    Old Boots: %boots%
echo    Tuna Cans: %cans%
echo    Money: $%money%
echo.
echo Current fish selling price: $%fish_price%
echo.
echo Press F to Fish
echo Press S to Sell Fish
echo Press B to Buy Upgrades
echo Type SAVE to Save Game
echo Type LOAD to Load Game
echo Press Q to Quit
echo.
set /p choice=Choose an action (F/S/B/SAVE/LOAD/Q): 
set choice=%choice:~0,5%
if /i "%choice%"=="F" goto fish
if /i "%choice%"=="S" goto sell
if /i "%choice%"=="B" goto shop
if /i "%choice%"=="SAVE" goto save_game
if /i "%choice%"=="LOAD" goto load_game
if /i "%choice%"=="Q" goto exit_game
goto main_menu

:fish
cls
echo Fishing...
set /a rand=%random% %% 100 + 1
set /a chance_fish=60+%rarity_modifier%
if %rand% LEQ %chance_fish% (
    set /a fish+=1
    echo You caught a fish!
) else if %rand% LEQ %chance_fish%+30 (
    set /a boots+=1
    echo You caught an old boot...
) else (
    set /a cans+=1
    echo You caught a tuna can.
)
timeout /t 2 >nul
goto main_menu

:sell
cls
if %fish% LEQ 0 (
    echo You have no fish to sell!
) else (
    set /a earnings=%fish%*%fish_price%*%price_multiplier%
    set /a money+=%earnings%
    echo You sold %fish% fish for $%earnings%!
    set fish=0
)
timeout /t 2 >nul
goto main_menu

:shop
cls
echo ======================================
echo                Shop
echo ======================================
echo.
echo Your Money: $%money%
echo.
echo 1. Price Increase (Doubles selling price) - $100
echo 2. Rarity Increase (Increases fish catch rate by 10%) - $150
echo 3. Inflation (Triples selling price) - $300
echo 4. Back to Main Menu
echo.
set /p shop_choice=Choose an item to buy (1/2/3/4): 
set shop_choice=%shop_choice:~0,1%
if "%shop_choice%"=="1" (
    if %money% GEQ 100 (
        set /a money-=100
        set /a price_multiplier*=2
        echo Purchased Price Increase!
    ) else (
        echo Not enough money!
    )
) else if "%shop_choice%"=="2" (
    if %money% GEQ 150 (
        set /a money-=150
        set /a rarity_modifier+=10
        echo Purchased Rarity Increase!
    ) else (
        echo Not enough money!
    )
) else if "%shop_choice%"=="3" (
    if %money% GEQ 300 (
        set /a money-=300
        set /a price_multiplier*=3
        echo Purchased Inflation!
    ) else (
        echo Not enough money!
    )
) else if "%shop_choice%"=="4" (
    goto main_menu
) else (
    echo Invalid choice!
)
timeout /t 2 >nul
goto shop

:save_game
cls
echo Saving game...
(
    echo fish=%fish%
    echo boots=%boots%
    echo cans=%cans%
    echo money=%money%
    echo fish_price=%fish_price%
    echo rarity_modifier=%rarity_modifier%
    echo price_multiplier=%price_multiplier%
) > savegame.txt
echo Game saved successfully!
timeout /t 2 >nul
goto main_menu

:load_game
cls
echo Loading game...
for /f "tokens=1,2 delims==" %%a in (savegame.txt) do set %%a=%%b
echo Game loaded successfully!
timeout /t 2 >nul
goto main_menu

:exit_game
cls
echo Thank you for playing Fish Clicker!
echo.
pause
exit
