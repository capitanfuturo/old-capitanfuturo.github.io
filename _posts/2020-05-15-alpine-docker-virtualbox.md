---
layout: post
title:  ":floppy_disk: Installare Alpine Linux su VirtualBox con Docker"
date:   2020-05-15 19:24:04 +0100
categories: [Software]
published: false
---
## Premessa
Da qualche mese sto imparando e mi sto formando sul mondo [Kubernates](https://kubernetes.io/) e sul modo dei container [Docker](https://www.docker.com/). Per fare pratica con questi strumenti mi sono cimentato nella configurazione ed installazione di una macchina virtuale basata su [Alpine Linux](https://alpinelinux.org/downloads/) in VirtualBox. Riporto qui degli appunti per non dimenticarmene.

## Obiettivo

Avere a disposizione una macchina virtuale leggera che permetta di sperimentare i servizi offerti dai container docker senza "sporcare" il proprio sistema operativo Windows 10.

Questa soluzione aggiunge uno strato ulteriore al motore docker ma permette di poter provare e riprovare senza fare danni. Useremo poi una connessione via ssh dal nostro terminale in modo da avere a disposizone il copia incolla ed altre facilities

## Occorrente

1. Virtualbox installato. [https://www.virtualbox.org/](https://www.virtualbox.org/)
2. Immagine .iso di Alpine Linux. Ho scelto la versione virtual che pesa solo 40 MB. [https://alpinelinux.org/downloads/](https://alpinelinux.org/downloads/)

## Configurazione iniziale

![macchina.png](/assets/2020-05-15/macchina.png)

Le impostazioni che ho scelto per la macchina virtuale sono:

* RAM: 3072 MB considerando che la mia postazione ne ha 16 GB
* HDD: 8 GB (creando subito un disco fisso virtuale)
* Tipologia: VDI Virtualbox disk image
* Allocazione dinamica
* File creato nella posizione di default

### Aggiustamenti pre-installazione

Caricare l'immagine iso scaricata di Alpine Linux nel cdrom virtuale della macchina virtuale dal menu
_Impostazioni -> Archiviazione -> scegliere l'immagine iso scaricata_

![cd_live.png](/assets/2020-05-15/cd_live.png)

## Primo avvio e installazione

1. Alla login eseguire l'accesso come utente: _root_ (non vi verrà chiesta la password)
**NB:** la tastiera è americana quindi il carattere '-' è sul tasto '?'
2. Lanciare il comando per installare Alpine Linux _setup-alpine_. Seguiranno dei passi che riporto di seguito con le scelte fatte in corsivo.
3. Se avete la tastiera italiana scegliere come keyboard layout _it_.
4. Come variante se avete una tastiera windows _it-winkeys_.
5. Come hostname ho scelto _alpine-docker_
6. Configurare l'interfaccia di rete _eth0_
7. Ip address for eth0 -> _dhcp_
8. Do you want to do any manual network configuration? -> _no_
9. Inserire la password di root -> _quella che volete_
10. Timezone -> _Europe/Rome_
11. Proxy -> nel mio caso non ho un proxy da aggiungere quindi _none_
12. NTP client -> _chrony_ come suggerito
13. Mirror -> _1_ (si può individuare un mirror italiano in seguito)
14. SSH server -> _openssh_
15. disco da usare -> _sda_
16. How would you like to use it? -> _sys_ che è la scelta consigliata per le macchine virtuali.
17. Erase the above disk -> _y_
18. al termine spegnere la macchina virtuale (non riavviare altrimenti verrà rilanciato il cdrom live)

## Configurazioni post installazione

* Andare in impostazioni della macchina virtuale e rimuovere il disco cd iso dal lettore cdrom virtuale.
* Avviare la macchina virtuale

### Abilitare i repository edge community e testing

Ottimo adesso prima di installare Docker dobbiamo abilitare alcuni repository non stable. Per farlo dobbiamo eseguire il comando:

~~~bash
vi /etc/apk/repositories
~~~

e decommentare le righe con edge/community e edge/testing. Una volta fatto aggiorniamo i repository con il comando:

~~~bash
apk update
~~~

### Installazione pacchetti aggiuntivi

Installeremo i seguenti pacchetti utili:

* nano (opzionale)
* net-tools (opzionale)
* virtualbox guest additions
* docker
* docker-compose

con il comando:

~~~bash
apk add nano virtualbox-guest-additions virtualbox-guest-modules-virt docker py-pip python-dev libffi-dev openssl-dev gcc libc-dev make net-tools
~~~

Al termine andiamo ad abilitare Docker engine all'avvio del sitema operativo con il comando:

~~~bash
rc-update add docker boot
~~~

Installiamo docker compose con il comando:

~~~bash
pip install docker-compose
~~~

Infine spegniamo la macchina virtuale

## Accesso da Windows

Il modo più semplice che ho trovato per accedere alla macchina virtuale con Docker installato sul quale far girare tutti i servizi contenerizzati è andare in VirtualBox in _Impostazioni -> Rete_ ed  aggiungere una scheda di rete "solo host" come seconda interfaccia di rete.
Questo trucco ci permetterà di accedere da Windows alla macchina virtuale utilizzando un indirizzo di rete assegnato da VirtualBox ed accessibile dal host (Windows 10 nel mio caso).
Purtroppo questa interfaccia di rete non vedrà internet, nel senso che non sarà in grado di navigare attraverso il gateway di default.

![solo_host.png](/assets/2020-05-15/solo_host.png)

Ora per ovviare a questa cosa la strategia è quella di avere la prima scheda eth0 in NAT e DHCP con la rete del host (winsows 10) e la scheda eth1 in "solo host" con un indirizzo fisso che scegliamo noi a partire da quanto è visibiel dal menu _File_ di VirtualBox, _Gestore di rete dell'Host_ come in figura. Io ho scelto di impostare l'indirizzo 192.168.56.103 dell'interfaccia eth1 (perchè il 102 l'ho impostato già per un altra macchina virtuale).

![gestione_host.png](/assets/2020-05-15/gestione_host.png)

Una volta avviata la macchina bisognerà configurare la eth1 come detto sopra con il comando:

~~~bash
nano /etc/network/interfaces
~~~bash

ed andando ad impostare il file come segue:

~~~bash
    auto lo
    iface lo inet loopback

    auto eth0
    iface eth0 inet dhcp
    hostname alpine-docker

    auto eth1
    iface eth1 inet static
        address 192.168.56.103
        netmask 255.255.255.0
~~~

Riavviare la macchina virtuale. Da adesso potrò accedere a tutti i servizi eseguiti in docker all'indirizzo 192.168.56.103:_porta del servizio_

## Permettere l'accesso dell'utenza root via ssh per PuTTY

L'ultimo passo è quello di permettere l'accesso con un client ssh dalla macchina host attraverso ssh modificando il file di configurazione:

~~~bash
vi /etc/ssh/sshd_config
~~~

e decommentare la voce PermitRootLogin ed impostarla a yes

~~~bash
PermitRootLogin yes
~~~

Riavviare il servizio:

~~~bash
service sshd restart
~~~

Ora che abbiamo l'indirizzo possiamo tranquillamente collegarci via ssh con un client come PuTTY.

## Elenco immagini docker utili

* Tutti i servizi AWS in un'unica immagine docker: [https://github.com/localstack/localstack](https://github.com/localstack/localstack)
* AWS SQS: [https://github.com/roribio/alpine-sqs](https://github.com/roribio/alpine-sqs)
* AWS Kinesis: [https://github.com/vsouza/docker-Kinesis-local](https://github.com/vsouza/docker-Kinesis-local)
* Awesome Compose. Una lista di servizi web e non solo. [https://github.com/docker/awesome-compose](https://github.com/docker/awesome-compose)
* InfluxDB + Grafana + Telegraf [https://github.com/philhawthorne/docker-influxdb-grafana](https://github.com/philhawthorne/docker-influxdb-grafana)

## Riferimenti

* [https://wiki.alpinelinux.org/wiki/Install_Alpine_on_VirtualBox](https://wiki.alpinelinux.org/wiki/Install_Alpine_on_VirtualBox)
* [https://wiki.alpinelinux.org/wiki/Installation#Installation_Handbook](https://wiki.alpinelinux.org/wiki/Installation#Installation_Handbook)
* [https://wiki.alpinelinux.org/wiki/VirtualBox_guest_additions](https://wiki.alpinelinux.org/wiki/VirtualBox_guest_additions)
* [https://wiki.alpinelinux.org/wiki/Docker](https://wiki.alpinelinux.org/wiki/Docker)
* [https://mauriziosiagri.wordpress.com/tag/permitrootlogin/](https://mauriziosiagri.wordpress.com/tag/permitrootlogin/)
* [https://gist.github.com/kennwhite/959d47a77070d365ad60](https://gist.github.com/kennwhite/959d47a77070d365ad60)
