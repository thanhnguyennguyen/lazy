#!/bin/sh
usage()
{
    echo " gittool
        -b  | --base [repo url eg: gittool -b git@github.com:thanhnguyennguyen/lazy.git]
        -d  | --done [your commit message]: commit and push to origin
        -r  | --review [pull request number] [APPROVE|REQUEST_CHANGES]
        -c  | --comment [pull request number] [comment message]
        -h | --help : print usage
    "
}
while [ "$1" != "" ]; do
    case $1 in
        -b  | --base )          base=$2
                                git remote set-url origin $base;;
        -d  | --done )          commit=$2;;
        -r  | --review )        reviewNumber=$2;;
        -c  | --comment )       commentNumber=$2
                                comment=$3;;
        -h | --help )           usage
                                exit
                                ;;
    esac
    shift
done

base=$(git config --get remote.origin.url)
if [ "$base" = "" ]
then
    echo "Please set your remote repo"
    echo "eg: gittool -b git@github.com:thanhnguyennguyen/lazy.git"
    exit
fi


# commit code and push
if [ "$commit" != "" ]
then
    git commit -m "$commit"
    git push origin
    exit
fi

token=$(cat config.txt)
#  review
if [ "$reviewNumber" != "" ]
then
    # start review
    response=$(curl -X POST https://api.github.com/repos/$base/pulls/$reviewNumber/reviews -u "$token")
    (xdg-open https://github.com/$base/pull/$reviewNumber & )
    exit
fi