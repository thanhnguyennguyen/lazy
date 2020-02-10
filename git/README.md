# Git
- Sync fork repo with upstream
  
  When we fork a repository from another, we sometimes need to sync with upstream repository
  - Add upstream:
  ``` git remote add upstream git@github.com:....```
  - Run `bash sync.sh`
  
- Gittool 
  - Download: curl -L https://raw.githubusercontent.com/thanhnguyennguyen/lazy/master/gittool.sh -o ~/gittool.sh
  - Install jq to parse JSON response (https://stedolan.github.io/jq/)
  - alias gittool.sh
    ```
    alias gittool="~/gittool.sh"
    ```
  - update config file ~/git/config.txt with format your_git_username:yourtoken (generate your token here https://github.com/settings/tokens/new)
  - Usage:

      - gittool -a  ( --assign ) [issue/pull request number] [assignee]: assign an issue/pull request to an assignee
      - gittool -ai ( --assigned-issues) : get list of open issues assigned to me
      - gittool -ap ( --approve-pull ) [pull request number] [comment message]: approve a pull request with a message
      - gittool -b  ( --base ) [git repo url] : set repo url
      - gittool -c  ( --comment ) [issue number] [content]: comment on an issue
      - gittool -cp  ( --comment-pull ) [pull request number] [content]: comment on a pull request
      - gittool -cl ( --close-issue ) [issue/pull request number] : close an issue/pull request
      - gittool -d  ( --done ) [Your commit message] [upstream/origin]: 
         automatically commit your code and push to remote github repo (Remember to add stages in advance)
         - If your repo is forked from another one, please add upstream by: `git remote add  upstream [url]`
            - upstream: by default, create new branch in origin and pull request to upstream repository
            - origin: create PR to origin. don't touch to upstream
         - if your repo is not a fork repo, let's leave it empty by default
      - gittool -h  ( --help ) : show helps
      - gittool -i  ( --issue ) [title] [content]: create new issue
      - gittool -l  ( --label ) [issue/pull request number] [label name] : label an issue/ pull request
      - gittool -m  ( --merge) [pull request number]: merge a pull request
      - gittool -mop  ( --my-open-pullrequests) : list my opening pull requests in current repo
      - gittool -mr (--my-review): list PRs waiting for my review (in this repo)
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
