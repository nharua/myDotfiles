#!/usr/bin/env bash
set -e

echo ">>> Configuring Git..."
if [ -t 0 ]; then
    read -p "Enter your name: " name
    read -p "Enter your email: " email
    read -p "Enter your company: " company
else
    echo ">>> Non-interactive terminal detected. Skipping prompts and using default test values."
    name="CI Tester"
    email="ci@test.com"
    company="CI Corp"
fi
git config --global user.name "$name"
git config --global user.email "$email"
git config --global user.company "$company"
git config --global merge.tool meld
git config --global mergetool.prompt false
git config --global diff.tool meld
git config --global mergetool.keepBackup false
git config --global core.autocrlf false
git config --global core.eol lf
git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.side-by-side true
git config --global delta.pager "less -RFX"
git config --global alias.tree "log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"
git config --global core.editor "nvim"
git config --global init.defaultBranch main
git config --global pull.rebase false

echo ">>> Git setup complete!"
