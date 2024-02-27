#!/bin/bash
#
# This script loads a HTML preview of a book to the aap-builds repo
# 
# PREREQUISITE 1: Create an aap-builds repo in your github instance.
# You can fork Aine's copy from https://github.com/ariordan-redhat/aap-builds if you like,
# then clone your fork using the following command:
# git clone https://github.com/<your_github_id>/aap-builds
#
# PREREQUISITE 2:
# Modify the aapbuildsurl and aapbuildspath in the script - these are labelled PREREQUISITE.
# 
# PREREQUISITE 3:
# Build a doc using asciidoctor. 
# that you have added the images to your aap-builds repo if you need them.
#
# To operate this script, run the following command from the downstream/titles/title-name directory
# in your AAP docs repo (for example, downstream/titles/aap-installation-guide):
# preview-pr.sh
#
# Example command:
# preview-pr
#
# The script copies master.html 
#
###########################################################
#
# PREREQUISITE: Configure the URL for your aap-builds repo
aapbuildsurl=https://ariordan-redhat.github.io/aap-builds
# PREREQUISITE: Configure the path to your local copy of aap-builds repo
aapbuildspath=/Users/ariordan/repos/aap-builds
#
sourcebranch=$(git symbolic-ref --short HEAD)
sourcepath=$(pwd)
sourcedir=$(basename $sourcepath)
sourcefile=$(ls -d -1 $sourcepath/master.html)
builddate=$(date -I)
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
echo "* $targeturl" >> $targetreadme
git status
git add $targetpath
git add $targetreadme
git status
git commit -m "$commitmessage"
git log --oneline -n 2
git push origin HEAD
popd

