@echo off
REM Устанавливаем кодировку UTF-8
chcp 65001 >nul

REM URL для скачивания архивов
set "url1=https://github.com/qw1zz1/minecraft-mods/raw/8da16ca674fe5f2af378fc0a187eb9d1b7bed656/mods.zip"  REM Убедитесь, что это прямая ссылка
set "url2=https://github.com/qw1zz1/minecraft-mods/raw/8da16ca674fe5f2af378fc0a187eb9d1b7bed656/mods1.zip"  REM Вторая ссылка

REM Путь к папке .minecraft
set "destination=%APPDATA%\.minecraft"

REM Временные папки для загрузки архивов
set "temp_folder1=%USERPROFILE%\Downloads\download1"
set "temp_folder2=%USERPROFILE%\Downloads\download2"

REM Создаем временные папки
mkdir "%temp_folder1%"
mkdir "%temp_folder2%"

REM Проверка, не используется ли папка mods
echo Проверка, используется ли папка mods...
tasklist /FI "IMAGENAME eq javaw.exe" 2>NUL | find /I "javaw.exe" >NUL
if %errorlevel%==0 (
    echo Minecraft или другой процесс использует mods. Пожалуйста, закройте все связанные программы.
    pause
    exit /b
)

REM Скачиваем первый архив с модами
curl -L "%url1%" -o "%temp_folder1%\mods.zip"

REM Проверяем, успешно ли скачался первый архив
if %errorlevel%==0 (
    echo Первый архив скачан успешно!
    
    REM Удаляем старую папку с модами, если она существует
    if exist "%destination%\mods" (
        rd /s /q "%destination%\mods"
        echo Старая папка с модами удалена.
    )

    REM Распаковываем первый архив с помощью WinRAR
    "C:\Program Files\WinRAR\WinRAR.exe" x -ibck "%temp_folder1%\mods.zip" "%destination%"

    REM Проверка успешности распаковки первого архива
    if %errorlevel%==0 (
        echo Моды из первого архива успешно заменены в папке "%destination%\mods"!
    ) else (
        echo Произошла ошибка при распаковке первого архива.
    )
) else (
    echo Ошибка при скачивании первого архива.
)

REM Скачиваем второй архив с модами
curl -L "%url2%" -o "%temp_folder2%\mods.zip"

REM Проверяем, успешно ли скачался второй архив
if %errorlevel%==0 (
    echo Второй архив скачан успешно!

    REM Распаковываем второй архив с помощью WinRAR
    "C:\Program Files\WinRAR\WinRAR.exe" x -ibck "%temp_folder2%\mods.zip" "%destination%"

    REM Проверка успешности распаковки второго архива
    if %errorlevel%==0 (
        echo Моды из второго архива успешно добавлены в папку "%destination%\mods"!
    ) else (
        echo Произошла ошибка при распаковке второго архива.
    )
) else (
    echo Ошибка при скачивании второго архива.
)

REM Удаляем временные папки
rd /s /q "%temp_folder1%"
rd /s /q "%temp_folder2%"

REM Задержка, чтобы консоль не закрывалась сразу
pause