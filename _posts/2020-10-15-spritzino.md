---
layout: post
title:  ":computer: Spritzino: Arduino smart bartender"
date:   2020-10-15 18:24:04 +0100
categories: [Hardware]
published: false
---
## Premessa
Da quasi un anno ho iniziato ad interessarmi al mondo della programmazione di schede per protopizzazione Arduino. Ho completato diversi esercizi basilari che ho raccolto nel repository [arduino salad](https://github.com/capitanfuturo/arduinoSalad). Questi esperimenti compongono una valida cassetta degli sttrezzi che permette di lanciarsi su progetti più sfidanti e così è Spritzino.

L'estate ormai è passata però durante questi mesi non ho smesso di sperimentare con questa meravilgiosa scheda ed ho provato a costruire con le mie conoscenze uno smart bartender con Ardunino. Da bravo veneto non ho potuto esimermi dal conciliare le mie velleità di maker con quelle del degustatore di aperitivi con gli amici ed è qui che nasce il progetto Spritino.

L'ispirazione nasce da un progetto con Raspberry Pi di [Hacker Shack](https://www.hackster.io/hackershack/smart-bartender-5c430e). In rete si trovano diversi progetti, alcuni veramente interessanti e che integrano per esempio i comandi vocali offerti da Alexa e Google.

Nella sua prima versione Spritzino permette di servire dei semplici cocktail con un menu LCD ed in particolare è pensato per lo spritz. Per chi non conoscesse questo cocktail Wikipedia indica:

> A Spritz Veneziano (Austrian German: Spritzer, "splash" / "sparkling") or Aperol Spritz, also called just Spritz, is an Italian wine-based cocktail, commonly served as an aperitif in Northeast Italy. It consists of prosecco, Aperol and soda water.

## Materiale

Per costruire il primo prototipo ho utilizzato i seguenti componenti:

* 1 Arduino Nano [Banggood](https://www.banggood.com/Geekcreit-ATmega328P-Nano-V3-Module-Improved-Version-No-Cable-Development-Board-Geekcreit-for-Arduino-products-that-work-with-official-Arduino-boards-p-959231.html?rmmds=myorder&cur_warehouse=UK)
* 1 Scheda per motori L293D [Banggood](https://www.banggood.com/Motor-Driver-Shield-L293D-Duemilanove-Mega-U-NO-p-72855.html?rmmds=myorder&cur_warehouse=UK)
* 1 Trasformatore 220AC in 12V DC [Banggood](https://www.banggood.com/Geekcreit-AC-100-240V-to-DC-12V-5A-60W-Switching-Power-Supply-Module-Driver-Adapter-LED-Strip-Light-p-1441620.html?rmmds=myorder&cur_warehouse=CN)
* 2 mt di tubo in silicone per alimenti [Banggood](https://www.banggood.com/2M-Food-Grade-Medical-Silicone-Hose-Inner-Diameter-from-2-7MM-p-967089.html?rmmds=myorder&ID=516000&cur_warehouse=CN)
* 2 Interruttori a pulsante [Amazon](https://www.amazon.it/gp/product/B07QL1BC23/ref=ppx_yo_dt_b_asin_title_o03_s00?ie=UTF8&psc=1)
* 3 Pompe peristaltiche 12V DC [Banggood](https://www.banggood.com/12V-DC-Dosing-Pump-Peristaltic-Pump-For-Aquarium-Lab-Analytical-Water-p-931333.html?rmmds=buy&cur_warehouse=CN)
* 1 Convertitore 12V DC in 5V dC [Amazon](https://www.amazon.it/gp/product/B071ZRXKJY/ref=ppx_yo_dt_b_asin_title_o06_s00?ie=UTF8&psc=1)
* 1 Schermo LCD con modulo I2C 1602 [Amazon](https://www.amazon.it/GeeekPi-carattere-retroilluminazione-Raspberry-Progetto/dp/B07PGZ9B51/ref=sr_1_4?dchild=1&keywords=Lcd+16x2&qid=1601235496&sr=8-4)

### Materiale di supporto

* Cavi per le connessioni
* Morsetti dupont
* Termorestringenti
* Saldatore a stagno
* Pinze
* Crimpatrice

## Schema generale

Lo schema logico dei componenti è rappresentato dalla seguente figura:

![schema logico](/assets/2020-10-15/hw_schema.png)

## Cablaggio

Per il cablaggio dei vari componenti riporto delle tabelle con le connessioni verso Arduino Nano e alcune foto del risultato finale.

### Arduino Nano

| PIN | DESCRIPTION |
| --- | --- |
| GND | connesso alla terra GND |
| 5V | connesso ai 5V |
| A4 | connesso al pin SDA dello schermo LCD |
| A5 | connesso al pin SCL dello schermo LCD |
| D2 | connesso al GND del bottone sinistro |
| D3 | connesso al GND del bottone destro |
| D4 | connesso al pin D4 della scheda dei motori |
| D7 | connesso al pin D7 della scheda dei motori |
| D8 | connesso al pin D8 della scheda dei motori |
| D11 | connesso al pin D11 della scheda dei motori |
| D12 | connesso al pin D12 della scheda dei motori |

### LCD 16x2 I2C

| PIN | DESCRIPTION |
| --- | --- |
| GND | connesso a GND |
| 5V | connesso a 5V |
| SDA | connesso al pin A4 di Arduino Nano |
| SCL | connesso al pin A5 di Arduino Nano |

### BUTTONS

| PIN | DESCRIPTION |
| --- | --- |
| LEFT BUTTON  | connesso al pin D2 Arduino Nano |
| RIGHT BUTTON  | connesso al pin D3 Arduino Nano |

### Scheda per motori L293D

Questa scheda viene venduta per gli Arduino UNO mentre io volevo usarla con un Arduino Nano. Grazie a questo [post](https://electropeak.com/learn/use-arduino-l293d-motor-driver-shield-tutorial/) ho scoperto che non tutti i pin vengono utilizzati e la mappatura dei pin è la seguente:

| Motore | PIN Arduino |
| --- | --- |
| Servo | 2,9,10 |
| DC #1 | 11,4,7,8,12 |
| DC #2 | 3,4,7,8,12 |
| DC #3 | 5,4,7,8,12 |
| DC #4 | 6,4,7,8,12 |
| Stepper #1 | 11,3,4,7,8,12 |
| Stepper #2 | 5,6,4,7,8,12 |

Nel mio caso i collegamenti sono quindi stati:

| PIN | DESCRIPTION |
| --- | --- |
| GND | connesso a GND |
| 5V | connesso ai 5V |
| D4 | connesso al pin D4 di Arduino Nano |
| D7 | connesso al pin D7 di Arduino Nano PIN |
| D8 | connesso al pin D8 Arduino Nano PIN |
| D11 | connesso al pin D11 Arduino Nano PIN |
| D12 | connesso al pin D12 Arduino Nano PIN |
| EXT_POWER GND | connesso a -V dell'alimentatore 12V |
| EXT_POWER +M | connesso a +V dell'alimentatore 12V |
| M1, M2, M3, M4 | connesso ai +12V dei motori peristaltici |

## Software

Tutto il codice sorgente è disponbile su github, **[Spritzino](https://github.com/capitanfuturo/spritzino)**. Per avere una idea dello schema logico del programma ho disegnato questo:

![flow](/assets/2020-10-15/sw_flow.png)

## Link Utili

* [Spritzino](https://github.com/capitanfuturo/spritzino)
* [L293ED motor shield tutorial](https://electropeak.com/learn/use-arduino-l293d-motor-driver-shield-tutorial/)
* [Hacker Shack](https://www.hackster.io/hackershack/smart-bartender-5c430e)
* [L293D video](https://www.youtube.com/watch?v=HW1VTOLAXgE)
* [Instructables tutorial by codebender_cc](https://www.instructables.com/id/How-to-use-the-L293D-Motor-Driver-Arduino-Tutorial/)
* [AFMotor library](https://learn.adafruit.com/adafruit-motor-shield/downloads)
* [Tutorial by Great Scott](https://blog.arduino.cc/2017/12/12/this-diy-machine-mixes-your-favorite-three-ingredient-cocktail/)

> Grande è la fortuna di colui che possiede una buona bottiglia, un buon libro, un buon amico.
(Molière)
