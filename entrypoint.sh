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
	if [ -z "$GITHUB_REF" ] || [ "$GITHUB_REF" == "" ]; then
		INPUT_BRANCH="master"
	else
		INPUT_BRANCH="$GITHUB_REF_NAME"
	fi
fi

# Create the subtree split branch in pwd directory
git subtree split --prefix="${INPUT_PATH}" -b split
git checkout split
git fetch --all
git lfs fetch --all
git remote add split "https://${INPUT_REPO_TOKEN}@github.com/${INPUT_REPO}"
#push to subtree repo
git push ${PUSH_ARGS} split master
echo sync success
