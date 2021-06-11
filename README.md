# getlsioapp.sh

Get LinuxServer.io application docker-compose configuration.

![](https://github.com/technorabilia/scripts/blob/main/images/getlsioapp.gif)

Usage:

```
getlsioapp.sh netbootxyz
```

or:

```
curl -sL https://git.io/JZarS | sh -s netbootxyz
```

You can also specify a different BASEDIR:

```
BASEDIR=/volume2/docker getlsioapp.sh netbootxyz
```

or:

```
curl -sL https://git.io/JZarS | BASEDIR=/volume2/docker sh -s netbootxyz
```

Example output:

```
$ getlsioapp.sh netbootxyz
The following directories and files have been created:
   /volume1/docker/docker-env.cfg
   /volume1/docker/netbootxyz
   /volume1/docker/netbootxyz/docker-compose.yaml
   /volume1/docker/netbootxyz/assets
   /volume1/docker/netbootxyz/config
   /volume1/docker/netbootxyz/.env

Application setup:
1. Review the global settings in /volume1/docker/docker-env.cfg:
   #BASEDIR=/volume1/docker
   #PUID=1024
   #PGID=100
   #TZ=Europe/Amsterdam
2. Review /volume1/docker/netbootxyz/docker-compose.yaml
3. Create and start the application with:
   $ cd /volume1/docker/netbootxyz
   $ sudo docker-compose up -d
4. Stop and remove the application with:
   $ cd /volume1/docker/netbootxyz
   $ sudo docker-compose down
$
```

# synomeminfo.sh

Synology memory device information in RML.

Usage:

```
synomeminfo.sh
```

or:

```
curl -sL https://git.io/JZa4a | sh
```

Example output:

```
$ synomeminfo.sh
Model: DS716+
Melding non-Synology memory module: Ja/Nee

[table border=1 cellpadding=2 bordercolor=#000000]]
[tr][th]Location[/th][th]Use[/th][th]Error Correction Type[/th][th]Maximum Capacity[/th][th]Number Of Devices[/th][/tr]
[tr][td]System Board Or Motherboard[/td][td]System Memory[/td][td]None[/td][td]8 GB[/td][td]2[/td][/tr]
[/table]
[table border=1 cellpadding=2 bordercolor=#000000]]
[tr][th]Total Width[/th][th]Data Width[/th][th]Size[/th][th]Form Factor[/th][th]Set[/th][th]Locator[/th][th]Bank Locator[/th][th]Type[/th][th]Type Detail[/th][th]Speed[/th][th]Manufacturer[/th][th]Part Number[/th][th]Rank[/th][th]Configured Memory Speed[/th][th]Minimum Voltage[/th][th]Maximum Voltage[/th][th]Configured Voltage[/th][/tr]
[tr][td]8 bits[/td][td]8 bits[/td][td]8192 MB[/td][td]SODIMM[/td][td]None[/td][td]ChannelA-DIMM0[/td][td]BANK 0[/td][td]DDR3[/td][td]Synchronous[/td][td]1600 MT/s[/td][td]1315[/td][td]CT102464BF160B.C16 [url=https://www.google.com/search?q=CT102464BF160B.C16][small](Google)[/small][/url] [url=https://tweakers.net/pricewatch/zoeken/?keyword=CT102464BF160B.C16][small](Pricewatch)[/small][/url][/td][td]Unknown[/td][td]1600 MT/s[/td][td]1.35 V[/td][td]1.5 V[/td][td]Unknown[/td][/tr]
[/table]
$
```
