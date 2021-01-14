---
layout: post
title: ":computer: Recuperare una webcam ck77 94v-0 da un vecchio portatile"
date: 2021-03-15 18:24:04 +0100
categories: [ComputerScience]
published: false
---
## Introduzione
Quando mi laureai nel 2007 il regalo più gradito fu quello di mia madre che mi fece scegliere il portatile che volevo. All'epoca ci mesi diversi mesi per sceglierlo e alla fine presi un ottimo [Asus F6A-3P063C](https://notebookitalia.it/database-notebook/asus-f6a-3p063c). Era un ultraportatile di 13.3 pollici, 3 GB di RAM e Intel Dual Core, una bomba per l'epoca.

Quel portatile mi ha seguito fino a qualche mese fa, fino a quando ho deciso di smontarlo per farlo rivivere in diversi progetti che avevo in mente.

In questo post descrivo come ho recuperato la webcam integrata **ck77 94v-0** per renderla una webcam portatile.

## Idea di base

L'idea di base, visto che per il mio progetto principale non serve la web cam è quello di estrarre dal case del portatile la webcam e connetterla con un cavo USB al computer. Credo che possa tornarmi utile su un RaspberryPi per esempio.

Per fare questo ho usato:

- cacciaviti per smontare il protatile vecchio
- un vecchio cavo USB 2.0
- spellacavi
- saldatore e terza mano
- termorestringenti
- scotch da elettricista

**NOTA: questa non vuole essere una guida, quindi non seguite quello che ho fatto perchè non posso garantirvi che funzioni. L'unica cosa certa è che se sbagliate potreste bruciare qualche componente o il portatile**

Una volta aperto il chassis del portatile e individuata la webcam l'ho smontata e spellato i cavi. Fortunatamente sulla scheda della **ck77 94v-0** era riportata una dicitura vicino alla uscita dei 5V. Questo mi ha facilitato la vita perchè di solito i cavi intrecciati costituiscono il cavo Data + e Data -. **Sono intrecciati per ridurre le interferenze**.
Così sono andato per esclusione. Altro colpo di fortuna è stato sapere che l'alimentazione era da 5V, e non 3.3V come potrebbe accadere per altre webcam integrate, questo invece mi ha risparmiato di dover ridurre in qualche modo la tensione della porta USB che è di 5V.

## Cablaggio

Il mio cablaggio è descritto nelle tabelle che seguono. Unica nota è come identificare i cavi Data. Se infatti si sbaglia a identificarli l'effetto più frequente è che il dispositivo USB
non venga riconosciuto dal sistema operativo.

Un consiglio è quello di intrecciare a mano i cavi con quelli del cavo USB opportunatamente spellato e provare su un PC a vedere se viene riconosciuto. Una volta trovata la giusta
combinazione, saldare e isolare il tutto con i termorestringenti.

In fondo ho riportato quelli che secondo me sono i link più interessanti per riuscire a riprodurre questo progetto.

### USB 2.0

| Colore | Cavo |
| --- | --- |
| Nero | GND |
| Rosso | 5V |
| Bianco | Data - |
| Verde | Data + |

### WebCam ck77 94v-0

| Colore | Cavo |
| --- | --- |
| Nero | 5V |
| Beige | GND |
| Rosso | Data - |
| Marrone | Data+ |

## Risultato

Il risultato è stato soddisfacente. Per testare il tutto ho collegato la webcam al mio EzBook 3 Pro con Ubuntu 20.10 e digitare il comando

~~~bash
sudo dmesg
~~~

l'output parla chiaro, habemus webcam!!!

~~~bash
[ 2123.866324] usb 1-1: New USB device found, idVendor=04f2, idProduct=b029, bcdDevice=51.66
[ 2123.866332] usb 1-1: New USB device strings: Mfr=2, Product=1, SerialNumber=3
[ 2123.866337] usb 1-1: Product: USB2.0 1.3M UVC WebCam
[ 2123.866342] usb 1-1: Manufacturer: Chicony Electronics Co., Ltd.
[ 2123.866346] usb 1-1: SerialNumber: SN0001
[ 2123.872617] uvcvideo: Found UVC 1.00 device USB2.0 1.3M UVC WebCam (04f2:b029)
[ 2123.883154] input: USB2.0 1.3M UVC WebCam: USB2.0  as /devices/pci0000:00/0000:00:15.0/usb1/1-1/1-1:1.0/input/input20
~~~

Bene ora con Cheese prova del nove ed ecco il risultato.

## Conclusione

Mi diverto un mondo a smontare e rimontare le cose (oltre che il software), se poi posso anche recuperare del materiale da vecchi dispositivi per darne nuova vita la cosa mi fa ancora più piacere. Spero di poter usare questo nuovo dispositivo per qualche interessante esperimento con uno dei miei raspberryPi! Stay tuned!

## Link utili

* [https://www.instructables.com/Reuse-old-laptop-webcam/](https://www.instructables.com/Reuse-old-laptop-webcam/)
* [https://www.youtube.com/watch?v=3eZhb-gT8LI](https://www.youtube.com/watch?v=3eZhb-gT8LI)
* [https://www.youtube.com/watch?v=C8pFkhkTvqo](https://www.youtube.com/watch?v=C8pFkhkTvqo)

> Non aspettatetvi dei problemi, perchè tendono a non deludere le aspettative. (Napoleon Hill)
