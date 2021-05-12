---
layout: post
title: ":computer: Videosorveglianza su Linux headless (Raspberry Pi)"
date: 2021-06-01 22:24:04 +0100
categories: [Hardware]
published: false
---
## Introduzione
In un precedente articolo ho raccontato come ho recuperato la webcam di un vecchio portatile per poterlo usare come una normale web cam su un altro PC. Il riferimento è questo [Recuperare una webcam ck77 94v-0 da un vecchio portatile]({% post_url 2021-03-15-recuperare-webcam-ck77-94v-0 %})

In questo articolo invece ho provato a collegare la webcam su un Raspberry Pi 3 con un Ubuntu Server 20.04 arm64. L'idea è qundi quella di sfruttare un dispositivo headless, quindi senza alcun monitor collegato, installarci un server web ed accedere da un altro pc alla telecamera.

Questo meccanismo potrebbe essere visto come un rudimentale sistema di videosorveglianza fatta in casa.

## Occorrente

- Un altro PC
- Raspberry pi 3 (Ubuntu 20.04 con OpenSSH installato)
- webcam USB compatibile con Linux

## Installazione

Una volta collegata la webcam al Raspberry e acceduto via SSH il tutto si risolve installando un pacchetto molto interessante: **Motion**. Motion è un progetto che nasce proprio con l'intento di interfacciarsi al maggior numero possibile di webcam e permette di costruire camere di sicurezza, timelapse, streaming e molto altro.

Abilitiamo la scrittura sul device della video camera

```bash
chmod 777 /dev/camera0
```

Per prima cosa installiamo il pacchetto

```bash
sudo apt update
sudo apt install motion
```

Ora scriviamo la prima configurazione

```bash
mkdir ~/.motion
nano ~/.motion/motion.conf
```

Una prima configurazione utilizzabile è questa

```bash
stream_quality 98
stream_maxrate 5
stream_port 8080
stream_localhost off
output_pictures off
framerate 30
ffmpeg_video_codec mpeg4
width 640
height 480
auto_brightness off
contrast 0
saturation 0
```

Questo file avvia un webserver alla porta 8080 del raspberry pi, con un framerate di 30fps e una risoluzione 640x480.

Da un altro PC possiamo controllare che tutto funzioni andando su un browser e accedendo all'indirizzo http://ip-raspi3:8080, dove al posto di ip-raspi3 mettete l'indirizzo ip nella vostra rete del raspberry, ad esempio 192.168.1.60.

### Tuning della configurazione

Per tutti i parametri di configurazione la guida è reperibile dal sito ufficiale: [https://motion-project.github.io/motion_config.html#configfiles](https://motion-project.github.io/motion_config.html#configfiles)

## Conclusione

Il risultato della POC penso sia accettabile. Un caso d'uso potrebbe essere quello di una videocamera di sorveglainza interna da collegare ad un meccanismo di notifiche.

### Miglioramenti

- Adeguare la configurazione al tipo di web cam usata
- Eseguire un breve video al solo rilevamento di un movimento
- Agganciare un meccanismo di notifica per esempio via telegram

## Links

- [https://gist.github.com/endolith/2052778](https://gist.github.com/endolith/2052778)
- [https://motion-project.github.io/](https://motion-project.github.io/)

> I segreti più impenetrabili sono nascosti in bella vista. (Dan Brown)
