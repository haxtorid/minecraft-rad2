#!/bin/bash

# Step 1: Execute ./docker-install.sh
echo "Executing docker-install.sh"
./docker-install.sh

echo "Install Tools"
apt install unzip cron ufw

echo "Install Google Drive CLI for Linux"
wget https://github.com/glotlabs/gdrive/releases/download/3.9.1/gdrive_linux-x64.tar.gz
tar -xvzf gdrive_linux-x64.tar.gz
sudo mv gdrive /usr/local/bin/
rm gdrive_linux-x64.tar.gz

# Step 2: Download the RAD2-Serverpack-1.11.zip
echo "Downloading RAD2-Serverpack-1.11.zip"
curl -o RAD2-Serverpack-1.11.zip https://mediafilez.forgecdn.net/files/5339/972/RAD2-Serverpack-1.11.zip

# Step 3: Save to current folder (Already done by curl command)

# Step 4: Extract folder to /extract
echo "Extracting RAD2-Serverpack-1.11.zip to /extract"
mkdir -p ./extract
unzip RAD2-Serverpack-1.11.zip -d ./extract
rm RAD2-Serverpack-1.11.zip

# Step 5: Copy the necessary folder to ./data
# Assuming the structure inside the zip file is /extract/parent_folder/child_folder
echo "Copying necessary files to ./data"
mkdir -p ./data
cp -r ./extract/*/* ./data
find ./data -maxdepth 1 -type f -exec rm -f {} \;

# Step 6: Install ufw
echo "Installing ufw"
apt-get update
apt-get install -y ufw

# Step 7: Allow ufw for 22, http, https, 25565, 23620, other required ports for basic ssh & http
echo "Configuring ufw"
ufw allow 22
ufw allow http
ufw allow https
ufw allow 25565
ufw allow 23620

# Step 8: Enable ufw
# echo "Enabling ufw"
# ufw enable

echo "Setup complete!"
