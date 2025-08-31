# Jordan's YT-DLP Script Repository - with Malte's improvements

This is just a repo for some random scripts for downloading things using yt-dlp fork of youtube-dl

## yt-music-album-download.sh

- Downloads entire albums off Youtube Music using [yt-dlp](https://github.com/yt-dlp/yt-dlp)
- Converts tracks to MP3 from the best quality audio feed
- Adds track number, artist, album, title, and release year into id3 tags (removes superfluous information)
- Adds album art as embedded thumbnails into mp3 files
- **Features added in this fork:**
  - Configuration via `.env`
  - Adjust *yt-dlp*'s output filename template (new default folder hierarchy "artist/album" instead of "artist - album")
  - Download everything to your personal music folder, instead of the current directory)

## yt-music-download-tui.sh

- Menu-driven TUI using *dialog*
- Features:
  - Ask the user for a YouTube Music URL
  - Confirmation before starting the download
  - Download the album using `yt-music-album-download.sh`
  - Display output in a *dialog --progressbox*

