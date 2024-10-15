@echo off
REM Устанавливаем кодировку UTF-8
chcp 65001 >nul

REM URL для скачивания архива
set "url=https://github.com/qw1zz1/minecraft-mods/raw/8014b0ddeb4093f98406102030eb8e612bbb9254/mods.zip"  REM Убедитесь, что это прямая ссылка

REM Путь к папке .minecraft
set "destination=%APPDATA%\.minecraft"

REM Временная папка для загрузки архива
set "temp_folder=%USERPROFILE%\Downloads\download"

REM Создаем временную папку
mkdir "%temp_folder%"

REM Скачиваем архив с модами
curl -L "%url%" -o "%temp_folder%\mods.zip"

REM Проверяем, успешно ли скачался архив
if %errorlevel%==0 (
    echo Архив скачан успешно!
    
    REM Удаляем старую папку с модами, если она существует
    if exist "%destination%\mods" (
        rd /s /q "%destination%\mods"
        echo Старая папка с модами удалена.
    )

    REM Распаковываем архив с помощью WinRAR
    "C:\Program Files\WinRAR\WinRAR.exe" x -ibck "%temp_folder%\mods.zip" "%destination%"

    REM Проверка успешности распаковки
    if %errorlevel%==0 (
        echo Моды успешно заменены в папке "%destination%\mods"!
    ) else (
        echo Произошла ошибка при распаковке архива.
    )
) else (
    echo Ошибка при скачивании архива.
)

REM Удаляем временную папку
rd /s /q "%temp_folder%"

REM Задержка, чтобы консоль не закрывалась сразу
pause
