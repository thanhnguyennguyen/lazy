# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
export PATH=$PATH:/usr/local/go/bin
export PATH=/usr/local/go/bin:$PATH
export PATH=$PATH:$HOME/git/lazy/
export PATH=$PATH:/usr/bin/:/bin/
export GOROOT=/usr/local/go
cat ~/git/lazy/custom_terminal/welcome.message
export GOPATH=~/go
export PATH=$PATH:/usr/local/go/bin
export PATH="$HOME/.cargo/bin:$PATH:~/go/src/github.com/tomochain/tomochain/build/bin"
export EVMC_PATH=~/git/ewasm-hera/build/src/libhera.so,engine=wabt,evm1mode=evm2wasm
alias gittool=~/git/lazy/git/gittool.sh
alias bootnode="$HOME/go/src/github.com/tomochain/tomochain/build/bin/bootnode"
alias tomo="$HOME/go/src/github.com/tomochain/tomochain/build/bin/tomo"
alias tomochain="cd ~/go/src/github.com/tomochain/tomochain"
alias iserr="tomochain && GO111MODULE=on make all"
alias sdk="cd ~/git/tomox-sdk"
alias hera="cd ~/git/ewasm-hera/"
alias buildhera="hera && rm -rf build && mkdir build && cd build && cmake -DBUILD_SHARED_LIBS=ON -DHERA_BINARYEN=ON -DHERA_WABT=ON .. && cmake --build ."
alias tomup="setopt +o nomatch && cd ~ && rm -rf .tomo* && tomochain && GO111MODULE=on make tomo && cd ~ && ./resetChain.sh && ./use-backup-chaindata.sh && ./startChain.sh && pm2 flush sdk-backend && echo restart backend-dex .. && sleep 20s && sdk && rm -rf ohlcv.cache && pm2 restart sdk-backend  && echo Hey bot, waking up please .. && sleep 20s && tomochain && cd /home/nguyen/go/src/github.com/thanhnguyennguyen/tomox-bot/ && export GO111MODULE=off && go build && cp bot  local/TOMOUSD/bot && cd local/TOMOUSD && ./bot  "
alias tomdown="pkill -f announce-txs && pkill -f bootnode && pkill -f  tomox.dbengine "
alias tomreload="cd ~ && ./startChain.sh"
alias editprofile="sudo vim ~/.profile"
alias viewprofile="cat ~/.profile"
alias applyprofile="source ~/.profile"
alias node1ipc="cd ~/local_tomo/node1 && tomo attach tomo.ipc"
alias node2ipc="cd ~/local_tomo/node2 && tomo attach tomo.ipc"
alias node3ipc="cd ~/local_tomo/node3 && tomo attach tomo.ipc"
alias node4ipc="cd ~/local_tomo/node4 && tomo attach tomo.ipc"
alias node5ipc="cd ~/local_tomo/node5 && tomo attach tomo.ipc"
alias fullnodeipc="cd ~/fullnode_tomo/ && tomo attach tomo.ipc"
alias goland="/opt/GoLand-2019.1.1/bin/goland.sh"
alias node1rpc="tomo attach http://127.0.0.1:1545"
alias node2rpc="tomo attach http://127.0.0.1:2545"
alias node3rpc="tomo attach http://127.0.0.1:3545"
alias node4rpc="tomo attach http://127.0.0.1:4545"
alias node5rpc="tomo attach http://127.0.0.1:5545"
alias parity=" ~/git/parity-ethereum/target/release/parity"
alias mongup="docker start mongodb"
alias mongdown="docker stop mongodb"
alias gfu="git fetch upstream && git pull upstream "
export GREP_COLOR='1;32'
export MAIN_ADDRESS_KEY="65ec4d4dfbcac594a14c36baa462d6f73cd86134840f6cf7b80a1e1cd33473e2"
export MAIN_ADDRESS="0x17F2beD710ba50Ed27aEa52fc4bD7Bda5ED4a037"
export RELAYER_COINBASE_KEY="49a7b37aa6f6645917e7b807e9d1c00d4fa71f18343b0d4122a4d2df64dd6fee"
export RELAYER_OWNER_KEY="8a1f9a8f95be41cd7ccb6168179afb4504aefe388d1e14474d32c45c72ce7b7a"
export BOT_ADDR_KEY="73b5236e8c0781fc9ce40d71f5bcdd2187753b2653410c5e6fdf4a2a961737fd"
export BOT_ADDR="0xb68D825655F2fE14C32558cDf950b45beF18D218"
export HOOK_KEY="T4HB0VB0D/BMD280C10/KylmsbQGMCl5r2YkxFmvEc6m"
alias heybot="tomochain && cd tomox/bot_temp && cat ~/tomox_bot_message.txt && printf \"To start bot, please follow the syntax: \\n ./bot [address] [key] \\n Enjoy!\""
alias stopworking="pkill -f goland && pkill -f brave && pkill -f chrome"
alias startworking="bash ~/startPC"
export GO111MODULE=on
export PATH=~/.npm-global/bin:~/Desktop/solc:$PATH
alias tomoxbot=~/go/src/github.com/thanhnguyennguyen/tomox-bot
alias pricebot=~/git/crypto-price-bot

