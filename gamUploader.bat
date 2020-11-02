@ECHO OFF
REM Replace your email address on the line below. Then close and save the file.
SET USERADDRESS=ReplacewithYourEmailAddress
REM
REM Here be dragons... Don't change anything below, but do read on, if you want!
REM
REM This folder and all its files need to be in C:\gamUploader and can't be moved or deleted.
REM This file gamUploader.bat is to be set as the default app for all files that are to
REM be uploaded, and edited in Drive, by autoloading the first Chrome Profile (1), which
REM should be your work account.
REM Else the --profile-directory variable down below needs to be edited.
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
SET GAMCFGDIR=C:\gamUploader
for /f "tokens=1" %%i in ('C:\gamUploader\gam.exe user %USERADDRESS% add drivefile localfile %1 returneditlinkonly') do "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --profile-directory="Profile 1" %%i
REM End of code.
REM
REM This idea was created by me (Kim Nilsson) in collaboration with GAMADV-XTD3 developer Ross Scroggs.
REM Kim Nilsson
REM No Substitute
REM https://wheretofind.me/@NoSubstitute
REM 
REM PRIVACY POLICY
REM You are in full control of all the data. The script is only accessing data you
REM yourself have access to. No data is sent anywhere, except between you and Google.
REM No matter if you create a copy of my scripts, I will never gain access to any of your data.
REM All data reading and writing is done by you on your own account.
REM
REM If you want you can https://www.paypal.me/NoSubstitute
REM
REM gam.exe that is and needs to be included with this package is from GAMADV-XTD3, and requires v5.23.06 or higher.
REM GAMADV-XTD3 is a free, open source command line tool for Google Workspace
REM (formerly G Suite) Administrators to manage domain and user settings quickly and easily.
REM GAMADV-XTD3 can be found here, https://github.com/taers232c/GAMADV-XTD3
