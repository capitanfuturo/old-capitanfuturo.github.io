---
layout: post
title:  ":computer: Pilotare una striscia LED con Arduino"
date:   2020-08-15 18:24:04 +0100
categories: [Hardware]
published: true
---
## Premessa
Dietro al televisore da circa un anno uso una striscia a LED per migliorare la piacevolezza della visione anche con le luci spente. La retroilluminazione del televisore stanca meno la vista e dà anche un bel aspetto all'ambiente.

Peccato che dopo circa 6 mesi di ottimo lavoro la mia striscia da 15 euro ha smesso di funzionare lampeggiando stile effetto discoteca.

Ecco che dopo aver imparato ad utilizzare i LED con Arduino, dopo aver imparato a saldare e a pilotare Arduino con un telecomando ad infrarossi non potevo esimermi dal cimentarmi nel programmare Arduino per gestire la striscia LED pilotandolo con un telecomando. Qui di seguito la mia esperienza.

## Ripasso: PWM ovvero la modulazione di larghezza d'impulso

Uno dei primi esercizi di Arduino riguardano l'accensione e spegnimento di LED attraverso porte analogiche.
Una porta analogica si comporta come un interruttore a sue stati: spento o acceso, 0 o 1. Questo segnale viene rappresentato idelamente con un gradino e il microcontrollore durante un ciclo di clock mantiene questo stato. Esiste però una tecnica per simulare un segnale analogico su una porta digitale che si chiama [Pulse-with modulation PWM](https://it.wikipedia.org/wiki/Pulse-width_modulation).
Questa tecnica permette di ottenere una tensione media variabile e quindi il carico per esempio su un LED facendo variare la luminosità del LED stesso.

Arduino possiede alcune uscite PIN predisposte per il PWM e sono riconoscibili dal simbolo tilde ~.

Un esempio di utilizzo è quello riportato in uno dei miei primi esercizi: [https://github.com/capitanfuturo/arduinoSalad/tree/master/002_analogWrite_pin11](https://github.com/capitanfuturo/arduinoSalad/tree/master/002_analogWrite_pin11)

Partendo da questo esempio e andando a collegare i PIN della striscia ad alcuni PIN di Arduino proverò ad accedendere e spegnere un colore alla volta.
Fortunatamente la striscia va alimentata con 5V e quindi non necessito in questo caso di andare a separare le alimentazioni con qualcos di esterno e posso permettermi di utilizzare direttamente l'alimentazione di Arduino. Inoltre per proteggere i LED come imparato nei primi esperimenti ho messo delle resistenze da 220 Ohm in modo delimitare la corrente che attraversa la striscia. Il cablaggio sulla breadboard è molto semplice come si vede qui sotto. Per comodità ho usato dei cavi dello stesso colore del LED e il giallo per alimentare il tutto. Lato Arduino invece ho collegato il rosso sul PIN 5, il verde sul PIN 6 e il blu sul PIN 3.

![striscia.jpg](/assets/2020-08-15/striscia.jpg)

~~~c
const unsigned int RED_PIN = 5;
const unsigned int GREEN_PIN = 6;
const unsigned int BLUE_PIN = 3;

void setup(){}

void loop(){

  // RED
  for (int i = 0; i < 255; i++){
    analogWrite(RED_PIN, i);
    delay(5);
  }

  for (int i = 255; i >= 0; i--){
    analogWrite(RED_PIN, i);
    delay(5);
  }

    // GREEN
  for (int i = 0; i < 255; i++){
    analogWrite(GREEN_PIN, i);
    delay(5);
  }


  for (int i = 255; i >= 0; i--){
    analogWrite(GREEN_PIN, i);
    delay(5);
  }

    // BLUE
  for (int i = 0; i < 255; i++){
    analogWrite(BLUE_PIN, i);
    delay(5);
  }


  for (int i = 255; i >= 0; i--){
    analogWrite(BLUE_PIN, i);
    delay(5);
  }
}
~~~

Ora che ho capito come abilitare e disabilitare i colori della striscia proverò ad aggiungere il ricevitore IR per pilotare la striscia LED con un telecomando.
Per mescolare i tre colori possiamo rifarci alle tabelle RGB e grazie al PWM modulare l'intensità dei tre colori.
Un link utile è questo: [https://www.materialui.co/colors](https://www.materialui.co/colors).

~~~c
const unsigned int RED_PIN = 5;
const unsigned int GREEN_PIN = 6;
const unsigned int BLUE_PIN = 3;
const unsigned int DELAY = 1000;

void setup() {}

void loop() {
  rgb(0, 150, 136); //Teal
  rgb(63, 81, 181); // Indigo
  rgb(139, 195, 74); // Light Green
  rgb(233,30,99); // Pink
}

void rgb(int red, int green, int blue) {
  analogWrite(RED_PIN, red);
  analogWrite(GREEN_PIN, green);
  analogWrite(BLUE_PIN, blue);
  delay(DELAY);
}
~~~

Mettiamo adesso insieme tutto con il software per il supporto al telecomando IR. Ecco il codice sorgente:

~~~c
#include <IRremote.h>
#include <IRremoteInt.h>

const unsigned int RED_PIN = 5;
const unsigned int GREEN_PIN = 6;
const unsigned int BLUE_PIN = 3;
const unsigned int DELAY = 1000;
const unsigned int RECV_PIN = 7;

IRrecv irrecv(RECV_PIN);
decode_results results;


void setup() {
  irrecv.enableIRIn();
  irrecv.blink13(true);
}

void loop() {
  
  if (irrecv.decode(&results)) {
    irrecv.resume();
  }
  
  if(results.value == 0xFF30CF){
    rgb(255, 0, 0);
  }else if(results.value == 0xFF18E7){
    rgb(0,255,0);
  }else if(results.value == 0xFF7A85){
    rgb(0,0,255);
  }
}

void rgb(int red, int green, int blue) {
  analogWrite(RED_PIN, red);
  analogWrite(GREEN_PIN, green);
  analogWrite(BLUE_PIN, blue);
  delay(DELAY);
}
~~~

![striscia](/assets/2020-08-15/video.gif)

## Conclusioni

Devo ammettere che dopo una decina di esperimenti con Arduino provando ad utilizzare i diversi sensori e componenti a mia disposizione si inizia a capire come mettere insieme i fari attrezzi dalla cassetta di esperienze per dare sfogo all propria creatività.
Mi sono proprio divertito a recuperare questa striscia LED rotta.

> Nessuno in fatto d’ingegno sa precisamente quanto ne ha: il bello è che ognuno si crede più ricco di quello che è, e che spesso i più poveri sono proprio quelli che sono più soddisfatti. (Stanislas de Boufflers)
