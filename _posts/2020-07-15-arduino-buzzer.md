---
layout: post
title:  ":computer: Coffin meme: Arduino e i buzzer. Scrivere una libreria"
date:   2020-07-15 18:24:04 +0100
categories: [Hardware]
published: false
---

## Introduzione

Un altro componente che non può mancare nella cassetta degli attrezzi di un maker è l'uso di buzzer per produrre suoni con il nostro arduino. In questo post cercherò di addentrarmi anche nelle logiche di disegno e programmazione di una libreria per Arduino.

## Occorrente

1. Arduino UNO
2. Buzzer attivo

![foto](/assets/2020-07-15/foto.png)

### Tips

Un consiglio per riconoscere un buzzer attivo da uno passivo, ( l'attivo ha un suono più marcato) è quello di girarli e vederne il fondo. Quello attivo solitamente ha un colore verde, azzurro mentre quello passivo è nero.

![buzzers](/assets/2020-07-15/buzzers.png)

## Schema

![schema](/assets/2020-07-15/schema.png)

un esempio semplice di codice è il seguente:

~~~c
const int BUZZER_PIN = 3; // a PWM PIN

void setup() {
  //Setup pin modes
  pinMode(BUZZER_PIN, OUTPUT);
}

void loop() {
  //Play tone on buzzerPin
  tone(BUZZER_PIN, 440, 250);
  delay(50);
  //Stop tone on buzzerPin
  noTone(BUZZER_PIN);
  delay(1000);
}
~~~

Questo ci permette di produrre un suono con il nostro Arduino. A partire da questo snippet si possono fare cose molto più complicate.

## Scrivere una libreria: Coffin Meme Song

![coffin](/assets/2020-07-15/coffin.jpg)

Una volta capito il meccanismo potrebbe essere utile iniziare ad organizzare meglio le cose.
Le note musicali sono associate a delle frequenze specifiche che potremmo salvare su una libreria così come i tempi e le pause a parità di BPM.
Per questo ho pensato di scrivere una lirberia per lo scopo. Un pò per rendere riutilizzabile questa parte di codice a chi volesse usarla per generare altre melodie e in particolare per imparare ad organizzare una libreria per arduino.

All'interno ho realizzato un esempio prendendo spunto dalla canzone Astronomia famosa per il meme "coffin dance meme song"

Tutto il codice è ovviamente open source e disponibile nel mio repository personale su github:
[https://github.com/capitanfuturo/arduino-coffin-buzzer](https://github.com/capitanfuturo/arduino-coffin-buzzer)

> Senza la musica per decorarlo, il tempo sarebbe solo una noiosa sequela di scadenze produttive e di date in cui pagare le bollette. (Frank Zappa).
