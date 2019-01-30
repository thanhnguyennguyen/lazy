# lazy tools
 I hate doing repeated and bored things. I'm okay to spend a lot of time to write some scripts just in case I do something more than twice.
 It should be exactly done by my computer.
 
 - start_mac.sh: add this script to startup to automatically launch necessary applications when you start your Mac
 - start_ubuntu: add this script to startup to automatically launch necessary applications when you start your PC
 - gittool.sh:
     - Prerequisite: 
          -  `alias gittool="path/to/gittool.sh"`
          - update config file ~/git/config.txt with format your_git_username:yourtoken (generate your token here https://github.com/settings/tokens/new)
      - Usage:
      ```
      - gittool -a  ( --assign ) [issue/pull request number] [assignee]: assign an issue/pull request to an assignee
      - gittool -ai ( --assigned-issues) : get list of open issues assigned to me
      - gittool -ap ( --approve-pull ) [pull request number] [comment message]: approve a pull request with a message
      - gittool -b  ( --base ) [git repo url] : set repo url
      - gittool -c  ( --comment ) [issue/pull request number] [content]: comment on an issue/pull request
      - gittool -cl ( --close-issue ) [issue/pull request number] : close an issue/pull request
      - gittool -d  ( --done ) [Your commit message] : automatically commit your code and push to remote github repo (Remember to add stages in advance)
      - gittool -h  ( --help ) : show helps
      - gittool -i  ( --issue ) [title] [content]: create new issue
      - gittool -l  ( --label ) [issue/pull request number] [label name] : label an issue/ pull request
      - gittool -m  ( --merge) [pull request number]: merge a pull request
      - gittool -oi ( --open-issues) : get list of open issues of current repository
      - gittool -op ( --open-pullrequests): get list of open pull request
      - gittool -p  ( --pull ) [base branch] [title] [content (optional)]
      - gittool -r  ( --review ) [pull request number]: start your review.
      - gittool -rl ( --remove-label ) [issue/pull request number] [label name] : remove a label from an issue/ pull request
      - gittool -rp ( --reject-pull ) [pull request number] [comment message]: reject a pull request with a message
      - gittool -rr ( --review-request) [pull number] [reviewer] : request a review
      - gittool --releases  : list all releases
      - gittool -s  ( --sync) : sync fork repo with upstream
      - gittool -t  ( --tag) [tag name] [release name] : tag and publish a release
      - gittool -v  ( --version ) : print version

```

 

