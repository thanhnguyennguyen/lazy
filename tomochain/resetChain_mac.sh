#! /bin/zsh
setopt +o nomatch && cd ~ && rm -rf .tomo*
cd ~/local_tomo/node1 && rm -rf tomo* && ./clean.sh
cd ~/local_tomo/node2 && rm -rf tomo* && ./clean.sh
cd ~/local_tomo/node3 && rm -rf tomo* && ./clean.sh
cd ~/local_tomo/node4 && rm -rf tomo* && ./clean.sh
cd ~/local_tomo/node5 && rm -rf tomo* && ./clean.sh
cd ~/local_tomo/node6 && rm -rf tomo* && ./clean.sh
