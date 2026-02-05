@echo off
chcp 65001 >nul
title Hotel Booking App - Flutter Frontend
color 0B

echo ========================================
echo   Hotel Booking Application
echo   Flutter Frontend Startup
echo ========================================
echo.

echo [1/3] Checking Flutter Installation...
flutter --version >nul 2>&1
if %errorlevel% equ 0 (
    echo    ✓ Flutter is installed
) else (
    echo    ✗ Flutter not found
    echo    Please install Flutter: https://flutter.dev/docs/get-started/install
    pause
    exit /b 1
)

echo.
echo [2/3] Cleaning Previous Builds...
flutter clean
if %errorlevel% equ 0 (
    echo    ✓ Clean completed
) else (
    echo    ⚠ Clean had warnings (continuing...)
)

echo.
echo [3/3] Getting Dependencies...
flutter pub get
if %errorlevel% equ 0 (
    echo    ✓ Dependencies installed
) else (
    echo    ✗ Failed to get dependencies
    pause
    exit /b 1
)

echo.
echo ════════════════════════════════════════
echo   Starting Flutter Application
echo ════════════════════════════════════════
echo.
echo    Backend URL: http://10.0.2.2:8080
echo    (Make sure backend is running!)
echo.
echo    Press 'q' to quit
echo.

flutter run

pause

