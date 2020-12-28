---
layout: post
title:  ":computer: Arduino e la matrice LED 8x8 1588BS"
date:   2020-01-12 15:24:04 +0100
categories: [Hardware]
---
## Introduzione
Nel primo post sul tema Arduino ho parlato del kit acquistato su Banggood: [UNO Basic Starter Learning Kit](https://www.banggood.com/UNO-Basic-Starter-Learning-Kit-Upgrade-Version-For-Arduino-p-970714.html?rmmds=myorder&cur_warehouse=CN). Questo kit della Geekcreit contiene tutto l'indispensabile per iniziare ad imparare a programmare ed assemblare componenti elettronici su questa piattaforma.
Uno dei punti deboli di questi prodotti cinesi, che in parte ne giustificano il prezzo inferiore alla media, è la mancanza di assistenza post selling e della documentazione della componentistica.
Nel kit è presente una matrice di LED rossi 8x8 sotto il codice **1588BS** peccato che non si trovino in rete datasheet o materiale. Cercherò di descrivere come posso questo modello di matrice LED in questo post.

## Caratteristiche del 1588BS

### Identificare il PIN 1

Per identificare il PIN 1 il metodo più semplice è guardare il profilo inferiore della plastica bianca dove solitamente è impresso il codice del componente. Se notate il lato che ha il PIN 1 è identificabile da uno scalino verso il basso come mostrato in figura.

![1588BS front](/assets/2020-01-12/front.jpg)

Il PIN si trova sulla sinistra (quindi quando lo girate lo avrete in basso a destra) e il senso è antiorario. In ogni caso ho fatto una foto anche della parte inferiore con i PIN per vedere meglio la cosa.

![1588BS back](/assets/2020-01-12/back.jpg)

### Schema dei PIN

Una volta identificata e numerata la piedinatura, l'altro scoglio è quello di identificare che righe e che colonne comandano i PIN. Purtroppo non è come ci si aspetterebbe che la piedinatura nella parte bassa comandi le righe e le colonne siano comandata da quella alta. Quello che accade è riportato nella tabella qui sotto.

| RIGA (+ 5V)| PIN del 1588BS|COLONNA (- GND)|PIN del 1588BS|
|-------|--------|---------|---------|
| 1 | 9 | 1 | 13 |
| 2 | 14 | 2 | 3  |
| 3 | 8 | 3 | 4 |
| 4 | 12 | 4 | 10 |
| 5 | 1 | 5 | 6 |
| 6 | 7 | 6 | 11 |
| 7 | 2 | 7 | 15 |
| 8 | 5 | 8 | 16 |

Quindi se voglio accendere il PIN nella posizione (1,1) devo alimentare il PIN 9 con segno + e fa scorrere la corrente verso terra dal PIN 13. Come si vede stanno tutti e due i PIN nella parte alta del componente.

### Cablaggio con Arduino

Per cablare il tutto l'importante è considerare di mettere una resistenza a monte degli ingressi in modo da non bruciare i LED della matrice. Inoltre bisogna considerare che gli ingressi digitali dell'Arduino non bastano e che quindi dovremmo sfruttare anche gli ingressi analogici per collegare il tutto. Esiste la possibilità di utilizzare degli shift-register, dei registri a scorrimento per diminuire il numero di ingressi usati, ma li devo ancora studiare bene.

Per comodità ho agito nel seguente modo: prima ho collegato in ordine le righe mettendo una resistenza da 1 KOhm davanti al PIN della matrice e poi ho collegato in ordine le colonne andando a sconfinare sugli ingressi analogici di Arduino.
Come da tabella precedente sono partito dal PIN digitale 2 dell'Arduino ed ho collegato prima una resistenza e poi il PIN 9 della matrice. Da ricordare che per accendere un LED della riga desiderata bisognerà mandare un segnale HIGH sul PIN di Arduino con il comando _digitalWrite(pin,HIGH)_.
Una volta collegati tutti i PIN di riga sono passato a quelli di colonna senza inserire una resistenza. Da ricordare che per accendere un LED della colonna desiderata bisognerà mandare un segnale LOW sul PIN di Arduino con il comando _digitalWrite(pin,LOW)_.
Qui sotto una foto.

![1588BS final](/assets/2020-01-12/final.jpg)

### Un esempio su GitHub

Se a qualcuno può essere utile lascio il link del mio esercizio su GitHub: [https://github.com/capitanfuturo/arduinoSalad/tree/master/004_8x8_led_matrix_1588BS](https://github.com/capitanfuturo/arduinoSalad/tree/master/004_8x8_led_matrix_1588BS). In questo esempio uso la matrice di LED per disegnare uno smile sorridente.

## Conclusione

Una volta capito come è configurata la matrice LED 8x8 1588BS sarà facile e divertente cimentarsi nei vari esercizi disponibili in rete e su libri di testo. Il prossimo passo è quello di studiare i registri a scorrimento per diminuire gli ingressi digitali usati nell'Arduino.

## Link utili

Per arrivare alla soluzione descritta ho trovato utili i seguenti link:

1. [http://arduino-er.blogspot.com/2015/01/how-to-identify-pin-1-of-8x8-led-matrix.html](http://arduino-er.blogspot.com/2015/01/how-to-identify-pin-1-of-8x8-led-matrix.html)
2. [https://forum.hobbycomponents.com/viewtopic.php?f=58&t=1489](https://forum.hobbycomponents.com/viewtopic.php?f=58&t=1489)

> A quanto possiamo discernere, l’unico scopo dell’esistenza umana è di accendere una luce nell’oscurità del mero essere.  (Carl Gustav Jung)
