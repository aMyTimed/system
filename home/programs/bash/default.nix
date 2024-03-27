{ config, pkgs, ... }:

{

  programs.bash = {
    enable = true;
    enableCompletion = true;

    bashrcExtra = ''
    # get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "''${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[''${BRANCH}''${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo

function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "''${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "''${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "''${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "''${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "''${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "''${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=""
	if [ "''${renamed}" == "0" ]; then
		bits=">''${bits}"
	fi
	if [ "''${ahead}" == "0" ]; then
		bits="*''${bits}"
	fi
	if [ "''${newfile}" == "0" ]; then
		bits="+''${bits}"
	fi
	if [ "''${untracked}" == "0" ]; then
		bits="?''${bits}"
	fi
	if [ "''${deleted}" == "0" ]; then
		bits="x''${bits}"
	fi
	if [ "''${dirty}" == "0" ]; then
		bits="!''${bits}"
	fi
	if [ ! "''${bits}" == "" ]; then
		echo " ''${bits}"
	else
		echo ""
	fi
}

      export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
      export PS1="\033[38;2;48;131;255m\033[1m[\u@somewhere:\w`parse_git_branch`]\$ \033[0m";
    '';

    shellAliases = {
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
      code = "codium $@"; # muscle memory
    };
  };

}