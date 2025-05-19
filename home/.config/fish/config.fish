# Disable greeting
set fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Google Cloud SDK PATH setup
if test -f "$HOME/google-cloud-sdk/path.fish.inc"
    source "$HOME/google-cloud-sdk/path.fish.inc"
end

if test -f "$HOME/google-cloud-sdk/completion.bash.inc"
  bass source "$HOME/google-cloud-sdk/completion.bash.inc"
end

theme_gruvbox dark hard

set -gx EDITOR "nvim"
set -gx MANPAGER 'nvim +Man!'

if test (uname -m) = "arm64"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
end
