# Clock
To add clock and custom message to your terminal, please add this to your ~/.zshrc file 
```bash
setopt PROMPT_SUBST
PROMPT="$PROMPT %B%F{green}Hello there, Have a nice day! %B%F{yellow}[%D{%L:%M:%S}] %f%b"
TMOUT=1

TRAPALRM() {
    zle reset-prompt
}

```
