#!/bin/sh
usage()
{
    echo " gittool:
          - gittool -h  | --help : show helps
          - gittool -d  | --done [Your commit message] : automatically commit your code and push to remote github repo (Remember to add stages in advance)
          - gittool -r  | --review [pull request number]: start your review.
          - gittool -ap | --approve-pull [pull request number] [comment message]: approve a pull request with a message
          - gittool -rp | --reject-pull [pull request number] [comment message]: reject a pull request with a message
          - gittool -ni | --new-issue [title] [content]: create new issue
          - gittool -c  | --comment [issue/pull request number] [content]: comment on an issue/pull request
          - gittool -cl | --close-issue [issue/pull request number] : close an issue/pull request
          - gittool -a  | --assign [issue/pull request number] [assignee]: assign an issue/pull request to an assignee
          - gittool -l  | --label [issue/pull request number] [label name] : label an issue/ pull request
          - gittool -rl | --remove-label [issue/pull request number] [label name] : remove a label from an issue/ pull request
          - gittool -h  | --help : print usage
    "
}

base=$(git config --get remote.origin.url)
if [ "$base" = "" ]
then
    echo "Please set your remote repo"
    echo "eg: gittool -b git@github.com:thanhnguyennguyen/lazy.git"
    exit
fi
repo=$(echo $base | cut -d':' -f 2 | cut -d'.' -f 1)

while [ "$1" != "" ]; do
    case $1 in
        -b  | --base )          base=$2
                                git remote set-url origin $base;;
        -d  | --done )          commit=$2
                                # commit code and push
                                if [ "$commit" != "" ]
                                then
                                    git commit -m "$commit"
                                    git push --set-upstream origin $(git branch | grep \* | cut -d ' ' -f2)
                                    hub pull-request -b master -m "$commit"
                                    exit
                                fi;;
        -r  | --review )        reviewNumber=$2
                                token=$(cat ~/git/config.txt)
                                #  start a review
                                if [ "$reviewNumber" != "" ]
                                then
                                    # start review
                                    response=$(curl -X POST https://api.github.com/repos/$repo/pulls/$reviewNumber/reviews -u "$token")
                                    (xdg-open https://github.com/$repo/pull/$reviewNumber & )
                                    exit
                                fi;;
        -ap  | --approve-pull ) pullNumber=$2
                                content=$3
                                token=$(cat ~/git/config.txt)
                                #  submit a comment
                                reviewId=$(curl -s -X POST https://api.github.com/repos/$repo/pulls/$pullNumber/reviews -u "$token" | jq -r '.id')
                                echo https://api.github.com/repos/$repo/pulls/$pullNumber/reviews/$reviewId/events/ 
                                curl -X POST https://api.github.com/repos/$repo/pulls/$pullNumber/reviews/$reviewId/events -u "$token" --data "{\"body\":\"$content\", \"event\":\"APPROVE\"}"
                                exit;;
        -rp  | --reject-pull )  pullNumber=$2
                                content=$3
                                token=$(cat ~/git/config.txt)
                                #  submit a comment
                                reviewId=$(curl -s -X POST https://api.github.com/repos/$repo/pulls/$pullNumber/reviews -u "$token" | jq -r '.id')
                                echo https://api.github.com/repos/$repo/pulls/$pullNumber/reviews/$reviewId/events/ 
                                curl -X POST https://api.github.com/repos/$repo/pulls/$pullNumber/reviews/$reviewId/events -u "$token" --data "{\"body\":\"$content\", \"event\":\"REQUEST_CHANGES\"}"
                                exit;;
        -ni  | --new-issue )    title=$2
                                body=$3
                                token=$(cat ~/git/config.txt)
                                curl -X POST https://api.github.com/repos/$repo/issues?state=all/ -u "$token" --data "{\"title\":\"$title\", \"body\":\"$body\"}"
                                exit;;
        -c  | --comment )      number=$2
                                content=$3
                                token=$(cat ~/git/config.txt)
                                #  submit a comment
                                curl -X POST https://api.github.com/repos/$repo/issues/$number/comments?state=all/ -u "$token" -d "{\"body\":\"$content\"}"
                                exit;;
        -a  | --assign ) number=$2
                                assignee=$3
                                token=$(cat ~/git/config.txt)
                                curl -X POST https://api.github.com/repos/$repo/issues/$number/assignees?state=all/ -u "$token" -d "{\"assignees\":\"$assignee\"}"
                                exit;;
        -l  | --label )         number=$2
                                label=$3
                                token=$(cat ~/git/config.txt)
                                curl -X POST https://api.github.com/repos/$repo/issues/$number/labels?state=all/ -u "$token" -d "{\"labels\":[\"$label\"]}"
                                exit;;
        -rl  | --remove-label ) number=$2
                                label=$3
                                token=$(cat ~/git/config.txt)
                                curl -X DELETE https://api.github.com/repos/$repo/issues/$number/labels?state=all/$label -u "$token"
                                exit;;
        -cl  | --close       )  number=$2
                                token=$(cat ~/git/config.txt)
                                curl -X POST https://api.github.com/repos/$repo/issues/$number?state=all -u "$token" -d "{\"state\":\"closed\"}"
                                exit;;
        -s   | --sync )         git checkout master
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
    esac
    shift
done


