# Config
configuration files for various things:
- bashrc: bash config 
- zshrc: zshell config
- minttyrc: bash for windows
- vimrc: simple VIM config
- bash_aliases: commandline aliases
- tmux.conf: Tmux config for easy window hopping


## 1. Git config:
Git lg From https://coderwall.com/p/euwpig/a-better-git-log:


```bash
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
```

## 2. Z for easy folder hopping
Install "z.sh" by copying the file somewhere in home and add it to the bashrc:

```bash
. ~/z.sh
```

## 3. Programming font
I like the [hack font](https://github.com/source-foundry/Hack) for programming because of the clear distinction of `lIi|` and `oO0Q`.

![alt text](img/hack_font.png)

Configure VSCode (`Ctrl + ,`):

![alt text](img/vscode_code_font_change.png)


## 4. Setting up a pretty bash terminal
Change the bashrc to whatever is in there. Pay special attention to the section of code below. It will make the terminal look similar to the one in the zsh section, without the zsh + theme install.

<img width="273" height="64" alt="image" src="https://github.com/user-attachments/assets/a3434cb5-75ec-4a30-9368-6811e6213647" />

```bash
PROMPT_DIRTRIM=3

git_prompt() {
    local branch dirty=""

    git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return

    branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) ||
        branch=$(git rev-parse --short HEAD 2>/dev/null)

    # Only tracked/staged changes; ignore untracked files
    if ! git diff --quiet --ignore-submodules -- 2>/dev/null ||
       ! git diff --cached --quiet --ignore-submodules -- 2>/dev/null; then
        dirty="*"
    fi

    if [ -n "$dirty" ]; then
        printf ' \e[38;5;244mgit:\e[38;5;214m%s\e[38;5;196m*\e[0m' "$branch"
    else
        printf ' \e[38;5;244mgit:\e[38;5;214m%s\e[0m' "$branch"
    fi
}

if [ "$color_prompt" = yes ]; then
    PS1='\[\033[38;5;45m\]╭─\[\033[0m\]\[\033[97m\][\[\033[38;5;39m\]${CONDA_DEFAULT_ENV:-base}\[\033[97m\]]\[\033[0m\] \[\033[01;32m\]\u@\h\[\033[0m\] \[\033[38;5;244m\]in\[\033[0m\] \[\033[01;34m\]\w\[\033[0m\]$(git_prompt)\n\[\033[38;5;45m\]╰─❯\[\033[0m\] '
else
    PS1='╭─[${CONDA_DEFAULT_ENV:-base}] \u@\h in \w$(git_prompt)\n╰─❯ '
fi
```




## 5. Setting up a pretty zsh terminal

Like this:
*Screenshot:*
![alt text](img/terminal_screenshot.png)

### 0. Install zshell first:
```bash
sudo apt-get install zsh
```

### 1. Install [oh-my-zsh](https://ohmyz.sh/#install):
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```


### 2. Setting up the theme:
Place the zshell theme here: `$ZSH_CUSTOM/themes/`:
```bash
cp bas.zsh-theme $ZSH_CUSTOM/themes/
```

It shows in one glance: 

- which conda env
- git branch and if there are changes in the repo
- colorful ls
- New commands on a different line


### 3. Install ruby & colorls

```bash
# Requirement for later:
sudo apt-get install libyaml-dev

#Make environment folder
# (OPTIONAL: If disk space is an issue, make the folder somewhere else and symlink it)
mkdir ~/.rbenv

# Install ruby
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
~/.rbenv/bin/rbenv init
rbenv install 3.4.5
```

Install `colorls`:
```
gem install --user-install colorls
```

**NOTE:** `ls` is aliased in the bash_aliases file (`alias ls='colorls'`). To unset: `unalias ls` (or change the config).

### 4. Install a font
To get the pretty icons in `colorls` we need to install a special font. To access settings in VSCode: "`Ctrl + ,`"

![alt text](img/vscode_font_change.png)

I got this font from here: [https://github.com/romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#meslo-nerd-font-patched-for-powerlevel10k)

You will need to install all four:
- MesloLGS NF Regular.ttf
- MesloLGS NF Bold.ttf
- MesloLGS NF Italic.ttf
- MesloLGS NF Bold Italic.ttf




