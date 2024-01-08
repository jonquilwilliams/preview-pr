#!/bin/bash
#
# This script loads a HTML preview of a book to the aap-builds repo
#
# To operate this script, run the following command from the /titles directory in your AAP docs repo:
# preview-pr.sh <PR-number>
#
# Example command:
# preview-pr 801
#
###########################################################
#
aapbuildsurl=https://ariordan-redhat.github.io/aap-builds
aapbuildspath=/Users/ariordan/repos/aap-builds
sourcebranch=$(git symbolic-ref --short HEAD)
sourcepath=$(pwd)
sourcedir=$(basename $sourcepath)
sourcefile=$(ls -d -1 $sourcepath/master.html)
builddate=$(date -I)
### branch=($1)
targetfile=$(echo "$sourcedir-$sourcebranch-$builddate.html")
targetpath=$(echo "$aapbuildspath/docs/$targetfile")
targetreadme=$(echo "$aapbuildspath/README.md")
targeturl=$(echo "$aapbuildsurl/$targetfile")
commitmessage=$(echo "$targeturl")
echo "The aap-builds repo is located here: $aapbuildspath"
echo "Path to directory is $sourcepath"
echo "Directory name is $sourcedir"
echo "Date is $builddate"
echo "targetfile is $targetfile"
echo "targetpath is $targetpath"
echo "Commit message is $commitmessage"
echo "sourcefile is $sourcefile"
echo "Target URL is $targeturl"
echo "###"

# Copy the built doc to your local aap-builds repo
cp master.html $targetpath
ls -t $targetpath

pushd $aapbuildspath
echo "$targeturl" >> $targetreadme
git status
git add $targetpath
git add $targetreadme
git status
git commit -m "$commitmessage"
git log --oneline -n 2
git push origin HEAD
popd
# List all master.adoc files
# clean up temporary files
## rm tmp.docx
## rm atree-output.docx
## rm used-modules.docx
## rm all-modules.docx
# rm *.bak
