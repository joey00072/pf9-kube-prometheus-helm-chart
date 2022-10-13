echo PACKAGE_NAME: $PACKAGE_NAME
echo REPO_NAME: $REPO_NAME
echo GITHUB_TOKEN: $GITHUB_TOKEN
echo OWNER: $OWNER

git checkout master

echo packaging helm repo 
helm package ./charts/$PACKAGE_NAME --destination .deploy

echo uploading release 
cr upload -o $OWNER -r $REPO_NAME -p .deploy -t $GITHUB_TOKEN 

echo updating index
git checkout gh-pages
cr index -i ./index.yaml -p .deploy --owner $OWNER --git-repo $REPO_NAME

git push origin gh-pages
