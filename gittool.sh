#!/bin/sh
usage()
{
    echo " gittool:
          - gittool -h  | --help : show helps
          - gittool -d  | --done [Your commit message] : automatically commit your code and push to remote github repo (Remember to add stages in advance)
          - gittool -r  | --review [pull request number]: start your review.
          - gittool -ap | --approve-pull [pull request number] [comment message]: approve a pull request with a message
          - gittool -rp | --reject-pull [pull request number] [comment message]: reject a pull request with a message
          - gittool -i  | --issue [title] [content]: create new issue
          - gittool -c  | --comment [issue/pull request number] [content]: comment on an issue/pull request
          - gittool -cl | --close-issue [issue/pull request number] : close an issue/pull request
          - gittool -a  | --assign [issue/pull request number] [assignee]: assign an issue/pull request to an assignee
          - gittool -l  | --label [issue/pull request number] [label name] : label an issue/ pull request
          - gittool -rl | --remove-label [issue/pull request number] [label name] : remove a label from an issue/ pull request
          - gittool -m  | --merge [pull request number]: merge a pull request
          - gittool -p  ( --pull ) [base branch] [title] [content (optional)]
          - gittool -rr ( --review-request) [pull number] [reviewer] : request a review
          - gittool -op ( --open-pullrequests): get list of open pull request
          - gittool -oi ( --open-issues) : get list of open issues of current repository
          - gittool -v  | --version : print version
    "
}
if [ "$1" == "" ]
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
        exit
    fi
    repo=$(echo $base | cut -d':' -f 2 | cut -d'.' -f 1)
}
createPull()
{   
    baseBranch=$1
    title="$2"
    body="$content$3"
    currentBranch=$(git branch | grep \* | cut -d ' ' -f2)
    curl -X POST https://api.github.com/repos/$repo/pulls -u "$token" -d "{\"title\":\"$title\", \"base\":\"$baseBranch\", \"head\":\"$currentBranch\", \"body\": \"$body\"}"
}
content="(This content is created via Gittool) \n"
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
                                    createPull master "$commitMessage" "$commitMessage"
                                    exit
                                fi;;
        -r  | --review )        checkRepo
                                reviewNumber=$2
                                #  start a review
                                if [ "$reviewNumber" != "" ]
                                then
                                    # start review
                                    response=$(curl -X POST https://api.github.com/repos/$repo/pulls/$reviewNumber/reviews -u "$token")
                                    (xdg-open https://github.com/$repo/pull/$reviewNumber & )
                                    exit
                                fi;;
        -ap  | --approve-pull ) checkRepo
                                pullNumber=$2
                                content=$content$3
                                #  submit a comment
                                reviewId=$(curl -s -X POST https://api.github.com/repos/$repo/pulls/$pullNumber/reviews -u "$token" | jq -r '.id')
                                echo https://api.github.com/repos/$repo/pulls/$pullNumber/reviews/$reviewId/events/ 
                                curl -X POST https://api.github.com/repos/$repo/pulls/$pullNumber/reviews/$reviewId/events -u "$token" --data "{\"body\":\"$content\", \"event\":\"APPROVE\"}"
                                exit;;
        -rp  | --reject-pull )  checkRepo
                                pullNumber=$2
                                content=$content$3
                                #  submit a comment
                                reviewId=$(curl -s -X POST https://api.github.com/repos/$repo/pulls/$pullNumber/reviews -u "$token" | jq -r '.id')
                                echo https://api.github.com/repos/$repo/pulls/$pullNumber/reviews/$reviewId/events/ 
                                curl -X POST https://api.github.com/repos/$repo/pulls/$pullNumber/reviews/$reviewId/events -u "$token" --data "{\"body\":\"$content\", \"event\":\"REQUEST_CHANGES\"}"
                                exit;;
        -i  | --issue )    checkRepo
                                title=$2
                                body=$content$3
                                curl -X POST https://api.github.com/repos/$repo/issues?state=all/ -u "$token" --data "{\"title\":\"$title\", \"body\":\"$body\"}"
                                exit;;
        -c  | --comment )       checkRepo
                                number=$2
                                content=$content$3
                                #  submit a comment
                                curl -X POST https://api.github.com/repos/$repo/issues/$number/comments?state=all/ -u "$token" -d "{\"body\":\"$content\"}"
                                exit;;
        -a  | --assign ) number=$2
                                checkRepo
                                assignee=$3
                                curl -X POST https://api.github.com/repos/$repo/issues/$number/assignees?state=all/ -u "$token" -d "{\"assignees\":\"$assignee\"}"
                                exit;;
        -l  | --label )         checkRepo
                                number=$2
                                label=$3
                                curl -X POST https://api.github.com/repos/$repo/issues/$number/labels?state=all/ -u "$token" -d "{\"labels\":[\"$label\"]}"
                                exit;;
        -rl  | --remove-label ) checkRepo
                                number=$2
                                label=$3
                                curl -X DELETE https://api.github.com/repos/$repo/issues/$number/labels?state=all/$label -u "$token"
                                exit;;
        -cl  | --close       )  checkRepo
                                number=$2
                                curl -X POST https://api.github.com/repos/$repo/issues/$number?state=all -u "$token" -d "{\"state\":\"closed\"}"
                                exit;;
        -m  | --merge       )   checkRepo
                                number=$2
                                curl -X PUT https://api.github.com/repos/$repo/pulls/$number/merge -u "$token"
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
        -v  | --version )       echo gittool v1.0.1 https://github.com/thanhnguyennguyen/lazy/blob/master/gittool.sh
                                exit
                                ;;
        -p  | --pull )          checkRepo
                                createPull $2 $3 $4
                                exit
                                ;;
        -rr | --review-request ) checkRepo
                                pr=$2 
                                reviewer=$3
                                curl -X POST https://api.github.com/repos/$repo/pulls/$pr/requested_reviewers -u "$token" -d "{\"reviewers\":[\"$reviewer\"]}"
                                exit
                                ;;
        -op | --open-pullrequests ) checkRepo
                                response=$(curl -X GET https://api.github.com/repos/$repo/pulls -u "$token" | jq -r ".[] | .title, .url ")
                                for i in "${response}"
                                do
                                    echo "$i\n"
                                done
                                exit
                                ;;
        -oi | --open-issues ) checkRepo
                                response=$(curl -X GET https://api.github.com/repos/$repo/issues -u "$token" | jq -r ".[] | .title, .url ")
                                for i in "${response}"
                                do
                                    echo "$i\n"
                                done
                                exit
                                ;;
    esac
    shift
done


