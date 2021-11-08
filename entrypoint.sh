#!/bin/sh

#rosolve target repo
#if not input repo, use name from subtree path
if [ -z "$INPUT_REPO" ];then
  INPUT_REPO=${GITHUB_ACTOR}\/`basename "$INPUT_PATH"`
  echo target repo:"$INPUT_REPO"
fi

if [ "$INPUT_FORCE" == "true" ]; then
	PUSH_ARGS="-f"
fi

if [ "$INPUT_BRANCH" == "" ]; then
	if [ -z "$GITHUB_REF_NAME" ] || [ "$GITHUB_REF_NAME" == "" ]; then
		INPUT_BRANCH="master"
	else
		INPUT_BRANCH="$GITHUB_REF_NAME"
	fi
fi

# Create the subtree split branch in pwd directory
git subtree split --prefix="${INPUT_PATH}" -b split

git config --global init.defaultBranch $INPUT_BRANCH
git init split
cd split
git config --global user.email "gitbot@github.com"
git config --global user.name "$GITHUB_ACTOR"
git pull ../ split
git remote add split "https://${GITHUB_ACTOR}:${INPUT_REPO_TOKEN}@github.com/${INPUT_REPO}.git"
git pull split $INPUT_BRANCH --allow-unrelated-histories
git lfs pull split $INPUT_BRANCH
#push to subtree repo
git push ${PUSH_ARGS} split $INPUT_BRANCH
echo sync success
