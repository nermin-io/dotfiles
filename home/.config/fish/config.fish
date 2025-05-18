# Disable greeting
set fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Google Cloud SDK PATH setup
if test -f /Users/nerminsehic/google-cloud-sdk/path.fish.inc
    source /Users/nerminsehic/google-cloud-sdk/path.fish.inc
end

if test -f /Users/nerminsehic/google-cloud-sdk/completion.bash.inc
    bass source /Users/nerminsehic/google-cloud-sdk/completion.bash.inc
end

theme_gruvbox dark hard

set -gx EDITOR "nvim"
set -gx PAGER "nvim +Man!"
set -gx MANPAGER 'nvim +Man!'
set -gx PNPM_HOME "/Users/nerminsehic/Library/pnpm"
