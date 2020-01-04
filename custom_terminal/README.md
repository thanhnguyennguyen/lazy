# Customize your terminal to make your working space more interesting
#### Clock in terminal
To add clock and custom message to your terminal, please add this to your `~/.bashrc` ( `~/.zshrc` file if you use zsh)
```bash
setopt PROMPT_SUBST
PROMPT="$PROMPT %B%F{green}Hello there, Have a nice day! %B%F{yellow}[%D{%L:%M:%S}] %f%b"
TMOUT=1

TRAPALRM() {
    zle reset-prompt
}

```
![image](https://user-images.githubusercontent.com/17243442/71717905-32a09b80-2e4c-11ea-86a3-636ae5e91990.png)


#### Custom messages
To add custom message, add the following lines to ~/.zshrc
```bash
messages=("Hello there, Have a nice day!" "Never give up" "Enjoy music for a nice day" "Sleep on your passion" "Buy Bitcoin" "Buy TOMO" "How are you today ?" )

rand=$(($RANDOM % ${#messages[@]}))
selectedMessage=${messages[$rand]}
PROMPT="$PROMPT $selectedMessage"
```
