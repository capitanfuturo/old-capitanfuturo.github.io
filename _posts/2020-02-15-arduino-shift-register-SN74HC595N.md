---
layout: post
title:  ":computer: Arduino e il registro a scorrimento SN74HC595N"
date:   2020-02-15 15:24:04 +0100
categories: [Hardware]
published: false
---
## Introduzione
Nel precedente articolo sulla matrice di LED 1588BS ho anticipato che avrei provato ad inserire nel circuito uno shift register da 8 bit per provare come diminuire il numero di porte usate sull'Arduino per pilotare la matrice. Nello starter kit  comprato su Banggood: [UNO Basic Starter Learning Kit](https://www.banggood.com/UNO-Basic-Starter-Learning-Kit-Upgrade-Version-For-Arduino-p-970714.html?rmmds=myorder&cur_warehouse=CN) è presente un registro a scorrimento della Texas Instruments a 8 bit, modello **SN74HC595N**.
Scrivo qui qualche appunto sul componente e sul suo utilizzo. Il datasheet ufficiale è scaricabile da qui: [Data sheet ufficiale Texas Instrument](http://www.ti.com/lit/ds/symlink/sn74hc595.pdf)

## Caratteristiche del SN74HC595N

La parte in alto si riconosce da uno scanso semicircolare in prossimità del simbolo della Texas Instrument. La seguente tabella ne descrive i PIN di collegamento

| Nome| PIN di sinistra|PIN di destra|Nome|
|-------|--------|---------|---------|
| QB | 1 | 16 | VCC |
| QC | 2 | 15 | QA  |
| QD | 3 | 14 | DATA |
| QE | 4 | 13 | OE |
| QF | 5 | 12 | LATCH |
| QG | 6 | 11 | CLOCK |
| QH | 7 | 10 | MR |
| GND | 8 | 9 | QH' |

con la seguente descrizione

| Nome| PIN | Descrizione |
|-------|--------|--------|
| QA - QH | 15,1-7 | Output da 0 a 7 |
| GND |8 | Terra, polo negativo (-) |
| QH' | 9 | Output per mettere in serie, in cascata un altro shift register, permettendoci ancora di aumentare il numero di output |
| MR| 10 | Master Reclear, da collegare al polo positivo se non si vuole il reset di tutto il registro |
| CLOCK | 11 | Clock o shift clock, serve per comunicare al registro quando abbiamo finito di inviare un bit |
| LATCH | 12 | Latch PIN o storage clock. Dopo aver inviato tutti gli 8 bit serve per comunicare al registro che abbiamo finito di inviare e che il registro può inviare tutti i segnali in output |
| OE | 13 | Output Enable, da collegare a terra per abilitare le porte |
| DATA | 14 | Input seriale dei dati. Serve per inviare un bit alla volta al registro |
| VCC | 15 | Input di tensione, polo positivo |

## Utilizzo con 8 LED

Un interessante video che mostra la base di utilizzo del registro è visibile qui: [https://www.youtube.com/watch?v=MRy47jCn3zA](https://www.youtube.com/watch?v=MRy47jCn3zA).
Per approfondire l'argomento ho trovato invece molto interessante questo articolo [https://lastminuteengineers.com/74hc595-shift-register-arduino-tutorial/](https://lastminuteengineers.com/74hc595-shift-register-arduino-tutorial/).
La prima prova è stata quindi quella di cablare all'Arduino 8 LED e il registro a scorrimento per ottenere questo effetto:

![SN74HC595N](/assets/2020-02-15/shift-single-row.gif)

Il codice è disponibile su [https://github.com/capitanfuturo/arduinoSalad/blob/master/006_8bit_shift_register/006_8bit_shift_register.ino](https://github.com/capitanfuturo/arduinoSalad/blob/master/006_8bit_shift_register/006_8bit_shift_register.ino)

## Utilizzo con una Matrice di LED 8x8

Prendendo spunto dall'esempio di prima l'idea è di usare lo stesso meccanismo per pilotare le colonne della nostra matrice LED 8x8 con il risultato seguente:

![SN74HC595N+1588BS](/assets/2020-02-15/shift-matrix-led.jpg)

Il codice è disponibile su [https://github.com/capitanfuturo/arduinoSalad/blob/master/007_8x8_plus_shift_register/007_8x8_plus_shift_register.ino](https://github.com/capitanfuturo/arduinoSalad/blob/master/007_8x8_plus_shift_register/007_8x8_plus_shift_register.ino)

>Le idee (memi) migliori sopravvivono per selezione culturale. Quindi sopravvivono alla competizione non le idee più forti, ma quelle che si adattano meglio. (Massimo Chiriatti)
