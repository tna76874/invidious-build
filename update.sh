#!/bin/bash
function pull_latest() {
cd "$1"
branchcount=$(git for-each-ref --format='%(refname:short)' refs/heads/* | grep main | wc -l)
if [[ "$branchcount" == "1" ]]; then
    git checkout main > /dev/null 2>&1
    echo "Checkout $1 on main. Pulling latest changes."
else
    git checkout master > /dev/null 2>&1 
    echo "Checkout $1 on master. Pulling latest changes."
fi
git pull > /dev/null 2>&1
git show-branch
}
export -f pull_latest

git submodule update --init --recursive
git submodule update --recursive --remote

git submodule foreach -q 'echo $sm_path' | xargs -i bash -c 'pull_latest {}'