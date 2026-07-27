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

Songs are saved to your Music folder (in a SongGrab subfolder). To change that,
put the folder path in `~/.config/song-grab/config`.

Each run saves **two files**: the real recording (`Title.mp3`) and the backing
track (`Title (instrumental).mp3`).

### Sped up / slowed / remix versions

If the reel played an edit of the track, that's what you get — the picker reads
the cut off the identified title and chases it. To force one when the song is
identified by its plain name:

```
song-grab --sped-up "<url>"
song-grab --variant "slowed reverb" "<url>"
```

Shorthands: `--sped-up --slowed --nightcore --remix --live --acoustic --extended`.

## Update

To get the latest version:

```
song-grab --update
```
