#!/bin/sh
usage()
{
    echo " gittool
        -b  | --base [account/repo name]
        -d  | --done [your commit message]: commit and push to origin
        -r  | --review [pull request number] [APPROVE|REQUEST_CHANGES]
        -c  | --comment [pull request number] [comment message]
        -h | --help : print usage
    "
}
while [ "$1" != "" ]; do
    case $1 in
        -b  | --base )          base=$2;;
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

if [ "$base" = "" ]
then
    echo "Please set your repo with format  account/repo_name"
    echo "eg: gittool -b thanhnguyennguyen/lazy"
    exit
fi
git remote set-url origin git@github.com:$base.git

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