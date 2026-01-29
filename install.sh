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
    echo "After Homebrew is installed, run the song-grab installer again."
    exit 1
fi

echo "Homebrew found."

# Add Homebrew to PATH for Apple Silicon Macs (in case it's not loaded)
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install yt-dlp
if ! command -v yt-dlp &> /dev/null; then
    echo "Installing yt-dlp..."
    brew install yt-dlp
else
    echo "yt-dlp already installed."
fi

# Install ffmpeg
if ! command -v ffmpeg &> /dev/null; then
    echo "Installing ffmpeg..."
    brew install ffmpeg
else
    echo "ffmpeg already installed."
fi

# Install Python shazamio package
echo "Installing Python dependencies..."
pip3 install --user shazamio 2>/dev/null || pip install --user shazamio

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

if ! grep -q 'Scripts' "$SHELL_RC" 2>/dev/null; then
    echo "" >> "$SHELL_RC"
    echo '# Added by song-grab installer' >> "$SHELL_RC"
    echo 'export PATH="$HOME/Scripts:$PATH"' >> "$SHELL_RC"
fi

# Set default output directory (no interactive prompt - doesn't work when piped)
OUTPUT_DIR="$HOME/Music/SongGrab"

# Create config directory and save setting
mkdir -p "$HOME/.config/song-grab"
echo "$OUTPUT_DIR" > "$HOME/.config/song-grab/config"

# Create the output directory
mkdir -p "$OUTPUT_DIR"

echo ""
echo "================================"
echo "  Installation complete!"
echo "================================"
echo ""
echo "Songs will be saved to: $OUTPUT_DIR"
echo ""
echo "To start using song-grab, either:"
echo "  1. Open a new Terminal window, OR"
echo "  2. Run: source ~/.zshrc"
echo ""
echo "Then grab a song with:"
echo '  song-grab "https://www.tiktok.com/..."'
echo ""
