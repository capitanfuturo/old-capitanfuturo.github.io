---
layout: post
title:  ":computer: Arduino e il display 16x2 1602A"
date:   2020-04-15 18:24:04 +0100
categories: [Hardware]
published: false
---
## Premessa
Studiando i vari componenti che si possono interfacciare con Arduino il display è quello che permette di comunicare visivamente con l'utente. In particolare nel kit acquistato a fine anno scorso su Bangood: [UNO Basic Starter Learning Kit](https://www.banggood.com/UNO-Basic-Starter-Learning-Kit-Upgrade-Version-For-Arduino-p-970714.html?rmmds=myorder&cur_warehouse=CN) è possibile fare pratica con un display 16x2 di tipo 1602A (versione A1 del 2019).
Fortunatamente questo display è compatibile con la libreria messa a disposizione da Arduino stessa [LiquidCrystal](https://www.arduino.cc/en/Reference/LiquidCrystal) rendendo veramente facile pilotare il display come proverò a scrivere in questo post.
Dopo aver imparato a saldare mi sono cimentato in questo esercizio ed ecco il post.

## Componenti usati

* Arduino UNO
* Breadboard
* 1 Display LCD 1602A compatibile con Driver Hitachi HD44780
* 1 Potenziometro da 10 kOhm
* 1 Resistenza da 220 Ohm

## Caratteristiche del display 1602A A1

Il display 1602A è dotato di 16 colonne per 2 righe. Il colore di base è blu ed inoltre è possibile pilotare il contrasto del display con la semplice interazione di un potenziometro.
Nella tabella seguente descrivo a cosa corrispondono i vari PIN del display:

| PIN Display | Descrizione | PIN Arduino |
|---|---|---|
| VSS | GND, massa del display | collegato al polo - |
| VDD | 5V, alimentazione del display | collegato al polo + |
| V0 | controllo del contrasto | collegato al potenziometro |
| RS | 0 per invio comando, 1 per invio dati | PIN 12 |
| RW | 0 per scrittura dati / comandi, 1 per lettura dati / stato display  | collegato al polo - |
| E | inizia il ciclo di lettura / scrittura | PIN 11 |
| D0 | Bus dati per comunicazioni 8bit | |
| D1 | Bus dati per comunicazioni 8bit | |
| D2 | Bus dati per comunicazioni 8bit | |
| D3 | Bus dati per comunicazioni 8bit | |
| D4 | Bus dati per comunicazioni 8 o 4bit | PIN 5 |
| D5 | Bus dati per comunicazioni 8 o 4bit | PIN 4 |
| D6 | Bus dati per comunicazioni 8 o 4bit | PIN 3 |
| D7 | Bus dati per comunicazioni 8 o 4bit| PIN 2 |
| A | 5V, alimentazione della retroilluminazione | collegato al polo + con resistenza da 220 Ohm |
| K | GND, massa della retroilluminazione | collegato al polo - |

### Protocollo di comunicazione

Per i miei esercizi ho usato la libreria standard [LiquidCrystal](https://www.arduino.cc/en/Reference/LiquidCrystal) che viene inizializzata con i PIN di gestione. Se invece volessimo farcela a mano dovremmo considerare la seguente sequenza di passi per comunicare con il display:

1. Posizionare il cursore nella posizione desiderata (riga, colonna)
2. Impostare a 1 il pin R/S per impostare l'invio dei dati e a 0 il pin R/W per dire al display che gli invieremo i dati
3. Inviare il codice ASCII del carattere
4. Impostare ad 1 il pin E per un minimo di 450 nanosecondi ed, in seguito, riportarlo a 0 per concluidere l'invio del singolo carattere

## Cablaggio con Arduino

Per il cablaggio ho utilizzato lo schema base descritto nella reference ufficiale di Arduino e disponibile [qui](https://www.arduino.cc/en/Tutorial/HelloWorld).

![schema](https://www.arduino.cc/en/uploads/Tutorial/LCD_Base_bb_Fritz.png)

### Esempio semplice su GitHub

Un primo facile esempio è quello di scrivere qualcosa di statico sulla prima riga in fase di setup del programma arduino ed utilizzare la seconda riga per scrivere un contenuto dinamico nella fase di loop del programma. Questo esempio è quello classico e presentato dalla reference di arduino [https://www.arduino.cc/en/Reference/LiquidCrystal](https://www.arduino.cc/en/Reference/LiquidCrystal).

### Esempio alternativo: divertiamoci

![display](/assets/2020-04-15/display.jpg)

Un secondo esempio alternativo è quello di leggere il testo da scrivere dal monitor seriale di Arduino per poi andarlo a scrivere con la funzionalità di scroll del testo.
Il codice sorgente è disponibile [qui](https://github.com/capitanfuturo/arduinoSalad/blob/master/008_display_16x2/008_display_16x2.ino).

### Boom Shakalaka: Arduino Quiz

![display](/assets/2020-04-15/arduino-quiz.jpg)

Preso dall'euforia del momento mi sono lanciato nella scrittura di un programma in python (piccolo spoiler sul linguaggio di programmazione che vorrei imparare quest'anno! :grin:) che chiede ad una API REST pubblica una domanda di informatica di tipo sì/no e la scrive sull'Arduino passandogli anche la risposta.
Alla pressione del tasto rosso = no o giallo = sì confronta il risultato. Tutto il codice è disponibile su questo repository dedicato [arduino-quiz](https://github.com/capitanfuturo/arduino-quiz).  

## Conclusione

Il display 1602A è un ottimo componente che ci può permettere di mostrare dati e messaggi all'utente e rendere l'Arduino più interattivo. Le possibilità sono davvero illimitate.
Nel frattempo due piccole considerazioni su quanto visto da tenere a mente sono:

* Attenzione che il messaggio visualizzabile è legato alla RAM del display e mi pare che abbia un limite di 80 byte. Questo significa che bisogna spezzare opportunamente la stringa che si vuole visualizzare o comunque pulire in modo opportuno il display.
* La libreria supporta solo caratteri ASCII. Mi pare ci sia il supporto per solo pochi caratteri custom, altrimenti come successo per il display a LED 8x8 bisognerà mapparsi le sprite di tutti i caratteri che si vogliono gestire.

## Link utili

* La reference guide è molto ben fatta e si trova su  [https://www.arduino.cc/en/Reference/LiquidCrystal](https://www.arduino.cc/en/Reference/LiquidCrystal).
* Il datasheet del componente è disponibile qui in formato [PDF](https://www.openhacks.com/uploadsproductos/eone-1602a1.pdf).
* arduino-quiz [https://github.com/capitanfuturo/arduino-quiz](https://github.com/capitanfuturo/arduino-quiz).

> Gli uomini sono diventati gli strumenti dei loro stessi strumenti. (Henry David Thoreau).
