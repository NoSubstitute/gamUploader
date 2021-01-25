#!/usr/bin/env python
"""Upload Microsoft format file
"""

import mimetypes
import os
import sys

import googleapiclient.http

from gam import gam
from gamlib import glapi as API

# Set the following values as appropriate for your domain
GAMCFG = os.path.join(os.environ.get("GAMCFGDIR", "C:\\gamUploader"), "gam.cfg")

MICROSOFT_FORMATS_LIST = [{'mime': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'ext': '.docx'},
                          {'mime': 'application/vnd.openxmlformats-officedocument.wordprocessingml.template', 'ext': '.dotx'},
                          {'mime': 'application/vnd.openxmlformats-officedocument.presentationml.presentation', 'ext': '.pptx'},
                          {'mime': 'application/vnd.openxmlformats-officedocument.presentationml.template', 'ext': '.potx'},
                          {'mime': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'ext': '.xlsx'},
                          {'mime': 'application/vnd.openxmlformats-officedocument.spreadsheetml.template', 'ext': '.xltx'},
                          {'mime': 'application/msword', 'ext': '.doc'},
                          {'mime': 'application/msword', 'ext': '.dot'},
                          {'mime': 'application/vnd.ms-powerpoint', 'ext': '.ppt'},
                          {'mime': 'application/vnd.ms-powerpoint', 'ext': '.pot'},
                          {'mime': 'application/vnd.ms-excel', 'ext': '.xls'},
                          {'mime': 'application/vnd.ms-excel', 'ext': '.xlt'}]

username = (sys.argv[1])
filename = os.path.expanduser(sys.argv[2])
try:
  f = open(filename, 'rb')
  f.close()
except IOError as e:
  sys.stderr.write(f'ERROR: {filename}: {str(e)}\n')
  sys.exit(1)

body = {'name': os.path.basename(filename)}
body['mimeType'] = mimetypes.guess_type(filename)[0]
# print(body)
if body['mimeType'] is None:
  body['mimeType'] = 'application/octet-stream'
try:
  media_body = googleapiclient.http.MediaFileUpload(filename, mimetype=body['mimeType'], resumable=True)
  if media_body.size() == 0:
    media_body = None
except IOError as e:
  sys.stderr.write(f'ERROR: {filename}: {str(e)}\n')
  sys.exit(2)

# Initialize GAM environmewnt
gam.SetGlobalVariables(GAMCFG)

# Get Service Account object
gapiDriveObj = gam.buildGAPIServiceObject(API.DRIVE3, username)
if gapiDriveObj is None:
  sys.exit(3)

# Create file
result = gam.DriveFilesCreate(gapiDriveObj,
                              media_body=media_body,
                              body=body,
                              fields='id,name,mimeType,webViewLink',
                              supportsAllDrives=True)

if not isinstance(result, dict):
  sys.stderr.write(f'ERROR: API error: {result}\n')
  sys.exit(4)

# Display link
for mt in MICROSOFT_FORMATS_LIST:
  if body['mimeType'] == mt['mime']:
    if mt['ext'][1] == 'd':
      sys.stdout.write(f'https://docs.google.com/document/d/{result["id"]}/edit\n')
      sys.exit(0)
    if mt['ext'][1] == 'x':
      sys.stdout.write(f'https://docs.google.com/spreadsheets/d/{result["id"]}/edit\n')
      sys.exit(0)
    if mt['ext'][1] == 'p':
      sys.stdout.write(f'https://docs.google.com/presentation/d/{result["id"]}/edit\n')
      sys.exit(0)
sys.stdout.write(f'https://drive.google.com/file/d/{result["id"]}/edit\n')
sys.exit(0)
