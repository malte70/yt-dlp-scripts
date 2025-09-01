#!/usr/bin/env bash
# 
# Menu-driven TUI for yt-music-album-download.sh
# using dialog(1)
# 



cd "$(dirname $0)"
[ -f ".env" ] \
	&& source ".env"



DIALOG_CANCEL=1
DIALOG_ESC=255

DIALOG_BACKTITLE="malte70/yt-dlp-scripts"
DIALOG_TITLE="YTMusic Album Download"

DIALOG_TEXT=" 
Please enter the URL of the album you want to download from YouTube Music:
 "
DIALOG_DEFAULT=""
#DIALOG_DEFAULT="https://music.youtube.com/playlist?list=OLAK5uy_lNoKkOR_PUCqlvE-9wT8ZcczwCXS3XLqo"
#DIALOG_DEFAULT="https://music.youtube.com/playlist?list=OLAK5uy_l0DBT09ziY3SCYFw_-mdOYjz1FlSS2WXM"



# 
# Ask for the URL
# 
#	--backtitle "${DIALOG_BACKTITLE}" \
url=$(dialog \
	--title "${DIALOG_TITLE}" \
	--inputbox \
		"$DIALOG_TEXT" \
		11 100 \
		"${DIALOG_DEFAULT}" \
	3>&1 \
	1>&2 \
	2>&3)
dialog_ret=$?
clear



# 
# Ask for confirmation before starting the download
# 
if [[ $dialog_ret -eq 0 && "$url" != "" ]]; then
	dialog \
		--title "${DIALOG_TITLE}" \
		--yesno "Start download now?
Destination:
$MUSIC_DIR" 8 45
	dialog_ret=$?
	
	
	
	# 
	# Start download and pipe output to dialog's progressbox
	# 
	if [[ $dialog_ret -eq 0 ]]; then
		(
			./yt-music-album-download.sh "$url"
		) 2>&1 \
			| dialog \
				--title "${DIALOG_TITLE}" \
				--progressbox 30 96
				#--progressbox 32 96
	else
		# Maybe add to a download queue file?
		:
	fi
fi

if [[ $dialog_ret -eq $DIALOG_CANCEL || $dialog_ret -eq $DIALOG_ESC ]]; then
	# Aborted using the button (1) or the escape key (255)
	echo "WARNING: Aborted by user." >&2
fi


