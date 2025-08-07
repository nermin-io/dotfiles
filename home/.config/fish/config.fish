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

set -gx EDITOR "nvim"
set -gx MANPAGER 'nvim +Man!'

# Zendesk config
set -gx ZENDESK_SUBDOMAIN 'rendr'
set -gx ZENDESK_EMAIL 'nermin@rendr.delivery'
set -gx ZENDESK_API_TOKEN 'RM5pO3AaHrXDIpqv4B2t0w4tfJTnEaXWIVnpZRtd'

# Paths
fish_add_path "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"

if test (uname -m) = "arm64"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
end
