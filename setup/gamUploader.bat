@ECHO OFF
REM Replace your email address on the line below.
SET USERADDRESS=ReplacewithYour@EmailAddress
REM
REM This folder and all its files need to be in C:\gamUploader and can't be moved or deleted.
REM This file, gamUploader.bat, is to be set as the default app for all files that are to
REM be uploaded, and edited in Drive, by autoloading the first Chrome Profile (Default), which
REM *should* be your work account.
REM
REM If your work/school profile isn't the first Chrome profile, you must edit and set the correct profile here.
SET PROFILE=Default
REM If you have added your work/school account after some other account,
REM then the word "Default" must be replaced with "Profile X" with the correct number.
REM There is no way for me to know which number is correct for you.
REM 
REM Now, close and save this file.
REM
REM Here be dragons... Don't change anything below, but do read on, if you want!
REM
REM
REM
SET GAMCFGDIR=C:\gamUploader
REM
REM Depending on which file type is double clicked, the URL returned will be different.
REM Word documents, ending with docx or doc will open with:
REM https://docs.google.com/document/d/%%i/edit
REM
REM Excel files, ending with xlsx or xls will open with:
REM https://docs.google.com/spreadsheets/d/%%i/edit
REM
REM PowerPoint files, ending with pptx or ppt will open with:
REM https://docs.google.com/presentation/d/%%i/edit
REM
REM Unknown/Unmapped filetypes that are associated with or dropped on this bat file
REM will instead load this URL:
REM https://drive.google.com/file/d/%%i/edit
REM That will show the content in a preview mode, if Drive is able to.
REM If not, it'll just say the file is incompatible with Drive, and must be downloaded to view or edit.
REM
ECHO Your file is now being uploaded to Drive.
ECHO It will take a few seconds. Then the file will open in your Chrome browser.
ECHO The file will open in view or edit mode depending on the file type.
REM
REM This command is only compatible with Windows.
REM For other OSs it needs to be replaced with something that can grab the response by the gamUploader binary
REM and push it to the local Chrome installation.
for /f "tokens=1" %%i in ('%GAMCFGDIR%\gamUploader.exe %USERADDRESS% %1') do "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --profile-directory="%PROFILE%" %%i
REM End of code.
REM
REM This idea was created by me (Kim Nilsson) in collaboration with GAMADV-XTD3 developer Ross Scroggs.
REM Kim Nilsson
REM No Substitute
REM https://wheretofind.me/@NoSubstitute
REM 
REM PRIVACY POLICY
REM No data is sent anywhere, except between you and Google.
REM No matter if you use this or create a copy of my scripts, I will never gain access to any of your data.
REM
REM If you want you can https://www.paypal.me/NoSubstitute
REM
REM gamUploader.exe included with this package is based on GAMLite, a special version of GAMADV-XTD3,
REM which only contains the code to perform the actions described above.
REM GAMADV-XTD3 is a free, open source command line tool for Google Workspace
REM (formerly G Suite) Administrators to manage domain and user objects quickly and easily.
REM GAMADV-XTD3 can be found here, https://github.com/taers232c/GAMADV-XTD3
REM GAMLite base package can be found here, https://github.com/taers232c/GAMLite