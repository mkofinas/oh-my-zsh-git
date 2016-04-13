#!/bin/zsh

create_zsh_theme_git_symbols() {
  # Colors
  if [ -n "$ZSH_VERSION" ]; then
    local on="${omg_on:-%B}";
    local off="${omg_off:-%b}";
    local red="${omg_red:-%F{red}}";
    local green="${omg_green:-%F{green}}";
    local yellow="${omg_yellow:-%F{yellow}}";
    local violet="${omg_violet:-%F{magenta}}";
  else
    local on="${omg_on:-\[\e[0;37m\]}";
    local off="${omg_off:-\[\e[1;30m\]}";
    local red="${omg_red:-\[\e[0;31m\]}";
    local green="${omg_green:-\[\e[0;32m\]}";
    local yellow="${omg_yellow:-\[\e[0;33m\]}";
    local violet="${omg_violet:-\[\e[0;35m\]}";
  fi

  ZSH_THEME_GIT_SYMBOLS["is_a_git_repo"]=" "
  ZSH_THEME_GIT_SYMBOLS["is_hosted_in_github"]="   "
  ZSH_THEME_GIT_SYMBOLS["is_clean"]=" "
  ZSH_THEME_GIT_SYMBOLS["has_untracked_files"]=" "
  ZSH_THEME_GIT_SYMBOLS["has_adds"]=" "
  ZSH_THEME_GIT_SYMBOLS["has_deletions"]=" "
  ZSH_THEME_GIT_SYMBOLS["has_deletions_cached"]=" "
  ZSH_THEME_GIT_SYMBOLS["has_modifications"]=" "
  ZSH_THEME_GIT_SYMBOLS["has_modifications_cached"]=" "
  ZSH_THEME_GIT_SYMBOLS["ready_to_commit"]=" "
  ZSH_THEME_GIT_SYMBOLS["has_tag"]=" "
  ZSH_THEME_GIT_SYMBOLS["has_upstream"]="⬍"
  ZSH_THEME_GIT_SYMBOLS["detached"]=" "
  ZSH_THEME_GIT_SYMBOLS["can_fast_forward"]=""
  ZSH_THEME_GIT_SYMBOLS["has_diverged"]=" "
  ZSH_THEME_GIT_SYMBOLS["rebase_tracking_branch"]=" "
  ZSH_THEME_GIT_SYMBOLS["merge_tracking_branch"]=" "
  ZSH_THEME_GIT_SYMBOLS["should_push"]=" "
  ZSH_THEME_GIT_SYMBOLS["has_stashes"]=" "
  ZSH_THEME_GIT_SYMBOLS["commits_behind"]="-"
  ZSH_THEME_GIT_SYMBOLS["commits_ahead"]="+"
  ZSH_THEME_GIT_SYMBOLS["branch_encapsulation"]="("
  ZSH_THEME_GIT_SYMBOLS["tag_encapsulation"]="["
  ZSH_THEME_GIT_SYMBOLS["sha_encapsulation"]="("
  ZSH_THEME_GIT_SYMBOLS["action_encapsulation"]="{"
  ZSH_THEME_GIT_SYMBOLS["total_encapsulation"]=""

  ZSH_THEME_GIT_COLORS["is_a_git_repo"]="$on"
  ZSH_THEME_GIT_COLORS["is_hosted_in_github"]="$on"
  ZSH_THEME_GIT_COLORS["is_clean"]="$green"
  ZSH_THEME_GIT_COLORS["has_untracked_files"]="$red"
  ZSH_THEME_GIT_COLORS["has_adds"]="$yellow"
  ZSH_THEME_GIT_COLORS["has_deletions"]="$red"
  ZSH_THEME_GIT_COLORS["has_deletions_cached"]="$yellow"
  ZSH_THEME_GIT_COLORS["has_modifications"]="$red"
  ZSH_THEME_GIT_COLORS["has_modifications_cached"]="$yellow"
  ZSH_THEME_GIT_COLORS["ready_to_commit"]="$green"
  ZSH_THEME_GIT_COLORS["has_tag"]="$yellow"
  ZSH_THEME_GIT_COLORS["branch_encapsulation"]="$on"
  ZSH_THEME_GIT_COLORS["tag_encapsulation"]="$on"
  ZSH_THEME_GIT_COLORS["sha_encapsulation"]="$on"
  ZSH_THEME_GIT_COLORS["total_encapsulation"]="$on"
  ZSH_THEME_GIT_COLORS["action_encapsulation"]="$on"
  ZSH_THEME_GIT_COLORS["detached"]="$red"
  ZSH_THEME_GIT_COLORS["short_sha"]="$on"
  ZSH_THEME_GIT_COLORS["can_fast_forward"]="$on"
  ZSH_THEME_GIT_COLORS["has_diverged"]="$red"
  ZSH_THEME_GIT_COLORS["rebase_tracking_branch"]="$on"
  ZSH_THEME_GIT_COLORS["merge_tracking_branch"]="$on"
  ZSH_THEME_GIT_COLORS["should_push"]="$on"
  ZSH_THEME_GIT_COLORS["has_stashes"]="$yellow"
  ZSH_THEME_GIT_COLORS["number_of_stashes"]="$yellow"
  ZSH_THEME_GIT_COLORS["commits_behind"]="$on"
  ZSH_THEME_GIT_COLORS["number_of_commits_behind"]="$on"
  ZSH_THEME_GIT_COLORS["commits_ahead"]="$on"
  ZSH_THEME_GIT_COLORS["number_of_commits_ahead"]="$on"
  ZSH_THEME_GIT_COLORS["current_branch"]="$green"
  ZSH_THEME_GIT_COLORS["tag_name"]="$yellow"
  ZSH_THEME_GIT_COLORS["short_upstream"]="$on"
  ZSH_THEME_GIT_COLORS["git_action"]="$red"

  ZSH_THEME_GIT_DISPLAY_ORDER[0]="total_encapsulation"
  ZSH_THEME_GIT_DISPLAY_ORDER[1]="is_a_git_repo"
  ZSH_THEME_GIT_DISPLAY_ORDER[2]="is_hosted_in_github"
  ZSH_THEME_GIT_DISPLAY_ORDER[3]="has_stashes"
  ZSH_THEME_GIT_DISPLAY_ORDER[4]="number_of_stashes"
  ZSH_THEME_GIT_DISPLAY_ORDER[5]="has_untracked_files"
  ZSH_THEME_GIT_DISPLAY_ORDER[6]="has_adds"
  ZSH_THEME_GIT_DISPLAY_ORDER[7]="has_deletions"
  ZSH_THEME_GIT_DISPLAY_ORDER[8]="has_deletions_cached"
  ZSH_THEME_GIT_DISPLAY_ORDER[9]="has_modifications"
  ZSH_THEME_GIT_DISPLAY_ORDER[10]="has_modifications_cached"
  ZSH_THEME_GIT_DISPLAY_ORDER[11]="ready_to_commit"
  ZSH_THEME_GIT_DISPLAY_ORDER[12]="detached"
  ZSH_THEME_GIT_DISPLAY_ORDER[13]="sha_encapsulation"
  ZSH_THEME_GIT_DISPLAY_ORDER[14]="short_sha"
  ZSH_THEME_GIT_DISPLAY_ORDER[15]="sha_encapsulation"
  ZSH_THEME_GIT_DISPLAY_ORDER[16]="commits_behind"
  ZSH_THEME_GIT_DISPLAY_ORDER[17]="number_of_commits_behind"
  ZSH_THEME_GIT_DISPLAY_ORDER[18]="has_diverged"
  ZSH_THEME_GIT_DISPLAY_ORDER[19]="can_fast_forward"
  ZSH_THEME_GIT_DISPLAY_ORDER[20]="should_push"
  ZSH_THEME_GIT_DISPLAY_ORDER[21]="commits_ahead"
  ZSH_THEME_GIT_DISPLAY_ORDER[22]="number_of_commits_ahead"
  ZSH_THEME_GIT_DISPLAY_ORDER[23]="is_clean"
  ZSH_THEME_GIT_DISPLAY_ORDER[24]="branch_encapsulation"
  ZSH_THEME_GIT_DISPLAY_ORDER[25]="current_branch"
  ZSH_THEME_GIT_DISPLAY_ORDER[26]="rebase_tracking_branch"
  ZSH_THEME_GIT_DISPLAY_ORDER[27]="merge_tracking_branch"
  ZSH_THEME_GIT_DISPLAY_ORDER[28]="short_upstream"
  ZSH_THEME_GIT_DISPLAY_ORDER[29]="branch_encapsulation"
  ZSH_THEME_GIT_DISPLAY_ORDER[30]="tag_encapsulation"
  ZSH_THEME_GIT_DISPLAY_ORDER[31]="has_tag"
  ZSH_THEME_GIT_DISPLAY_ORDER[32]="tag_name"
  ZSH_THEME_GIT_DISPLAY_ORDER[33]="tag_encapsulation"
  ZSH_THEME_GIT_DISPLAY_ORDER[34]="action_encapsulation"
  ZSH_THEME_GIT_DISPLAY_ORDER[35]="git_action"
  ZSH_THEME_GIT_DISPLAY_ORDER[36]="action_encapsulation"
  ZSH_THEME_GIT_DISPLAY_ORDER[37]="total_encapsulation"

  ZSH_THEME_GIT_LINKS["number_of_stashes"]="has_stashes"
  ZSH_THEME_GIT_LINKS["number_of_commits_ahead"]="commits_ahead"
  ZSH_THEME_GIT_LINKS["number_of_commits_behind"]="commits_behind"
  ZSH_THEME_GIT_LINKS["short_sha"]="detached"
  ZSH_THEME_GIT_LINKS["current_branch"]="not_detached"
  ZSH_THEME_GIT_LINKS["short_upstream"]="has_upstream"
  ZSH_THEME_GIT_LINKS["tag_name"]="has_tag"
  ZSH_THEME_GIT_LINKS["tag_encapsulation"]="has_tag"
  ZSH_THEME_GIT_LINKS["sha_encapsulation"]="detached"
  ZSH_THEME_GIT_LINKS["branch_encapsulation"]="not_detached"
  ZSH_THEME_GIT_LINKS["git_action"]="is_a_git_repo"
  ZSH_THEME_GIT_LINKS["action_encapsulation"]="git_action"
  ZSH_THEME_GIT_LINKS["total_encapsulation"]="is_a_git_repo"

  # Options:
  # * "super", for superscript
  # * "sub", for subscript
  # * "normal"
  ZSH_THEME_GIT_MOVE_NUMBERS["number_of_stashes"]="super"
  ZSH_THEME_GIT_MOVE_NUMBERS["number_of_commits_ahead"]="normal"
  ZSH_THEME_GIT_MOVE_NUMBERS["number_of_commits_behind"]="normal"

  # What to Display when the status flag is false
  # Options:
  # * "color_off", to display the status symbol in default color
  # * "space", to leave an empty space instead of the symbol
  # * "", to display nothing
  ZSH_THEME_GIT_OFF_STATUS["total_encapsulation"]=""
  ZSH_THEME_GIT_OFF_STATUS["is_a_git_repo"]=""
  ZSH_THEME_GIT_OFF_STATUS["is_hosted_in_github"]=""
  ZSH_THEME_GIT_OFF_STATUS["has_stashes"]=""
  ZSH_THEME_GIT_OFF_STATUS["number_of_stashes"]=""
  ZSH_THEME_GIT_OFF_STATUS["has_untracked_files"]=""
  ZSH_THEME_GIT_OFF_STATUS["has_adds"]=""
  ZSH_THEME_GIT_OFF_STATUS["has_deletions"]=""
  ZSH_THEME_GIT_OFF_STATUS["has_deletions_cached"]=""
  ZSH_THEME_GIT_OFF_STATUS["has_modifications"]=""
  ZSH_THEME_GIT_OFF_STATUS["has_modifications_cached"]=""
  ZSH_THEME_GIT_OFF_STATUS["ready_to_commit"]=""
  ZSH_THEME_GIT_OFF_STATUS["detached"]=""
  ZSH_THEME_GIT_OFF_STATUS["sha_encapsulation"]=""
  ZSH_THEME_GIT_OFF_STATUS["commits_behind"]=""
  ZSH_THEME_GIT_OFF_STATUS["number_of_commits_behind"]=""
  ZSH_THEME_GIT_OFF_STATUS["has_diverged"]=""
  ZSH_THEME_GIT_OFF_STATUS["can_fast_forward"]=""
  ZSH_THEME_GIT_OFF_STATUS["should_push"]=""
  ZSH_THEME_GIT_OFF_STATUS["commits_ahead"]=""
  ZSH_THEME_GIT_OFF_STATUS["number_of_commits_ahead"]=""
  ZSH_THEME_GIT_OFF_STATUS["is_clean"]=""
  ZSH_THEME_GIT_OFF_STATUS["branch_encapsulation"]=""
  ZSH_THEME_GIT_OFF_STATUS["rebase_tracking_branch"]=""
  ZSH_THEME_GIT_OFF_STATUS["merge_tracking_branch"]=""
  ZSH_THEME_GIT_OFF_STATUS["tag_encapsulation"]=""
  ZSH_THEME_GIT_OFF_STATUS["has_tag"]=""
  ZSH_THEME_GIT_OFF_STATUS["action_encapsulation"]=""
}
typeset -gA ZSH_THEME_GIT_SYMBOLS
typeset -gA ZSH_THEME_GIT_COLORS
typeset -gA ZSH_THEME_GIT_DISPLAY_ORDER
typeset -gA ZSH_THEME_GIT_LINKS
typeset -gA ZSH_THEME_GIT_MOVE_NUMBERS
typeset -gA ZSH_THEME_GIT_OFF_STATUS

create_zsh_theme_git_symbols
