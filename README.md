# song-grab

Grab songs from TikTok and Instagram Reels. Identifies the song, finds it on YouTube, and downloads the MP3.

## Install (Mac)

Open Terminal (press Cmd + Space, type "Terminal", hit Enter) and follow these steps:

### Step 1: Install Homebrew (if you don't have it)

Paste this and press Enter:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

It will ask for your Mac password. **When you type your password, nothing will appear on screen** - that's normal, just type it and press Enter.

If it says "Homebrew is already installed", you can skip to Step 2.

### Step 2: Install song-grab

Paste this and press Enter:

```
curl -fsSL https://raw.githubusercontent.com/samuelcodinggod/song-grab/master/install.sh | zsh
```

Wait for it to finish, then **close Terminal and open it again**.

## Usage

```
song-grab "https://www.tiktok.com/@user/video/123456"
```

or

```
song-grab "https://www.instagram.com/reel/ABC123/"
```

Songs are saved to your Music folder (in a SongGrab subfolder).

## Update

To get the latest version:

```
song-grab --update
```
