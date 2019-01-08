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
        -r  | --review )        reviewNumber=$2
                                if [ $3 == "APPROVE" ]
                                then
                                    review="APPROVE"
                                else
                                    if [ $3 == "REQUEST_CHANGES" ]
                                    then
                                        review="REQUEST_CHANGES"
                                    fi
                                fi
                                reviewMessage=$4;;
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
fi

# commit code and push
if [ "$commit" != "" ]
then
    git commit -m $commit
    git push origin $base
    exit
fi

token=$(cat config.txt)
# submit review
if [ "$reviewNumber" != "" ]
then
    if [ "$review" = "" ]
    then
        echo "Review action must be APPROVE or REQUEST_CHANGES"
        exit
    fi
    # start review
    response=$(curl -u $token $base/pulls/$reviewNumber/reviews)
    id=response.id
    # submit
    curl -u $token $base/pulls/reviewNumber/reviews/$id/events/ --data "{\"body\":\"$reviewMessage\",\"event\":\"$review\"}
fi