# Based on the work of fabulous work of Arialdo Martini
# https://github.com/arialdomartini/oh-my-git/
#
# This derivative fork is taken from my pull request on his project here : https://github.com/arialdomartini/oh-my-git/pull/22
#
# ABSTRACT
# ========
#
# This new git information script (`oh-my-git.plugin.zsh`)
#    * is not rely on a prompt shell anymore
#    * is using configurable color codes
#    * doesn't leak variables
#    * does not depend on external configuration
#    * offers configurable color codes per symbol
#    * has a more understandable name, that can be easily used in another context (I'm using it in my own crafted oh-my-zsh theme, though it's named `oh-my-git.plugin.zsh`)
#    * offers suffix and prefix config
#    * enables toggling of the display of the git repository symbol (`display_git_symbol`)
#    * enables to toggle if empty spaces for _off_ flags will be displayed (`use_color_off=false` and flag is off, toggable with `print_unactive_flags_space`)
#    * enables toggling per git repository config `git config --get oh-my-zsh.hide-status`
#    * displays current git action (`REBASE-i`, `REBASE-m`, `REBASE`, `AM/REBASE`, `MERGING`, `BISECTING`, `CHERRY-PICKING`)
#

source "${ZSH_CUSTOM}/plugins/oh-my-git/oh-my-git-variables.zsh"

function make_superscript() {
  declare -A SUPERSCRIPT
  SUPERSCRIPT["0"]="⁰"
  SUPERSCRIPT["1"]="¹"
  SUPERSCRIPT["2"]="²"
  SUPERSCRIPT["3"]="³"
  SUPERSCRIPT["4"]="⁴"
  SUPERSCRIPT["5"]="⁵"
  SUPERSCRIPT["6"]="⁶"
  SUPERSCRIPT["7"]="⁷"
  SUPERSCRIPT["8"]="⁸"
  SUPERSCRIPT["9"]="⁹"

  local input_string="$1"

  local output_string=""
  if [[ $input_string =~ [0-9]\+ ]]; then
    local number_digits="${#input_string}"
    for iii in {1..${number_digits}}; do
      output_string+="${SUPERSCRIPT["$input_string[$iii]"]}"
    done
  fi
  echo "$output_string"
}

function make_subscript() {
  declare -A SUBSCRIPT
  SUBSCRIPT["0"]="₀"
  SUBSCRIPT["1"]="₁"
  SUBSCRIPT["2"]="₂"
  SUBSCRIPT["3"]="₃"
  SUBSCRIPT["4"]="₄"
  SUBSCRIPT["5"]="₅"
  SUBSCRIPT["6"]="₆"
  SUBSCRIPT["7"]="₇"
  SUBSCRIPT["8"]="₈"
  SUBSCRIPT["9"]="₉"

  local input_string="$1"

  local output_string=""
  if [[ $input_string =~ [0-9]\+ ]]; then
    local number_digits="${#input_string}"
    for iii in {1..${number_digits}}; do
      output_string+="${SUBSCRIPT["$input_string[$iii]"]}"
    done
  fi
  echo "$output_string"
}

function mirror_encapsulation() {
  local encapsulation_opening="$1"
  if [[ ${encapsulation_opening} == "(" ]]; then
    echo ")"
  elif [[ ${encapsulation_opening} == "[" ]]; then
    echo "]"
  elif [[ ${encapsulation_opening} == "{" ]]; then
    echo "}"
  else
   echo "$encapsulation_opening"
  fi
}


function oh_my_git_info {
  typeset -gA oh_my_git_statuses
  oh_my_git_statuses["is_a_git_repo"]=false
  oh_my_git_statuses["is_hosted_in_github"]=false
  oh_my_git_statuses["detached"]=false
  oh_my_git_statuses["not_detached"]=false
  oh_my_git_statuses["current_branch"]=""
  oh_my_git_statuses["current_commit_hash"]=""
  oh_my_git_statuses["short_sha"]=""
  oh_my_git_statuses["is_clean"]=false
  oh_my_git_statuses["has_modifications"]=false
  oh_my_git_statuses["has_modifications_cached"]=false
  oh_my_git_statuses["has_untracked_files"]=false
  oh_my_git_statuses["has_adds"]=false
  oh_my_git_statuses["has_deletions"]=false
  oh_my_git_statuses["has_deletions_cached"]=false
  oh_my_git_statuses["ready_to_commit"]=false
  oh_my_git_statuses["has_diverged"]=false
  oh_my_git_statuses["can_fast_forward"]=false
  oh_my_git_statuses["should_push"]=false
  oh_my_git_statuses["commits_ahead"]=false
  oh_my_git_statuses["number_of_commits_ahead"]=0
  oh_my_git_statuses["commits_behind"]=false
  oh_my_git_statuses["number_of_commits_behind"]=0
  oh_my_git_statuses["rebase_tracking_branch"]=false
  oh_my_git_statuses["merge_tracking_branch"]=false
  oh_my_git_statuses["has_tag"]=false
  oh_my_git_statuses["tag_name"]=""
  oh_my_git_statuses["has_stashes"]=false
  oh_my_git_statuses["number_of_stashes"]=0
  oh_my_git_statuses["has_upstream"]=false
  oh_my_git_statuses["upstream"]=""
  oh_my_git_statuses["short_upstream"]=""
  oh_my_git_statuses["git_action"]=""

  # Early return if git repo is configured to be hidden
  if [[ "$(git config --get oh-my-zsh.hide-status)" == "1" ]]; then
    return
  fi
  # if [[ "$(git config --get oh-my-git.enabled)" != "true" ]]; then return; fi

  # Git info
  oh_my_git_statuses["current_commit_hash"]=$(git rev-parse HEAD 2> /dev/null)
  if [[ -n ${oh_my_git_statuses["current_commit_hash"]} ]]; then
    oh_my_git_statuses["is_a_git_repo"]=true
  fi

  if [[ ${oh_my_git_statuses["is_a_git_repo"]} == true ]]; then
    oh_my_git_statuses["short_sha"]=${oh_my_git_statuses["current_commit_hash"]:0:7}

    oh_my_git_statuses["current_branch"]=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [[ ${oh_my_git_statuses["current_branch"]} == 'HEAD' ]]; then
      oh_my_git_statuses["detached"]=true
    else
      oh_my_git_statuses["not_detached"]=true
    fi

    local number_of_logs=$(git log --pretty=oneline -n1 2> /dev/null | wc -l | tr -d ' ')
    local just_init=false
    if [[ $number_of_logs -eq 0 ]]; then
      just_init=true
    fi

    if [[ ${just_init} == false ]]; then
      local remote_hosts="$(git remote -v 2> /dev/null | grep "github")"
      if [[ -n ${remote_hosts} ]]; then
        oh_my_git_statuses["is_hosted_in_github"]=true
      fi

      oh_my_git_statuses["upstream"]=$(git rev-parse --symbolic-full-name --abbrev-ref @{upstream} 2> /dev/null)
      oh_my_git_statuses["short_upstream"]="${oh_my_git_statuses["upstream"]//\/$oh_my_git_statuses["current_branch"]/}"
      if [[ -n "${oh_my_git_statuses["upstream"]}" && "${oh_my_git_statuses["upstream"]}" != "@{upstream}" ]]; then
        oh_my_git_statuses["has_upstream"]=true
      fi

      local git_status="$(git status --porcelain 2> /dev/null)"

      if [[ -z $git_status ]]; then
        oh_my_git_statuses["is_clean"]=true
      fi

      if [[ $git_status =~ ($'\n'|^).M ]]; then
        oh_my_git_statuses["has_modifications"]=true
      fi

      if [[ $git_status =~ ($'\n'|^)M ]]; then
        oh_my_git_statuses["has_modifications_cached"]=true
      fi

      if [[ $git_status =~ ($'\n'|^)A ]]; then
        oh_my_git_statuses["has_adds"]=true
      fi

      if [[ $git_status =~ ($'\n'|^).D ]]; then
        oh_my_git_statuses["has_deletions"]=true
      fi

      if [[ $git_status =~ ($'\n'|^)D ]]; then
        oh_my_git_statuses["has_deletions_cached"]=true
      fi

      if [[ $git_status =~ ($'\n'|^)[MAD] && ! $git_status =~ ($'\n'|^).[MAD\?] ]]; then
        oh_my_git_statuses["ready_to_commit"]=true
      fi

      local number_of_untracked_files=`echo $git_status | grep -c "^??"`
      if [[ $number_of_untracked_files -gt 0 ]]; then
        oh_my_git_statuses["has_untracked_files"]=true
      fi

      oh_my_git_statuses["tag_name"]=$(git describe --exact-match --tags ${oh_my_git_statuses["current_commit_hash"]} 2> /dev/null)
      if [[ -n ${oh_my_git_statuses["tag_name"]} ]]; then
        oh_my_git_statuses["has_tag"]=true
      fi

      if [[ ${oh_my_git_statuses["has_upstream"]} == true ]]; then
        local commits_diff="$(git log --pretty=oneline --topo-order --left-right ${oh_my_git_statuses["current_commit_hash"]}...${oh_my_git_statuses["upstream"]} 2> /dev/null)"
        oh_my_git_statuses["number_of_commits_ahead"]=$(grep -c "^<" <<< "$commits_diff")
        oh_my_git_statuses["number_of_commits_behind"]=$(grep -c "^>" <<< "$commits_diff")

        if [[ ${oh_my_git_statuses["number_of_commits_behind"]} -gt 0 ]]; then
          oh_my_git_statuses["commits_behind"]=true
        fi

        if [[ ${oh_my_git_statuses["number_of_commits_ahead"]} -gt 0 ]]; then
          oh_my_git_statuses["commits_ahead"]=true
          oh_my_git_statuses["should_push"]=true
        fi

        if [[ ${oh_my_git_statuses["number_of_commits_ahead"]} -gt 0 && ${oh_my_git_statuses["number_of_commits_behind"]} -gt 0 ]]; then
          oh_my_git_statuses["has_diverged"]=true
        fi

        if [[ ${oh_my_git_statuses["number_of_commits_ahead"]} -eq 0 && ${oh_my_git_statuses["number_of_commits_behind"]} -gt 0 ]]; then
          oh_my_git_statuses["can_fast_forward"]=true
        fi
      fi

      if [[ ${oh_my_git_statuses["detached"]} == false ]]; then
        oh_my_git_statuses["rebase_tracking_branch"]=$(git config --get branch.${oh_my_git_statuses["current_branch"]}.rebase 2> /dev/null)
        if [[ -z ${oh_my_git_statuses["rebase_tracking_branch"]} ]]; then
          oh_my_git_statuses["merge_tracking_branch"]=true
        fi
      fi

      oh_my_git_statuses["number_of_stashes"]="$(git stash list 2>/dev/null | grep '^stash@{[0-9]\+}:' | wc -l)"
      if [[ ${oh_my_git_statuses["number_of_stashes"]} -gt 0 ]]; then
        oh_my_git_statuses["has_stashes"]=true
      fi
    fi
    oh_my_git_statuses["git_action"]="$(git_current_action)"
  fi
  # For clarity, all the engine status should be calculated above this line.

  # Start Display
  local oh_my_git_string=""
  if [[ ${oh_my_git_statuses["is_a_git_repo"]} == true ]]; then
    declare -A encapsulations_met
    local num_elements_to_display="${#ZSH_THEME_GIT_DISPLAY_ORDER[@]}"
    for ii in {0..$((num_elements_to_display-1))}; do
      local display="${ZSH_THEME_GIT_DISPLAY_ORDER[$ii]}"
      if [[ -n "$display" ]]; then
        local linked_display="${ZSH_THEME_GIT_LINKS["$display"]}"
        local symbol_display="${ZSH_THEME_GIT_SYMBOLS["$display"]}"
        local color_display="${ZSH_THEME_GIT_COLORS["$display"]}"
        local off_display="${ZSH_THEME_GIT_OFF_STATUS["$display"]}"

        if [[ -n "${symbol_display}" ]]; then
          if [[ $display =~ [a-z_]\+encapsulation ]]; then
            if [[ -z "${encapsulations_met["$display"]}" || "${encapsulations_met["$display"]}" == false ]]; then
              encapsulations_met["$display"]=true
              oh_my_git_string+="$(echo_if_true "${oh_my_git_statuses["${linked_display}"]}" "${symbol_display}" "${color_display}" "${off_display}")"
            elif [[ "${encapsulations_met["$display"]}" == true ]]; then
              encapsulations_met["$display"]=false
              oh_my_git_string+="$(echo_if_true "${oh_my_git_statuses["${linked_display}"]}" "$(mirror_encapsulation "${symbol_display}")" "${color_display}" "${off_display}")"
            fi
          else
            oh_my_git_string+="$(echo_if_true "${oh_my_git_statuses["$display"]}" "${symbol_display}" "${color_display}" "${off_display}")"
          fi
        elif [[ -n "${linked_display}" ]]; then
          local displayed_item="${oh_my_git_statuses["$display"]}"
          if [[ -n "${ZSH_THEME_GIT_MOVE_NUMBERS["$display"]}" ]]; then
            if [[ ${ZSH_THEME_GIT_MOVE_NUMBERS["$display"]} == "super" ]]; then
              displayed_item="$(make_superscript $displayed_item)"
            elif [[ ${ZSH_THEME_GIT_MOVE_NUMBERS["$display"]} == "sub" ]]; then
              displayed_item="$(make_subscript $displayed_item)"
            fi
          fi
          oh_my_git_string+="$(echo_if_true "${oh_my_git_statuses["${linked_display}"]}" "${displayed_item}" "${color_display}" "${off_display}")"
        fi
      fi
    done
  fi

  # collapse contiguous spaces including new lines
  echo $(echo "${oh_my_git_string}")
}

# based on bash __git_ps1 to read branch and current action
function git_current_action() {
  local info="$(git rev-parse --git-dir 2>/dev/null)"
  if [ -n "$info" ]; then
    local action
    if [ -f "$info/rebase-merge/interactive" ]
      then
      action=${is_rebasing_interactively:-"REBASE-i"}
    elif [ -d "$info/rebase-merge" ]
      then
      action=${is_rebasing_merge:-"REBASE-m"}
    else
      if [ -d "$info/rebase-apply" ]
        then
        if [ -f "$info/rebase-apply/rebasing" ]
          then
          action=${is_rebasing:-"REBASE"}
        elif [ -f "$info/rebase-apply/applying" ]
          then
          action=${is_applying_mailbox_patches:-"|AM"}
        else
          action=${is_rebasing_mailbox_patches:-"AM/REBASE"}
        fi
      elif [ -f "$info/MERGE_HEAD" ]
        then
        action=${is_merging:-"MERGING"}
      elif [ -f "$info/CHERRY_PICK_HEAD" ]
        then
        action=${is_cherry_picking:-"CHERRY-PICKING"}
      elif [ -f "$info/BISECT_LOG" ]
        then
        action=${is_bisecting:-"BISECTING"}
      fi
    fi

    if [[ -n $action ]]; then
      echo "$action"
    fi
  fi
}


function echo_if_true {
  flag=$1
  symbol=$2
  coloron=$3
  off_flag=$4

  if [ -n "$ZSH_VERSION" ]; then
    local reset_color="${omg_reset:-%{%f%k%b%}}"
    local off="${omg_off:-%b}";
  else
    local reset_color="${omg_reset:-\[\e[0m\]}"
    local off="${omg_off:-\[\e[1;30m\]}";
  fi

  if [[ ${flag} == "0" || ${flag} = "" ]]; then
    flag=false
  elif [[ ${flag} != true && ${flag} != false ]]; then
    flag=true
  fi

  if [[ ${flag} == true ]]; then
    echo "${coloron}${symbol}${reset_color}"
  elif [[ ${off_flag} == "color_off" ]]; then
    echo "${off}${symbol}${reset_color}"
  elif [[ ${off_flag} == "space" ]]; then
    symbol=" "
    echo "${coloron}${symbol}${reset_color}"
  else
    return
  fi
}

