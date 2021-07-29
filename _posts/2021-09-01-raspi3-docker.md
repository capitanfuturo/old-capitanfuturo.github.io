---
layout: post
title: ":floppy_disk: Raspberry PI 3 come docker - docker-compose node su Ubuntu Server"
date: 2021-10-01 19:24:04 +0100
categories: [Software]
published: false
---
## Introduzione
Uno degli obiettivi che mi sono posto ques'anno è quello di migliorare e perfezionare le mie competenze sullo stack docker, node e angular. In particolare a lavoro ho avuto la possibilità di sperimentare ed imparare molto su questi oggetti per cui ho voluto utilizzare un vecchio Raspberry PI 3 come nodo nel mio homelab per far girare un docker daemon e alcuni docker-compose.

## Installazione di Ubuntu 20.04 Server per Raspberry PI

Raspberry Pi ha il chip principale, la CPU basata su architettura ARM64 e non sulla classica x86 64 bit. Per installare Ubuntu su Raspberry ho scelto la versione da installare su una microsd dal sito ufficiale di Canonical [https://cdimage.ubuntu.com/releases/](https://cdimage.ubuntu.com/releases/) e selezionando in particolare la _64-bit ARM (ARMv8/AArch64) server install image_.

Una volta scaricata la ISO attraverso [https://www.balena.io/etcher/](https://www.balena.io/etcher/) è facilmente possibile copiare la ISO sulla microSD card.

## Abilitare un server SSH

Una volta eseguito il flash dell'immagine ISO sulla microSD. Dobbiamo prevedere come accedere al nostro Raspi senza interfaccia grafica attraverso una connessione SSH. Fortunatamente Ubuntu Server prevede già un server SSH installato e per abilitarlo al boot basta aggiungere un file chiamato `ssh` nella partizione **system-boot**.
Si può aggiungere il file direttamente dopo il flash dal proprio computer. La directory è la stessa dove si trova il file **config.txt**

Questo ci permette di avere un Ubuntu server completamente headless già dal primo avvio e di modificare la password. Se alla connessione viene richiesto username e password questi sono i dati:

username: _ubuntu_
password: _ubuntu_

### (Opzionale) disaibilitare il wifi

Se serve disabilitare il modulo wifi sempre nella partizione **system-boot** si può modificare il file `network-config` commentando la parte del wifi:

```bash
version: 2
ethernets:
  eth0:
    dhcp4: true
    optional: true
#wifis:
#  wlan0:
#    dhcp4: true
#    optional: true
#    access-points:
#      myhomewifi:
#        password: "S3kr1t"
#      myworkwifi:
#        password: "correct battery horse staple"
#      workssid:
#        auth:
#          key-management: eap
#          method: peap
#          identity: "me@example.com"
#          password: "passw0rd"
#          ca-certificate: /etc/my_ca.pem
```

## Installazione di Docker

Ora è il tempo di installare docker

1. eseguire lo script ufficiale: `curl -sSL https://get.docker.com | sh`
2. aggiungere l'utente corrente al gruppo di docker. Questo ci permette di eseguire docker senza essere root. `sudo usermod -aG docker ubuntu`
3. riavviare il raspi
4. una volta rientrati via ssh sul raspi provare che tutto funzioni con il comando `docker run hello-world`

## Installazione di docker-compose

Per il mio home lab utilizzerò docker-compose in modo da descrivere in maniera più semplice gli stack applicativi che serviranno nell'infrastruttura.

L'installazione consta dei seguenti passi:

1. `sudo apt-get install -y libffi-dev libssl-dev python3 python3-pip`
2. `sudo apt-get remove python-configparser`
3. `sudo pip3 -v install docker-compose`

## Conclusione

Nei prossimi articoli annoterò alcune cose sull'architettura, la CI/CD e altre prove per il mio side project formativo.

## Link

- Guida ufficiale. [https://ubuntu.com/tutorials/how-to-install-ubuntu-on-your-raspberry-pi](https://ubuntu.com/tutorials/how-to-install-ubuntu-on-your-raspberry-pi)
- Articolo di Rohan Sawant [https://dev.to/rohansawant/installing-docker-and-docker-compose-on-the-raspberry-pi-in-5-simple-steps-3mgl](https://dev.to/rohansawant/installing-docker-and-docker-compose-on-the-raspberry-pi-in-5-simple-steps-3mgl)

> L'architettura è un sogno, la geometria il suo racconto, il manufatto la realizzazione del sogno, l'architetto colui che racconta i sogni. (Carlo Farroni)
