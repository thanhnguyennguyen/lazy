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
          - gittool -h | --help : show helps
          - gittool -d | --done [Your commit message] : automatically commit your code and push to remote github repo (Remember to add stages in advance)
          - gittool -r | --review [pull request number]: start your review.
          - gittool -cp | --comment [pull request number] [comment message]: comment on a pull request
          - gittool -ni | --new-issue [title] [content]: create new issue
          - gittool -ci | --comment-issue [issue number] [content]: comment on an issue
          - gittool -cl | --close-issue [issue number] : close an issue
          - gittool -ai | --assign-issue [issue number] [assignee]: assign an issue to an assignee


 

 
