# =========================================================
# Prompt (Starship)
# =========================================================

# Prevent Python virtualenv from polluting the prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Prevent deep function nesting warnings
FUNCNEST=100

# Initialize Starship prompt
eval "$(starship init zsh)"
