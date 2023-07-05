#! /bin/zsh

echo Starting local chain ...

osascript -e 'tell application "iTerm" to activate' -e 'tell application "System Events" to keystroke "t" using command down' -e 'tell application "System Events" to tell process "iTerm" to keystroke "cd ~/local_tomo/bootnode && bootnode -nodekey boot.key "'  -e 'tell application "System Events" to tell process "iTerm" to key code 52'


echo "Bootnode has been started"


osascript -e 'tell application "iTerm" to activate' -e 'tell application "System Events" to keystroke "t" using command down' -e 'tell application "System Events" to tell process "iTerm" to keystroke "cd ~/local_tomo/node1 && ./start.sh "' -e 'tell application "System Events" to tell process "iTerm" to key code 52'

echo "Node1 has been started"

osascript -e 'tell application "iTerm" to activate' -e 'tell application "System Events" to keystroke "t" using command down' -e 'tell application "System Events" to tell process "iTerm" to keystroke "cd ~/local_tomo/node2 && ./start.sh "' -e 'tell application "System Events" to tell process "iTerm" to key code 52'

echo "Node2 has been started"

osascript -e 'tell application "iTerm" to activate' -e 'tell application "System Events" to keystroke "t" using command down' -e 'tell application "System Events" to tell process "iTerm" to keystroke "cd ~/local_tomo/node3 && ./start.sh "' -e 'tell application "System Events" to tell process "iTerm" to key code 52'

echo "Node3 has been started"

osascript -e 'tell application "iTerm" to activate' -e 'tell application "System Events" to keystroke "t" using command down' -e 'tell application "System Events" to tell process "iTerm" to keystroke "cd ~/local_tomo/node4 && ./start.sh "' -e 'tell application "System Events" to tell process "iTerm" to key code 52'

echo "Node4 has been started"

osascript -e 'tell application "iTerm" to activate' -e 'tell application "System Events" to keystroke "t" using command down' -e 'tell application "System Events" to tell process "iTerm" to keystroke "cd ~/local_tomo/node5 && ./start.sh "' -e 'tell application "System Events" to tell process "iTerm" to key code 52'

echo "Node5 has been started"
