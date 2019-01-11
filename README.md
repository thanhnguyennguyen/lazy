# lazy tools
 I hate doing repeated and bored things. I'm okay to spend a lot of time to write some scripts just in case I do something more than twice.
 It should be exactly done by my computer.
 
 - start_mac.sh: add this script to startup to automatically launch necessary applications when you start your Mac
 - start_ubuntu: add this script to startup to automatically launch necessary applications when you start your PC
 - gittool.sh:
     - Prerequisite: 
          -  install https://hub.github.com to create pull request
          -  `alias gittool="path/to/gittool.sh"`
          - update config file config.txt with format your_git_username:yourtoken (generate your token here https://github.com/settings/tokens/new)
      - Usage:
          - gittool -h: show helps
          - gittool -d "Your commit message" : automatically commit your code and push to remote github repo (Remember to add stages in advance)
          - gittool -r [pull request number]: start your review.

 

 
