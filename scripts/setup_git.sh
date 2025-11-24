#!/usr/bin/env bash
set -e

echo ">>> Configuring Git..."
read -p "Enter your name: " name
read -p "Enter your email: " email
read -p "Enter your company: " company
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
git config --global delta.pager "less -+X -+F"
git config --global alias.tree "log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"
git config --global core.editor "nvim"
git config --global init.defaultBranch main
git config --global pull.rebase false

echo ">>> Git setup complete!"
