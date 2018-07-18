#open bluejean standup meeting

open -a "/Applications/Google Chrome.app"  "https://bluejeans.com/358886629/"

#open slack
open -a "/Applications/Slack.app"

#open phpstorm
open -a "/Applications/PhpStorm.app"

#open nguyennguyen's tool

osascript -e 'tell application "iTerm" to activate' -e 'tell application "System Events" to keystroke "t" using command down' -e 'tell application "System Events" to tell process "iTerm" to keystroke "cd ~/shop/tools/nguyennguyen"' -e 'tell application "System Events" to tell process "iTerm" to key code 52'

#start docker for mac
cd ~/Applications
open -a Docker
echo 'starting Docker ...'
sleep 60

# start SHOP docker containers 
cd ~/shop-docker
echo 'starting docker containers ...'
osascript -e 'tell application "iTerm" to activate' -e 'tell application "System Events" to keystroke "t" using command down' -e 'tell application "System Events" to tell process "iTerm" to keystroke "cd ~/shop-docker && ./start-mac.sh"' -e 'tell application "System Events" to tell process "iTerm" to key code 52'
osascript -e 'tell application "iTerm" to activate' -e 'tell application "System Events" to keystroke "1" using command down'

# start mysql 
mysql.server start
echo 'starting mysql ...'

sleep 20

# start migrations and worker
./migration.sh
rm ~/shop/alice/local/config/config.php
cd ~/shop-docker
osascript -e 'tell app "System Events" to display dialog "PASSWORDDDDDDDDD"'
./host-ip.sh
./worker.sh
cd ~/shop