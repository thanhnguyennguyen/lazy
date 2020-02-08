#!/bin/bash
usage()
{
    echo " gittool:
      - gittool -a  ( --assign ) [issue/pull request number] [assignee]: assign an issue/pull request to an assignee
      - gittool -ai ( --assigned-issues) : get list of open issues assigned to me
      - gittool -ap ( --approve-pull ) [pull request number] [comment message]: approve a pull request with a message
      - gittool -b  ( --base ) [git repo url] : set repo url
      - gittool -c  ( --comment ) [issue/pull request number] [content]: comment on an issue/pull request
      - gittool -cl ( --close-issue ) [issue/pull request number] : close an issue/pull request
      - gittool -d  ( --done ) [Your commit message] [upstream/origin]: 
         automatically commit your code and push to remote github repo (Remember to add stages in advance)
         If your repo is fotked from another one, please add upstream by: git remote add  upstream [url]
                                   - upstream: by default, create new branch in origin and pull request to upstream repository
                                   - origin: create PR to origin. don't touch to upstream
                           if your repo is not a fork repo, let's leave it empty by default
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
    "
}
if [ "$1" = "" ]
then
    usage
    exit
fi
base=""
token=$(cat ~/git/config.txt)
checkRepo()
{
    base=$(git config --get remote.origin.url)
    if [ "$base" = "" ]
    then
        echo "No git config found. Please go to your git project or set your remote repo"
        echo "eg: gittool -b git@github.com:thanhnguyennguyen/lazy.git"
        echo "or go to git repository directory"
        exit
    fi
    repo=$(echo $base | cut -d':' -f 2 | cut -d'.' -f 1)
}
createPull()
{   
    pullRepo=$(echo $base | cut -d':' -f 2 | cut -d'.' -f 1)
    upstream=$(git config --get remote.upstream.url)
    if [[ "$upstream" != "" && "$4" != "origin" ]]
    then
        pullRepo=$(echo $upstream | cut -d':' -f 2 | cut -d'.' -f 1)
    fi
    baseBranch=$1
    title="$2"
    body="$content$3"
    currentUser=$(echo $base | cut -d':' -f 2 | cut -d'/' -f 1)
    currentBranch=$(git branch | grep \* | cut -d ' ' -f2)
    response=$(curl -s -X POST https://api.github.com/repos/$pullRepo/pulls -u "$token" -d "{\"title\":\"$title\", \"base\":\"$baseBranch\", \"head\":\"$currentUser:$currentBranch\", \"body\": \"$body\"}" | jq -r '.number')
    $0 -a $response $currentUser
    $0 -l $response awaiting_review
}
content="(This content is created via [Gittool](https://github.com/thanhnguyennguyen/lazy/blob/master/gittool.sh)) \n"
while [ "$1" != "" ]; do
    case $1 in
        -b  | --base )          base=$2
                                git remote set-url origin $base;;
        -d  | --done )          checkRepo
                                commitMessage=$2
                                # commit code and push
                                if [ "$commitMessage" != "" ]
                                then
                                    git commit -m "$commitMessage"
                                    git push --set-upstream origin $(git branch | grep \* | cut -d ' ' -f2)
                                    createPull master "$commitMessage" "$commitMessage" $3
                                    exit
                                fi;;
        -r  | --review )        checkRepo
                                reviewNumber=$2
                                #  start a review
                                if [ "$reviewNumber" != "" ]
                                then
                                    # start review
                                    response=$(curl -s -X POST https://api.github.com/repos/$repo/pulls/$reviewNumber/reviews -u "$token")
                                    (xdg-open https://github.com/$repo/pull/$reviewNumber & )
                                    exit
                                fi;;
        -ap  | --approve-pull ) checkRepo
                                pullNumber=$2
                                content=$content$3
                                #  submit a comment
                                reviewId=$(curl -s -X POST https://api.github.com/repos/$repo/pulls/$pullNumber/reviews -u "$token" | jq -r '.id')
                                echo https://api.github.com/repos/$repo/pulls/$pullNumber/reviews/$reviewId/events/ 
                                curl -s -X POST https://api.github.com/repos/$repo/pulls/$pullNumber/reviews/$reviewId/events -u "$token" --data "{\"body\":\"$content\", \"event\":\"APPROVE\"}"
                                exit;;
        -rp  | --reject-pull )  checkRepo
                                pullNumber=$2
                                content=$content$3
                                #  submit a comment
                                reviewId=$(curl -s -X POST https://api.github.com/repos/$repo/pulls/$pullNumber/reviews -u "$token" | jq -r '.id')
                                echo https://api.github.com/repos/$repo/pulls/$pullNumber/reviews/$reviewId/events/ 
                                curl -s -X POST https://api.github.com/repos/$repo/pulls/$pullNumber/reviews/$reviewId/events -u "$token" --data "{\"body\":\"$content\", \"event\":\"REQUEST_CHANGES\"}"
                                exit;;
        -i  | --issue )    checkRepo
                                title=$2
                                body=$content$3
                                curl -s -X POST https://api.github.com/repos/$repo/issues?state=all/ -u "$token" --data "{\"title\":\"$title\", \"body\":\"$body\"}"
                                exit;;
        -c  | --comment )       checkRepo
                                number=$2
                                content=$content$3
                                #  submit a comment
                                curl -s -X POST https://api.github.com/repos/$repo/issues/$number/comments?state=all/ -u "$token" -d "{\"body\":\"$content\"}"
                                exit;;
        -a  | --assign ) number=$2
                                checkRepo
                                assignee=$3
                                curl -s -X POST https://api.github.com/repos/$repo/issues/$number/assignees?state=all/ -u "$token" -d "{\"assignees\":\"$assignee\"}"
                                exit;;
        -l  | --label )         checkRepo
                                number=$2
                                label=$3
                                curl -s -X POST https://api.github.com/repos/$repo/issues/$number/labels?state=all/ -u "$token" -d "{\"labels\":[\"$label\"]}"
                                exit;;
        -rl  | --remove-label ) checkRepo
                                number=$2
                                label=$3
                                curl -s -X DELETE https://api.github.com/repos/$repo/issues/$number/labels?state=all/$label -u "$token"
                                exit;;
        -cl  | --close       )  checkRepo
                                number=$2
                                curl -s -X POST https://api.github.com/repos/$repo/issues/$number?state=all -u "$token" -d "{\"state\":\"closed\"}"
                                exit;;
        -m  | --merge       )   checkRepo
                                number=$2
                                curl -s -X PUT https://api.github.com/repos/$repo/pulls/$number/merge -u "$token"
                                $0 -rl $number "awaiting_review"
                                $0 -l $number "done"
                                exit;;
        -s   | --sync )         checkRepo
                                git checkout master
                                git fetch upstream
                                git pull upstream master
                                git push origin master -f
                                exit;;
        -h  | --help )          usage
                                exit
                                ;;
        -v  | --version )       echo gittool 
                                echo https://github.com/thanhnguyennguyen/lazy/blob/master/gittool.sh
                                DIR=$( dirname $0)
                                curVer=$(cat $DIR/lazy.ver)
                                echo Version $curVer
                                response=$(curl -s -X GET https://api.github.com/repos/thanhnguyennguyen/lazy/releases | jq -r ".[] | .tag_name ")
                                releases=($response)
                                if [ ${releases[0]} = $curVer ]
                                then
                                    echo Your tools are up to date!
                                else
                                    echo Your tools are out of date. The latest release is ${releases[0]}
                                    echo "Please update using this command "
                                    echo "curl -L https://raw.githubusercontent.com/thanhnguyennguyen/lazy/master/gittool.sh -o ~/gittool.sh && curl -L https://raw.githubusercontent.com/thanhnguyennguyen/lazy/master/ver.txt -o ~/lazy.ver" 
                                fi
                                exit
                                ;;
        -p  | --pull )          checkRepo
                                createPull $2 $3 $4
                                exit
                                ;;
        -rr | --review-request ) checkRepo
                                pr=$2 
                                reviewer=$3
                                curl -s -X POST https://api.github.com/repos/$repo/pulls/$pr/requested_reviewers -u "$token" -d "{\"reviewers\":[\"$reviewer\"]}"
                                exit
                                ;;
        -mop | --my-open-pullrequests ) checkRepo
                                curl -s -X GET https://api.github.com/repos/$repo/pulls -u "$token" | jq -r ".[] | .title" > tempTitles.txt
                                curl -s -X GET https://api.github.com/repos/$repo/pulls -u "$token" | jq -r ".[] | .html_url" > tempUrls.txt
                                curl -s -X GET https://api.github.com/repos/$repo/pulls -u "$token" | jq -r ".[] | .assignee.login" > tempAssignee.txt
                                titles=($(cat  tempTitles.txt | tr " " "_" | tr "\n" " "))
                                urls=($(cat  tempUrls.txt | tr " " "_" | tr "\n" " "))
                                assignee=($(cat  tempAssignee.txt | tr " " "_" | tr "\n" " "))
                                rm tempTitles.txt tempUrls.txt tempAssignee.txt
                                currentUser=$(curl -s -X GET https://api.github.com/user -u "$token" | jq -r ".login")
                                num=0
                                for ((i = 0; i < ${#titles[@]}; ++i)); do
                                    if [[ "${assignee[i]}" == *"$currentUser"* ]]
                                    then
                                        echo "$i: ${titles[$i]} ${urls[$i]} ${assignee[i]}"
                                        num=$num+1
                                    fi
                                done
                                if [ $num = 0 ]
                                then
                                    echo YOU HAVE NO OPENING PULL REQUEST
                                fi
                                exit
                                ;;
        -mr | --my-review )     checkRepo
                                curl -s -X GET https://api.github.com/repos/$repo/pulls -u "$token" | jq -r ".[] | .title" > tempTitles.txt
                                curl -s -X GET https://api.github.com/repos/$repo/pulls -u "$token" | jq -r ".[] | .html_url" > tempUrls.txt
                                curl -s -X GET https://api.github.com/repos/$repo/pulls -u "$token" | jq -r ".[] | .requested_reviewers[].login" > tempReviewer.txt
                                curl -s -X GET https://api.github.com/repos/$repo/pulls -u "$token" | jq -r ".[] | .assignee.login" > tempAssignee.txt
                                titles=($(cat  tempTitles.txt | tr " " "_" | tr "\n" " "))
                                urls=($(cat  tempUrls.txt | tr " " "_" | tr "\n" " "))
                                reviewers=($(cat  tempReviewer.txt | tr " " "_" | tr "\n" " "))
                                assignee=($(cat  tempAssignee.txt | tr " " "_" | tr "\n" " "))
                                rm tempTitles.txt tempUrls.txt tempAssignee.txt tempReviewer.txt
                                currentUser=$(curl -s -X GET https://api.github.com/user -u "$token" | jq -r ".login")
                                num=0
                                for ((i = 0; i < ${#titles[@]}; ++i)); do
                                    if [[ "${reviewers[i]}" == *"$currentUser"* ]]
                                    then
                                        echo "$i: ${titles[$i]} ${urls[$i]} ${assignee[i]}"
                                        num=$num+1
                                    fi
                                done
                                if [ $num = 0 ]
                                then
                                    echo NOTHING TO REVIEW
                                fi
                                exit
                                ;;
        -op | --open-pullrequests ) checkRepo
                                curl -s -X GET https://api.github.com/repos/$repo/pulls -u "$token" | jq -r ".[] | .title" > tempTitles.txt
                                curl -s -X GET https://api.github.com/repos/$repo/pulls -u "$token" | jq -r ".[] | .html_url" > tempUrls.txt
                                curl -s -X GET https://api.github.com/repos/$repo/pulls -u "$token" | jq -r ".[] | .assignee.login" > tempAssignee.txt
                                titles=($(cat  tempTitles.txt | tr " " "_" | tr "\n" " "))
                                urls=($(cat  tempUrls.txt | tr " " "_" | tr "\n" " "))
                                assignee=($(cat  tempAssignee.txt | tr " " "_" | tr "\n" " "))
                                rm tempTitles.txt tempUrls.txt tempAssignee.txt
                                if [ ${#titles[@]} = 0 ]
                                then
                                    echo NO OPENING PULL REQUEST IN THIS REPO
                                fi
                                for ((i = 0; i < ${#titles[@]}; ++i)); do
                                    echo "$i: ${titles[$i]} ${urls[$i]} ${assignee[i]}"
                                done
                                exit
                                ;;
        -oi | --open-issues ) checkRepo
                                curl -s -X GET https://api.github.com/repos/$repo/issues -u "$token" | jq -r ".[] | .title" > tempTitles.txt
                                curl -s -X GET https://api.github.com/repos/$repo/issues -u "$token" | jq -r ".[] | .html_url" > tempUrls.txt
                                curl -s -X GET https://api.github.com/repos/$repo/issues -u "$token" | jq -r ".[] | .pull_request.html_url" > tempPulls.txt
                                curl -s -X GET https://api.github.com/repos/$repo/issues -u "$token" | jq -r ".[] | .assignee.login" > tempAssignee.txt
                                titles=($(cat  tempTitles.txt | tr " " "_" | tr "\n" " "))
                                urls=($(cat  tempUrls.txt | tr " " "_" | tr "\n" " "))
                                pulls=($(cat  tempPulls.txt | tr " " "_" | tr "\n" " "))
                                assignee=($(cat  tempAssignee.txt | tr " " "_" | tr "\n" " "))
                                rm tempTitles.txt tempUrls.txt tempPulls.txt tempAssignee.txt
                                num=0
                                for ((i = 0; i < ${#titles[@]}; ++i)); do
                                    if [ "${pulls[i]}" = "null" ]
                                    then
                                        echo "$i: ${titles[$i]} ${urls[$i]} ${assignee[i]}"
                                        num=$num+1
                                    fi
                                done
                                if [ $num = 0 ]
                                then
                                    echo NO OPENING ISSUE IN THIS REPO
                                fi
                                exit
                                ;;
        -ai | --assigned-issues ) response=$(curl -s -X GET https://api.github.com/user/issues -u "$token" | jq -r ".[] | .title, .html_url ")
                                if [ ${#response[@]} = 0 ]
                                then
                                    echo NO ISSUE ASSIGNED TO YOU
                                fi
                                for i in "${response}"
                                do
                                    echo "$i\n"
                                done
                                exit
                                ;;
        -t | --tag )            checkRepo
                                tagName=$2
                                releaseName=$3
                                curl -s -X POST https://api.github.com/repos/$repo/releases -u "$token" -d "{\"tag_name\": \"$tagName\", \"name\":\"$releaseName\"}"
                                exit
                                ;;
        --releases )            checkRepo
                                response=$(curl -s -X GET https://api.github.com/repos/$repo/releases -u "$token" | jq -r ".[] | .tag_name, .name, .html_url ")
                                for i in "${response}"
                                do
                                    echo "$i\n"
                                done
                                exit
                                ;;
    esac
        echo "Invalid option!"
        usage
        shift
done

