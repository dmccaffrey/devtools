shell_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "
# git@github.com:dmccaffrey/devtools.git
for f in ${shell_dir}/*_functions.sh; do source $f; done
enable_git_functions
enable_json_functions
# git@github.com:dmccaffrey/devtools.git
" >> ~/.zshrc