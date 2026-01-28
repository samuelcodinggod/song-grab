# song-grab

Grab songs from TikTok and Instagram Reels. Identifies the song, finds it on YouTube, and downloads the MP3.

## Install (Mac)

Open Terminal and paste this command:

```
curl -fsSL https://raw.githubusercontent.com/samuelcodinggod/song-grab/main/install.sh | bash
```

It will ask where you want to save songs (just press Enter for the default).

## Usage

```
song-grab 'https://www.tiktok.com/@user/video/123456'
```

or

```
song-grab 'https://www.instagram.com/reel/ABC123/'
```

## What it does

1. Downloads the audio from the TikTok/Reel
2. Identifies the song using Shazam (with AudD as backup)
3. Finds the full song on YouTube
4. Downloads it as an MP3 to your music folder

## Change save location

Edit `~/.config/song-grab/config` to change where songs are saved.
