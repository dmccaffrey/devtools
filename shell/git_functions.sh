main_branch="main"
user_prefix="dmcc"

# Example workflow:
#   branch task-xyz 
#   <make changes>
#   append
#   <make changes>
#   append
#   rebase
#   amend <describe changes>
#   pub

function enable_git_functions() {
    echo "Enabling git functions"

    function fixup() {
        git commit --no-verify -a --fixup HEAD
    }

    function squash() {
        git rebase --no-verify -i --autosquash origin/${main_branch}
    }

    function rebase() {
        git fetch && git rebase --no-verify -i origin/${main_branch}
    }

    function amend() {
        git commit --no-verify --amend
    }

    function pub() {
        git push -f
    }

    function append() {
        fixup && squash
    }

    function branch() {
        git_reset_master
        git_branch "$1" "$2"
    }

    function git_branch() {
        task="${1:-scratch}"
        if [[ `git_branch_exists ${task}` ]]; then
            echo "Branch already exists"
            return 1
        fi
        git checkout -b "${user_prefix}/${task}"
        git commit --no-verify --allow-empty -m "${task} - $2"
        git push -u origin "dmcc/${task}"
    }
    
    function git_reset() {
        resetmaster && git clean -d force
    }

    function git_branch_exists() {
        task=$1
        git rev-parse --quiet --verify "${user_prefix}/${task}"
    }

    function git_reset_master() {
        git_is_dirty && git stash
        git fetch
        git checkout ${main_branch}
        git reset --hard origin/${main_branch}
    }

    function git_prune() {
    git remote prune origin
    git branch --merged | grep dmcc/ | xargs git branch -d
    }

    function git_task() {
        branch=$(git branch --show-current)
        task=${branch#dmcc/}
        echo ${task}
    }

    function git_is_dirty() {
        ! (git diff-index --quiet --cached HEAD -- && git diff-files --quiet)
    }

}