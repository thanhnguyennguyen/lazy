#!/bin/sh
usage()
{
    echo " gittool
        -b  | --base [repo url eg: gittool -b git@github.com:thanhnguyennguyen/lazy.git]
        -d  | --done [your commit message]: commit and push to origin
        -r  | --review [pull request number]
        -cp  | --comment [pull request number] [comment message]: comment on a pull request
        -h | --help : print usage
    "
}

base=$(git config --get remote.origin.url)
if [ "$base" = "" ]
then
    echo "Please set your remote repo"
    echo "eg: gittool -b git@github.com:thanhnguyennguyen/lazy.git"
    exit
fi

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
                                    exit
                                fi;;
        -r  | --review )        reviewNumber=$2
                                token=$(cat config.txt)
                                #  start a review
                                if [ "$reviewNumber" != "" ]
                                then
                                    # start review
                                    response=$(curl -X POST https://api.github.com/repos/$base/pulls/$reviewNumber/reviews -u "$token")
                                    (xdg-open https://github.com/$base/pull/$reviewNumber & )
                                    exit
                                fi;;
        -cp  | --comment )      commentNumber=$2
                                content=$3
                                token=$(cat config.txt)
                                #  submit a comment
                                if [ "$reviewNumber" != "" ]
                                then
                                    # start review
                                    response=$(curl -X POST https://api.github.com/repos/$base/pulls/$reviewNumber/reviews -u "$token")
                                    reviewId=response.id
                                    curl -X POST https://api.github.com/repos/$base/pulls/$reviewNumber/reviews/$reviewId/events/ -u "$token" --data "{\"body\":\"$content\", \"event\":\"COMMENT\"}"
                                    exit
                                fi;;
        -h  | --help )           usage
                                exit
                                ;;
    esac
    shift
done


