#!/bin/bash
# Written by Simon de Kraa <simon@technorabilia.com>

echo "Model: $(dmidecode -s system-product-name)"
echo "Melding non-Synology memory module: Ja/Nee"
echo

dmidecode -t 16 -q | while read line; do
	if [ "$line" = "Physical Memory Array" ]; then
		echo "[table border=1 cellpadding=2 bordercolor=#000000]]"
		collate=true
		continue
	fi

	if [ "$line" = "" ]; then
		echo "[tr]"$th"[/tr]"
		echo "[tr]"$td"[/tr]"
		echo "[/table]"
		collate=
		th=
		td=
	fi

	if [ $collate ]; then
		key=$(echo $line | cut -d ":" -f 1 | xargs)
		value=$(echo $line | cut -d ":" -f 2 | xargs)

		th=$th"[th]"$key"[/th]"
		td=$td"[td]"$value"[/td]"
	fi
done

first=true
echo "[table border=1 cellpadding=2 bordercolor=#000000]]"
dmidecode -t 17 -q | while read line; do
	if [ "$line" = "Memory Device" ]; then
		if [ $first ]; then
			header=true
			first=
		fi
		collate=true
		continue
	fi

	if echo $line | grep -q "Serial Number"; then
		continue
	fi

	if echo $line | grep -q "Asset Tag"; then
		continue
	fi

	if [ "$line" = "" ]; then
		if [ $header ]; then
			echo "[tr]"$th"[/tr]"
			header=
		fi
		echo "[tr]"$td"[/tr]"
		collate=
		th=
		td=
	fi

	if [ $collate ]; then
		key=$(echo $line | cut -d ":" -f 1 | xargs)
		value=$(echo $line | cut -d ":" -f 2 | xargs)

		if echo $key | grep -q "Part Number"; then
			value="$value
				[url="https://www.google.com/search?q=$value"][small](Google)[/small][/url]
				[url="https://tweakers.net/pricewatch/zoeken/?keyword=$value"][small](Pricewatch)[/small][/url]"
		fi

		th=$th"[th]"$key"[/th]"
		td=$td"[td]"$value"[/td]"
	fi
done
echo "[/table]"
