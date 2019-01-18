#!/bin/sh
usage()
{
    echo " gittool
        -b  | --base [repo url eg: gittool -b git@github.com:thanhnguyennguyen/lazy.git]
        -d  | --done [your commit message]: commit and push to origin
        -r  | --review [pull request number]
        -cp | --comment [pull request number] [comment message]: comment on a pull request
        -ni | --new-issue [title] [content]: create new issue
        -ci | --comment-issue [issue number] [content]: comment on an issue
        -cl | --close-issue [issue number] : close an issue
        -ai | --assign-issue [issue number] [assignee]: assign an issue to an assignee
        -s  | --sync : sync fork repo with upstream
        -h  | --help : print usage
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
        -cp  | --comment )      pullNumber=$2
                                content=$3
                                token=$(cat ~/git/config.txt)
                                #  submit a comment
                                reviewId=$(curl -s -X POST https://api.github.com/repos/$repo/pulls/$pullNumber/reviews -u "$token" | jq -r '.id')
                                echo https://api.github.com/repos/$repo/pulls/$pullNumber/reviews/$reviewId/events/ 
                                curl -X POST https://api.github.com/repos/$repo/pulls/$pullNumber/reviews/$reviewId/events -u "$token" --data "{\"body\":\"$content\", \"event\":\"COMMENT\"}"
                                exit;;
        -ni  | --new-issue )    title=$2
                                body=$3
                                token=$(cat ~/git/config.txt)
                                curl -X POST https://api.github.com/repos/$repo/issues?state=all/ -u "$token" --data "{\"title\":\"$title\", \"body\":\"$body\"}"
                                exit;;
        -ci  | --comment )      number=$2
                                content=$3
                                token=$(cat ~/git/config.txt)
                                #  submit a comment
                                curl -X POST https://api.github.com/repos/$repo/issues/$number/comments?state=all/ -u "$token" -d "{\"body\":\"$content\"}"
                                exit;;
        -ai  | --assign-issue ) number=$2
                                assignee=$3
                                token=$(cat ~/git/config.txt)
                                curl -X POST https://api.github.com/repos/$repo/issues/$number/assignees?state=all/ -u "$token" -d "{\"assignees\":\"$assignee\"}"
                                exit;;
        -cl  | --close-issue )  number=$2
                                token=$(cat ~/git/config.txt)
                                curl -X POST https://api.github.com/repos/$repo/issues/$number?state=all -u "$token" -d "{\"state\":\"closed\"}"
                                exit;;
        -s   | --sync )         git checkout master
                                git fetch upstream
                                git pull upstream master
                                git push orign master -f
                                exit;;
        -h  | --help )          usage
                                exit
                                ;;
    esac
    shift
done


