#!/bin/bash

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Step 1: Install brew
echo "Installing brew..."
if command_exists brew; then
  echo "Brew is already installed"
else
  echo "Brew is not installed. Installing now..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if command_exists brew; then
    echo "Brew installation successful!"
    echo "Configuring Brew environment for this script session..."
    if [[ "$(uname -m)" == "arm64" ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    else
      eval "$(/usr/local/bin/brew shellenv)"
    fi
    echo "Brew environment configured"
  else
    echo "Brew installation failed. Please check the output above for errors."
    exit 1
  fi
fi

# Step 2: Install base packages from Brewfile
echo "Installing base packages from Brewfile..."
if brew bundle --file=./packages/bundle; then
  echo "Base packages install successfully"
  read -r -p "Do you want to install work-specific packages from ./packages/bundle.work? (y/N): " install_work_deps

  if [[ "$install_work_deps" =~ ^[Yy]$ ]]; then
    echo "Installing work packages..."
    if brew bundle --file=./packages/bundle.work; then
      echo "Work packages installed successfully"
    else
      echo "Failed to install work packages. Please check the output above."
      echo "Continuing installation despite work package installation issues."
    fi
  else
    echo "Skipping work package installation."
  fi
else
  echo "Failed to install base packages. Please check the output above."
  exit 1
fi

# Step 3: Stow configuration files from ./home to ~
echo "Stowing configuration files..."

if command_exists stow; then
  echo "Running stow..."
  # Stow files from ./home into the HOME directory
  # -R: Re-stow, overwriting existing links if necessary
  # -v: Verbose output
  # -d: .: Sepcifies the directory containing the package directories (stow dir)
  # -t $HOME: Specifies the target directory
  # home; The package directory within '.' to stow
  # We need to be in the parent directory of '.' for stow -d . to work correctly
  # Assuming the script is run from the root of the repo where '.' is located.
  if stow -R -v -d . -t "$HOME" home; then
    echo "Stow completed successfully"
  else
    echo "Stow command failed. Please check the output above."
    echo "Continuing installation despite stow failure."
  fi
else
  echo "Stow command not found. Skipping stow step."
  echo "Please ensure stow was installed correctly in Step 2."
fi

echo "Setting fish as the default and login shell"
if command_exists fish; then
  echo "Fish is installed"

  # Get the path to the fish binary
  fish_path=$(command -v fish)

  # Check if fish is already in /etc/shells
  if ! grep -q "$fish_path" /etc/shells; then
    echo "Adding $fish_path to /etc/shells"
    echo "$fish_path" | sudo tee -a /etc/shells
  else
    echo "Fish is already listed in /etc/shells"
  fi

 # Set fish as the default shell for the current user
  if [ "$SHELL" != "$fish_path" ]; then
    echo "Changing the default shell to fish for user $USER"
    chsh -s "$fish_path"
    echo "Default shell changed to fish. Please log out and log back in for changes to take effect."
  else
    echo "Fish is already the default shell."
  fi
else
  echo "Fish is not installed. Please install it first using your package manager."
fi

echo "Installation complete!"
exit 0
