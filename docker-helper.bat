@echo off
REM Docker Helper Script for DSA Visualizer (Windows)

setlocal enabledelayedexpansion

REM Colors for output (using default colors)
set "INFO=[INFO]"
set "SUCCESS=[SUCCESS]"
set "WARNING=[WARNING]"
set "ERROR=[ERROR]"

REM Function to show help
if "%1"=="" goto show_help
if "%1"=="help" goto show_help
if "%1"=="-h" goto show_help
if "%1"=="--help" goto show_help

if "%1"=="dev" goto start_dev
if "%1"=="prod" goto start_prod
if "%1"=="build" goto build
if "%1"=="up" goto start_all
if "%1"=="down" goto stop_all
if "%1"=="logs" goto view_logs
if "%1"=="logs-dev" goto logs_dev
if "%1"=="logs-prod" goto logs_prod
if "%1"=="shell-dev" goto shell_dev
if "%1"=="shell-prod" goto shell_prod
if "%1"=="clean" goto clean
if "%1"=="restart" goto restart
if "%1"=="status" goto status

echo %ERROR% Unknown command: %1
goto show_help

:start_dev
echo %INFO% Starting development server...
docker-compose up dev
goto end

:start_prod
echo %INFO% Starting production server...
docker-compose up prod
goto end

:build
echo %INFO% Building Docker images...
docker-compose build
echo %SUCCESS% Build complete
goto end

:start_all
echo %INFO% Starting all services...
docker-compose up -d
echo %SUCCESS% Services started
echo %INFO% Dev: http://localhost:5173
echo %INFO% Prod: http://localhost:3000
goto end

:stop_all
echo %INFO% Stopping all services...
docker-compose down
echo %SUCCESS% Services stopped
goto end

:view_logs
echo %INFO% Viewing logs...
docker-compose logs -f
goto end

:logs_dev
echo %INFO% Viewing dev logs...
docker-compose logs -f dev
goto end

:logs_prod
echo %INFO% Viewing prod logs...
docker-compose logs -f prod
goto end

:shell_dev
echo %INFO% Accessing dev container shell...
docker-compose exec dev sh
goto end

:shell_prod
echo %INFO% Accessing prod container shell...
docker-compose exec prod sh
goto end

:clean
echo %WARNING% This will remove all containers and volumes
set /p confirm="Continue? (y/n): "
if /i "%confirm%"=="y" (
    echo %INFO% Cleaning up...
    docker-compose down -v
    echo %SUCCESS% Cleanup complete
) else (
    echo %INFO% Cleanup cancelled
)
goto end

:restart
echo %INFO% Restarting all services...
docker-compose restart
echo %SUCCESS% Services restarted
goto end

:status
echo %INFO% Container status:
docker-compose ps
goto end

:show_help
echo DSA Visualizer - Docker Helper
echo.
echo Usage: docker-helper.bat [COMMAND]
echo.
echo Commands:
echo   dev             Start development server (http://localhost:5173)
echo   prod            Start production server (http://localhost:3000)
echo   build           Build all Docker images
echo   up              Start all services
echo   down            Stop all services
echo   logs            View logs from all services
echo   logs-dev        View logs from dev service
echo   logs-prod       View logs from prod service
echo   shell-dev       Access dev container shell
echo   shell-prod      Access prod container shell
echo   clean           Remove all containers and volumes
echo   restart         Restart all services
echo   status          Show status of all services
echo   help            Show this help message
echo.
goto end

:end
endlocal
