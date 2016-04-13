oh-my-zsh-git
=============

This plugin is an opinionated git prompt status, tailored for [**oh-my-zsh**](https://github.com/robbyrussell/oh-my-zsh). It is based on the [fabulous work](https://github.com/arialdomartini/oh-my-git/) of Arialdo Martini, but has been completely rewritten to avoid shortcoming and enable more features and especially a nice oh-my-zsh integration.

In other word it is _oh_my_git_ for _oh_my_zsh_.

This derivative fork is taken from my pull request on his project [there](https://github.com/arialdomartini/oh-my-git/pull/22).

## Reading the abstract

This new git information script (`oh-my-zsh-git.plugin.zsh`) has a few bullet points:

  * Show more information than usual git prompt status function here and there, thanks to Arialdo Martini for that
  * Configurable color and symbols (or string)
  * Configurable suffix and prefix
  * Toggleable per git repository (`git config --get oh-my-zsh.hide-status`)
  * Toggleable git repository symbol (`display_git_symbol`)
  * Git _off_ flags (like content in stash or untracked files) can be either displayed or not (`use_color_off`) Toggleable empty spaces when git flag is on or off  (`print_unactive_flags_space`)
  * Git _off_ flags can be ommited in the status (with both `use_color_off=false` and `print_unactive_flags_space=false`)
  * Showing current git action (`REBASE-i`, `REBASE-m`, `REBASE`, `AM/REBASE`, `MERGING`, `BISECTING`, `CHERRY-PICKING`)
  * External configuration is optional, defaults are already configured

On a technical ground:

  * The shell script file and function are more human compatible. And this layout is directly working with oh-my-zsh plugins layout.
  * While designed with oh-my-zsh in mind it is does not depend on a specific shell
  * Leaks customizable variables only, organized in associative arrays. 


## Install the git prompt status

This install assume the current shell is **ZSH** with [**oh-my-zsh**](https://github.com/robbyrussell/oh-my-zsh) already installed.

Install a clone of this repository in oh-my-zsh plugin [custom folder](https://github.com/robbyrussell/oh-my-zsh/wiki/Customization). *Note it is possible to change the default custom directory of oh-my-zsh by redefining the `$ZSH_CUSTOM` in the `.zshrc` *

```bash
mkdir -p $ZSH_CUSTOM/plugins
git clone git@github.com:bric3/oh-my-git-4-oh-my-zsh.git $ZSH_CUSTOM/plugins/oh-my-git
```

This will make _oh-my-git_ available as a plugin for _oh-my-zsh_. Now you still need to activate it. In your `.zshrc` just activate the plugin by adding `oh-my-git` to the `plugins` variable :

```bash
plugins=(
 # custom plugins
 git2
 oh-my-git

 # bundled plugins
 github
 osx
 mosh
 ...
```

Finally use the main function of the plugin `oh_my_git_info` in the variables in your theme `PROMPT` or `RPROMPT`. For example to place it in the right part of your theme use the `RPROMPT` environment variable : 

```bash
RPROMPT='$(oh_my_git_info)'
```


## Customize it

In order to customize either the symbol, the color or if some symbol should be displayed define on of these variable in your oh-my-zsh theme.

For example in your theme set the following variables to have a prompt info that will look like : `[(master origin)]`

```bash
# oh-my-git config
omg_prefix=" %{%B%F{green}%}[%{%f%k%b%}"
omg_suffix="%{%B%F{green}%}]%{%f%k%b%}"

display_git_symbol=false
display_git_current_action=left
print_unactive_flags_space=false
```

Here is the possible variables and flags with their default value

## Options
Most of the parameters used to display the git status info are exported to the
shell environment. In order to be trully customizable, while not polluting the
environment with variables, a set of associative arrays are used.
More specifically, the following arrays are used:

`ZSH_THEME_GIT_SYMBOLS`
For each variable, contains the symbol or string to be displayed if the
condition described by the variable stands.
`ZSH_THEME_GIT_COLORS`
For each variable, contains the color of the symbol to be displayed.
`ZSH_THEME_GIT_DISPLAY_ORDER`
An ordered list showing the order in which the git status variables will appear.
`ZSH_THEME_GIT_LINKS`
Link to the variable describing the condition which must hold in order for the
linking variable to appear in the prompt.
`ZSH_THEME_GIT_MOVE_NUMBERS`
Describes whether a numeric variable will appear in normal, superscript or
subscript mode.
`ZSH_THEME_GIT_OFF_STATUS`
Describes how a variable whose flag is false will appear. The options include
showing a colorless variable symbol, showing a space instead of the variable or
showing nothing at all.


### Symbols

ZSH_THEME_GIT_SYMBOLS          | value
------------------------------ | ----------
is_a_git_repo                  | ` `
is_hosted_in_github            | `  `
is_clean                       | ` `
has_untracked_files            | ` `
has_adds                       | ` `
has_deletions                  | ` `
has_deletions_cached           | ` `
has_modifications              | ` `
has_modifications_cached       | ` `
ready_to_commit                | ` `
has_tag                        | ` `
has_upstream                   | `⬍ `
detached                       | ` `
can_fast_forward               | ` `
has_diverged                   | ` `
rebase_tracking_branch         | ` `
merge_tracking_branch          | ` `
should_push                    | ` `
has_stashes                    | ` `
commits_behind                 | `-`
commits_ahead                  | `+`
branch_encapsulation           | `(`
tag_encapsulation              | `[`
sha_encapsulation              | `(`
action_encapsulation           | `{`
total_encapsulation            | ``


### Default colors

For the ZSH shell, the default values are the [ZSH prompt escape sequences](http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html) which are correctly interpreted to match the terminal width.

display variable                   | value
---------------------------------- | ----------
on                                 | `%B`
off                                | `%b`
green                              | `%F{green}`
red                                | `%F{red}`
violet                             | `%F{magenta}`
yellow                             | `%F{yellow}`
reset                              | `%{%f%k%b%}`

### Colors

ZSH_THEME_GIT_COLORS               | Value
---------------------------------- | -----------
is_a_git_repo                      | `$on`
is_hosted_in_github                | `$on`
is_clean                           | `$green`
has_untracked_files                | `$red`
has_adds                           | `$yellow`
has_deletions                      | `$red`
has_deletions_cached               | `$yellow`
has_modifications                  | `$red`
has_modifications_cached           | `$yellow`
ready_to_commit                    | `$green`
has_tag                            | `$yellow`
branch_encapsulation               | `$on`
tag_encapsulation                  | `$on`
sha_encapsulation                  | `$on`
total_encapsulation                | `$on`
action_encapsulation               | `$on`
detached                           | `$red`
short_sha                          | `$on`
can_fast_forward                   | `$on`
has_diverged                       | `$red`
rebase_tracking_branch             | `$on`
merge_tracking_branch              | `$on`
should_push                        | `$on`
has_stashes                        | `$yellow`
number_of_stashes                  | `$yellow`
commits_behind                     | `$on`
number_of_commits_behind           | `$on`
commits_ahead                      | `$on`
number_of_commits_ahead            | `$on`
current_branch                     | `$green`
tag_name                           | `$yellow`
short_upstream                     | `$on`
git_action                         | `$red`

