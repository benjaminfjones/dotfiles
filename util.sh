#
# Utility functions, meant to be source'd
#

# print error message $1 and exit 1
fail ()
{
  echo "ERROR: $1" >&2
  exit 1
}

# same as `fail` but doesn't exit, allowing you to specify your own exit code
errmsg ()
{
  echo "ERROR: $1" >&2
}

# "resolve_prog $file" attempts to resolve $file as an executable
# and returns full path to it.
# XXX something about res=$(which...) line doesn't work
resolve_prog ()
{
  local file=$1
  local dir=${file%/*}
  local res=""
  # if $file does not contain a directory, search path.
  if [ "$dir" == "$file" ]; then
    res=$(which $file || echo)
    if [ -z $res ]; then
      errmsg "Could not find $file in path."
      return 1
    fi
  elif [ -z $dir ]; then
    # file is in root directory.
    res=$file
  else
    # Build absolute path.
    res="$(cd $dir; pwd)/${file##*/}"
  fi
  if [ ! -f $res ]; then
    errmsg "Could not find $file."
    return 1
  fi
  if [ ! -x $res ]; then
    errmsg "$file is not executable."
    return 1
  fi
  echo "$res"
}

# clone a repo into the HOME directory
# $1 = dir to clone to under $HOME
# $2 = git repo url
clone_home () {
    # GIT=$(resolve_prog ${GIT:-"git"})
    pushd $HOME > /dev/null
    if [ -d $HOME/.$1 ]; then
        echo "Pulling $1..."
        pushd $HOME/.$1 > /dev/null
        git pull
        popd > /dev/null
    else
        echo "Cloning $1..."
        git clone $2 $HOME/.$1
    fi
    popd > /dev/null
}

