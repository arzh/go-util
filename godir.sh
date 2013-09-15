#!/bin/bash
# Helper script for making a go workspace

function usage
{
	echo ""
	echo "godir: used for creating Go workspaces"
	echo "--------------------------------------"
	echo "usage:"
	echo "  godir <workspace name> [-git <remote>]"
	echo ""
	echo "<workspace name>: name of root folder name for the workspace [required]"
	echo ""
	echo "--git | -g : initilize a git repository"
	echo "    remote: git remote to set 'origin' to"
	echo ""
}

workspace=
initGit=0
gitRemote=


if [ "$1" = "" -o "$1" = "-h" -o "$1" = "--help" ]; then
	usage
	exit 1
else
	workspace=$1
fi

while [ "$2" != "" ]; do
	case $2 in
		-g | --git ) 	initGit=1
				shift
				gitRemote=$2	
	esac

	shift
done

if [ -e $workspace ]; then
	echo "error: workspace path already exist"
	exit 1
fi	

mkdir $workspace/bin -p
mkdir $workspace/pkg -p
mkdir $workspace/src -p

cd $workspace

if [ "$initGit" == 1 ]; then
	#echo "git init"
	git init
	#echo "init finished"
	#echo "remote name:"
	#echo $gitRemote

	if [ "$gitRemote" != "" ]; then
		git remote add origin https://$gitRemote/$workspace.git
	fi
fi

#echo $GOPATH
exportStr="export GOPATH="$PWD":\$GOPATH"
#echo $exportStr
echo $exportStr >> ~/.bashrc 
#echo $GOPATH

exit 0
