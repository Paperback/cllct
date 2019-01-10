artists/archive:
	wget --random-wait https://web.archive.org/web/20121001062703/http://cllct.com:80/artists/alphabetical -P artists/archive
	wget --random-wait https://web.archive.org/web/20121001062703/http://cllct.com:80/artists/alphabetical?page=1 -P artists/archive
	wget --random-wait https://web.archive.org/web/20121001062703/http://cllct.com:80/artists/alphabetical?page=2 -P artists/archive
	wget --random-wait https://web.archive.org/web/20121001062703/http://cllct.com:80/artists/alphabetical?page=3 -P artists/archive
	wget --random-wait https://web.archive.org/web/20121001062703/http://cllct.com:80/artists/alphabetical?page=4 -P artists/archive
	wget --random-wait https://web.archive.org/web/20121001062703/http://cllct.com:80/artists/alphabetical?page=5 -P artists/archive
	wget --random-wait https://web.archive.org/web/20121001062703/http://cllct.com:80/artists/alphabetical?page=6 -P artists/archive
	wget --random-wait https://web.archive.org/web/20121001062703/http://cllct.com:80/artists/alphabetical?page=7 -P artists/archive
	wget --random-wait https://web.archive.org/web/20121001062703/http://cllct.com:80/artists/alphabetical?page=8 -P artists/archive
	wget --random-wait https://web.archive.org/web/20121001062703/http://cllct.com:80/artists/alphabetical?page=9 -P artists/archive
	wget --random-wait https://web.archive.org/web/20121001062703/http://cllct.com:80/artists/alphabetical?page=10 -P artists/archive
	wget --random-wait https://web.archive.org/web/20121001062703/http://cllct.com:80/artists/alphabetical?page=11 -P artists/archive
	wget --random-wait https://web.archive.org/web/20121001062703/http://cllct.com:80/artists/alphabetical?page=12 -P artists/archive
	wget --random-wait https://web.archive.org/web/20121001062703/http://cllct.com:80/artists/alphabetical?page=13 -P artists/archive
	wget --random-wait https://web.archive.org/web/20121001062703/http://cllct.com:80/artists/alphabetical?page=14 -P artists/archive
	wget --random-wait https://web.archive.org/web/20121001062703/http://cllct.com:80/artists/alphabetical?page=15 -P artists/archive
	wget --random-wait https://web.archive.org/web/20121001062703/http://cllct.com:80/artists/alphabetical?page=16 -P artists/archive
	wget --random-wait https://web.archive.org/web/20121001062703/http://cllct.com:80/artists/alphabetical?page=17 -P artists/archive
	wget --random-wait https://web.archive.org/web/20121001062703/http://cllct.com:80/artists/alphabetical?page=18 -P artists/archive

artists.csv: artists/archive
	cat artists/archive/alphabetic* | grep 'artistsalphabetical' | grep -ohE '<a href="(.*)">(.*)</a>' > artists.csv
	sed -i.bak -e 's/<a href="//g' artists.csv
	sed -i.bak -e 's/">/	/g' artists.csv
	sed -i.bak -e 's/<\/a>//g' artists.csv
	rm artists.csv.bak

.PHONY:
clean:
	rm -rf artists
	rm artists.csv

releases/archive:
	cat artists.csv| cut -d$'\t' -f1 | while read line; do wget --random-wait https://web.archive.org/web/$line -P releases/archive; done

releases.csv: releases/archive
	# v=echo $$a | sed -e 's/releases\/archive\///g';
	sed -i.bak '/view-item-discography/!d' releases/archive/*
	rm releases/archive/*.bak
	find releases/archive -type f -empty -delete
	cd releases && ./extract
