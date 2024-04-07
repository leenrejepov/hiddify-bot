#!/bin/bash

# Update package lists
sudo apt update

# Install npm
sudo apt install npm -y

# Install firefox
sudo install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla
sudo apt update 
sudo apt install firefox -y

# Install GeckoDriver
wget https://github.com/mozilla/geckodriver/releases/download/v0.19.1/geckodriver-v0.19.1-linux64.tar.gz
tar xvfz geckodriver-v0.19.1-linux64.tar.gz
mv geckodriver ~/.local/bin

# Install pm2 globally using npm
sudo npm install -g pm2

# Install python3-pip
sudo apt install python3-pip -y

# Install Python dependencies
pip3 install -r requirements.txt

# Start the main.py script using pm2
pm2 start "python3 main.py" --name "hiddify-bot"
