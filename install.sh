#!/bin/zsh
#
# song-grab installer
#

set -e

echo "================================"
echo "  song-grab installer"
echo "================================"
echo ""

# Check if running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    echo "Error: This script only works on macOS."
    exit 1
fi

# Add Homebrew to PATH for Apple Silicon Macs (in case it's not loaded yet)
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Check for Homebrew - if missing, tell user to install it first
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed."
    echo ""
    echo "Please install Homebrew first by running this command:"
    echo ""
    echo '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    echo ""
    echo "That will ask for your Mac password (nothing shows when you type - that's normal)."
    echo ""
    echo "IMPORTANT: After Homebrew installs, CLOSE Terminal and open it again,"
    echo "then run the song-grab installer again."
    exit 1
fi

echo "✓ Homebrew found."

# Install yt-dlp
if ! command -v yt-dlp &> /dev/null; then
    echo "Installing yt-dlp..."
    brew install yt-dlp
else
    echo "✓ yt-dlp already installed."
fi

# Install ffmpeg
if ! command -v ffmpeg &> /dev/null; then
    echo "Installing ffmpeg..."
    brew install ffmpeg
else
    echo "✓ ffmpeg already installed."
fi

# Install Python shazamio package
echo "Installing Python dependencies..."
# Use brew's python to ensure consistency
if command -v pip3 &> /dev/null; then
    pip3 install shazamio 2>/dev/null || pip3 install --user shazamio 2>/dev/null || {
        echo "Warning: Could not install shazamio via pip3, trying brew python..."
        brew install python3
        pip3 install shazamio
    }
else
    brew install python3
    pip3 install shazamio
fi
echo "✓ Python dependencies installed."

# Create Scripts directory
SCRIPTS_DIR="$HOME/Scripts"
mkdir -p "$SCRIPTS_DIR"

# Download the script
echo "Downloading song-grab..."
curl -fsSL "https://raw.githubusercontent.com/samuelcodinggod/song-grab/master/song-grab" -o "$SCRIPTS_DIR/song-grab"
chmod +x "$SCRIPTS_DIR/song-grab"

# Add Scripts to PATH if not already there
SHELL_RC="$HOME/.zshrc"
if [[ -f "$HOME/.bashrc" ]] && [[ ! -f "$HOME/.zshrc" ]]; then
    SHELL_RC="$HOME/.bashrc"
fi

# Ensure shell config file exists
touch "$SHELL_RC"

# Add Homebrew to PATH for Apple Silicon (if not already there)
if [[ -f "/opt/homebrew/bin/brew" ]] && ! grep -q 'opt/homebrew' "$SHELL_RC" 2>/dev/null; then
    echo "" >> "$SHELL_RC"
    echo '# Homebrew (added by song-grab installer)' >> "$SHELL_RC"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$SHELL_RC"
fi

# Add Scripts to PATH
if ! grep -q 'Scripts' "$SHELL_RC" 2>/dev/null; then
    echo "" >> "$SHELL_RC"
    echo '# Added by song-grab installer' >> "$SHELL_RC"
    echo 'export PATH="$HOME/Scripts:$PATH"' >> "$SHELL_RC"
fi
echo "✓ Shell configured."

# Set default output directory (no interactive prompt - doesn't work when piped)
OUTPUT_DIR="$HOME/Music/SongGrab"

# Create config directory and save setting
mkdir -p "$HOME/.config/song-grab"
echo "$OUTPUT_DIR" > "$HOME/.config/song-grab/config"

# Create the output directory
mkdir -p "$OUTPUT_DIR"

# Verify installation
echo ""
echo "Verifying installation..."
export PATH="$HOME/Scripts:$PATH"

INSTALL_OK=true

if [[ ! -x "$SCRIPTS_DIR/song-grab" ]]; then
    echo "✗ song-grab script not found"
    INSTALL_OK=false
else
    echo "✓ song-grab installed"
fi

if ! command -v yt-dlp &> /dev/null; then
    echo "✗ yt-dlp not working"
    INSTALL_OK=false
else
    echo "✓ yt-dlp working"
fi

if ! command -v ffmpeg &> /dev/null; then
    echo "✗ ffmpeg not working"
    INSTALL_OK=false
else
    echo "✓ ffmpeg working"
fi

if ! python3 -c "import shazamio" 2>/dev/null; then
    echo "✗ shazamio not working (song identification may fail)"
else
    echo "✓ shazamio working"
fi

echo ""
if [[ "$INSTALL_OK" == true ]]; then
    echo "================================"
    echo "  Installation complete!"
    echo "================================"
else
    echo "================================"
    echo "  Installation had issues"
    echo "================================"
    echo ""
    echo "Some components may not have installed correctly."
    echo "Try closing Terminal, opening a new one, and running"
    echo "the installer again."
fi
echo ""
echo "Songs will be saved to: $OUTPUT_DIR"
echo ""
echo "To start using song-grab:"
echo "  1. CLOSE this Terminal window"
echo "  2. Open a NEW Terminal window"
echo "  3. Run: song-grab \"https://www.tiktok.com/...\""
echo ""
