---
layout: post
title:  ":computer: Arduino + fotocellula LDR"
date:   2020-06-15 18:24:04 +0100
categories: [Arduino]
published: true
---
## Premessa
Un fotoresistore o fotocellula è un resistore variabile che varia la sua resistenza al variare della luce che lo irradia. In particolare la resistenza è inversamente proporzionale all'intensità della luce quindi diminuisce all'aumentare dell'intensità della luce.
L'uso più comune è quello di utilizzare questo componenete come interruttore per circuiti. Un'idea è quella di creare un crepuscolare.

## Costruzione di un crepuscolare

Per costruire questo semplice circuito occorrono:

* 1 Arduino Uno
* 1 breadboard
* 1 sensore LDR
* 1 resistenza da 10 KOhm
* 1 resistenza da 220 Ohm (per proteggere il LED che andremo ad accendere)
* 1 LED

Lo schema è il seguente:

![crepuscolare](/assets/2020-06-15/crepuscolare.png)

qui il codice, disponibile anche su [https://github.com/capitanfuturo/arduinoSalad/blob/master/011_LDR_sensor/011_LDR_sensor.ino](https://github.com/capitanfuturo/arduinoSalad/blob/master/011_LDR_sensor/011_LDR_sensor.ino)

~~~c
/*
 * MIT License - Copyright (c) 2020 Giuseppe Caliendo
 *
 * Utilizzo di un sensore LDR per costruire un crepuscolare.
 */
const unsigned int LDR_PIN = A0; // LDR è collegato ad un PIN analogico
const unsigned int LED_PIN = 9; // PIN collegato al LED
const unsigned int THRESHOLD = 510; // valore soglia per lo spegnimento del LED

int value; // Valore del sensore (0-1023)

void setup(){
    pinMode(LED_PIN, OUTPUT); // PIN collegato al LED
    pinMode(LDR_PIN, INPUT); // PIN collegato al sensore LDR
}

void loop(){
    value = analogRead(pResistor);

    if (value > THRESHOLD){
        digitalWrite(ledPin, LOW);  // Spegni il LED
    } else {
        digitalWrite(ledPin, HIGH); // Accendi il LED
    }

    delay(500);
}
~~~

ed il risultato all'opera:

![crepuscolare](/assets/2020-06-15/crepuscolare.gif)

## Link utili

* [https://create.arduino.cc/projecthub/amar-slik/turn-on-and-off-led-by-ldr-toggle-ldr-2e3502?ref=similar&ref_id=60432&offset=0](https://create.arduino.cc/projecthub/amar-slik/turn-on-and-off-led-by-ldr-toggle-ldr-2e3502?ref=similar&ref_id=60432&offset=0)
* [https://create.arduino.cc/projecthub/petroov/tutorial-ldr-4ae892](https://create.arduino.cc/projecthub/petroov/tutorial-ldr-4ae892)
