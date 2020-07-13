---
layout: post
title:  ":wrench: Convertire un alimentatore ATX in un alimentatore da banco"
date:   2020-07-10 19:24:04 +0100
categories: [Hardware]
published: true
---
## Premessa
Ammetto sinceramente che Arduino mi sta appassionando e nonostante abbia bruciato un paio di motorini e una scheda di controllo di velocità di un motore a 4 fasi, la voglia di sperimentare rimane.
Ho visto diversi video nei quali si utilizzano più o meno 3 alimentazioni principali: 3.3 V per motorini piccoli, 5 V per Arduino e tutti i componenti che funzionano su USB e 12 V per motori DC più potenti (ce ne sono anche da 24V e 220V ma non vorrei far saltare casa).
Spesso viene usato un alimentatore da banco per questi esperimenti e così mi sono messo a cercare un prodotto adatto a me. nella ricerca però ho trovato una miriade di video e articoli su come modificare un vecchio alimentatore da PC fisso ATX in un perfetto alimentatore da banco.

## Alimentatore ATX

Per chi come me ha avuto un'infanzia sui 386, 486 sx, Pentium 100 e LAN party con monitor CRT in spalla non può mancare a casa un vecchio alimentatore ATX, l'alimentatore standard per i case dei PC fissi.
Qui un articolo di [wikipedia](https://it.wikipedia.org/wiki/ATX_(standard)) spiega di cosa sto parlando. Questi tipi di alimentatori standard forniscono tutte le alimentazioni di cui abbiamo bisogno, stabilizzasti e con un buona potenza, sicuramente sufficiente per accendere tutto quello che usiamo con Arduino.

## Scheda presaldata

Ecco che lo step succesivo è quello di capire come utilizzare i cavi che escono per arrivare al nostro obiettivo. Cercando in rete ho trovato su Banggood un prodotto della Geekcreit molto interessante. Se volete il link è questo: [https://www.banggood.com/Geekcreit-XH-M229-Desktop-Computer-Chassis-Power-Supply-Module-ATX-Transfer-Board-Power-Output-Terminal-Module-p-1418198.html](https://www.banggood.com/Geekcreit-XH-M229-Desktop-Computer-Chassis-Power-Supply-Module-ATX-Transfer-Board-Power-Output-Terminal-Module-p-1418198.html) (non è un affiliazione).

## Consigli

1. Con questa scheda è possibile uscire con dei connettori con tutti i voltaggi utili. Unico consiglio che appunto qui è quello di tagliare i cavi che non sono coinvolti nel connettore principale per pulizia.
2. La scheda non ha dei connettori a banana, quindi sono necessarie dei cavi pinzati oppure dei connettori per facilitarne l'utilizzo
3. Se volete una bella verniciata può ridare vita all'aspetto del vecchio alimentatore e rendere il tutto esteticamente più curato. (Vedasi: così tua moglie non getterà tutto dalla finestra se lo vede su una mensola in studio).

## Foto

![atx_1.jpg](/assets/2020-07-10/atx_1.jpg)

![atx_2.jpg](/assets/2020-07-10/atx_2.jpg)

![atx_3.jpg](/assets/2020-07-10/atx_3.jpg)

![atx_4.jpg](/assets/2020-07-10/atx_4.jpg)

![atx_5.jpg](/assets/2020-07-10/atx_5.jpg)

![atx_6.jpg](/assets/2020-07-10/atx_6.jpg)

## Conclusione

Devo dire che mi sono divertito molto nel dare una nuova vita ad un vecchio alimentatore. Inoltre è un ottimo strumento che serve per testare facilmente i circuiti che proviamo ad assemblare nei nostri progetti.

> Il lavoro allontana da noi tre grandi mali: la noia, il vizio e il bisogno. (Voltaire)
