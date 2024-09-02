@echo off
title Guess the Number Game
color 0a

setlocal EnableDelayedExpansion

:: Generate a random number between 1 and 100
set /a target=%random% %% 100 + 1
set attempts=0

cls
echo Welcome to the Guess the Number Game!
echo.
echo I have selected a number between 1 and 100.
echo Try to guess it!

:guess
set /p "input=Enter your guess: "
set /a attempts+=1

if !input!==!target! (
    echo Congratulations! You guessed the number in %attempts% attempts.
    pause
    exit
)

if !input! lss !target! (
    echo Higher...
) else (
    echo Lower...
)

goto guess
