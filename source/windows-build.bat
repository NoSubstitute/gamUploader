set GAMPLATFORM=gamUploader

rmdir /q /s build
rmdir /q /s dist
rmdir /q /s %GAMPLATFORM%
pyinstaller --clean --noupx -F --distpath=%GAMPLATFORM% windows-gam.spec