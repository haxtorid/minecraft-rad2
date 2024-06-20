# Script Setup Minecraft RaD2 (Roguelite Adventure and Dungeon 2)

##

### Feature
- Setup & Running using Docker
- Script Auto Backup
- report message of backup (Sending API)

### Installation

- chmod +x all sh files `chmod +x *.sh`
- ./setup.sh

This will
- install docker, unzip, GDrive, ufw, cron
- add ufw port 22, http, https, 25565, 23620
- setup & run minecraft rad inside docker

You need manual enabled the ufw by `ufw enable`

### Enable Backup

#### Setup Backup Google Drive

- Gain Oauth Client ID & Secret Key [Tutorial](https://github.com/glotlabs/gdrive/blob/main/docs/create_google_api_credentials.md)

- `gdrive account add` 

- process to enter account by giving client id and secret

- create backup folder or any in your google drive

- change `BACKUP_FOLDER_ID` on to Folder URL

ex: https://drive.google.com/drive/u/0/folders/1jvUqA3R2vlDlSiboq8CxE6qc7KEHdwmb

`1jvUqA3R2vlDlSiboq8CxE6qc7KEHdwmb` is the BACKUP_FOLDER_ID



#### To enable backup 

- Enter `crontab -e`

- Put this in end of line
```0 5 * * * /path/to/backup-script.sh``` 

> ⚠️ remember to change the path

or if want just single backup

run this `./backup.sh`

## Note
 ⚠️ I Don't do complete full test, i just do it and write it down as documentation so when i need to make server again i have template

## TODO
- [] make variable as part editable environment in single file
- [] Better docs
- [] Make more dynamic string for URL Downloading Resource
- [] Fully test in my another VPS
- [] Make video?

## Contribute

- You can Fork and make your own script or anything
- Suggest for better change
- pull request
- report issue related to script

## Special Thanks

- https://www.curseforge.com/minecraft/modpacks/roguelike-adventures-and-dungeons-2 The Modpack it Self 
- https://github.com/itzg/docker-minecraft-server for Base Docker Minecraft Server really helpfull
- https://github.com/glotlabs/gdrive for Google Drive Command line for Backup
