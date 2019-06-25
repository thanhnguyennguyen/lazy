# Customize your terminal to make your working space more interesting
#### Clock in terminal
To add clock and custom message to your terminal, please add this to your ~/.zshrc file 
```bash
setopt PROMPT_SUBST
PROMPT="$PROMPT %B%F{green}Hello there, Have a nice day! %B%F{yellow}[%D{%L:%M:%S}] %f%b"
TMOUT=1

TRAPALRM() {
    zle reset-prompt
}

```

#### Custom messages
To add custom message, add the following lines to ~/.zshrc
```bash
messages=("Hello there, Have a nice day!" "Never give up" "Enjoy music for a nice day" "Sleep on your passion" "Buy Bitcoin" "Buy TOMO" "How are you today ?" )

rand=$(($RANDOM % ${#messages[@]}))
selectedMessage=${messages[$rand]}
PROMPT="$PROMPT $selectedMessage"
```
