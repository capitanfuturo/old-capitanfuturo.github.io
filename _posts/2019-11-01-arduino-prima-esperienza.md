---
layout: post
title:  ":computer: Arduino, la mia prima avventura"
date:   2019-11-01 19:24:04 +0100
categories: [Hardware]
---
![Arduino_UNO](/assets/2019-11-01/000.jpg)

## Premessa
_qui racconto di me... saltate pure al prossimo paragrafo se non interessa_

5 anni fa comprai un Raspberry Pi come stazione per il retro-gaming (vedasi il progetto [RetroPie](https://retropie.org.uk/) e come server web per [Bujuse](https://github.com/capitanfuturo/bujuse) il progetto di gestione di magazzino di mia moglie su stack [MEAN](https://en.wikipedia.org/wiki/MEAN_(software_bundle)). Raspberry Pi è una board con microprocessore pensato per la protopizzazione di progetti elettronici ma si adatta bene anche per installazioni di server. Vuoi per il fatto che sia un sistema computazionale che lo avvicina di più ad un pc che ad un microcontrollore, vuoi perchè all'università non ho mai messo insieme un circuito fisico ma solo esercizi di partitori e amplificatori sta di fatto che non ho mai utilizzato questa piattaforma per il [Physical Computing](https://en.wikipedia.org/wiki/Physical_computing).

Arduino invece è una scheda costruita intorno ad un microcontrollore ATmega pensato principalmente per la protopizzazione elettronica e quindi dal mettere mano a circuiti non si può scappare. Mi sono posto quindi tra gli obiettivi di quest'anno di riprendere in mano gli argomenti solo studiati e mai messi in pratica e di studiare questa piattaforma divertendomi un pò alla sera dopo aver messo a letto i piccoli.
 
Scriverò alcuni post su questo blog con dei consigli, senza entrare troppo nel dettaglio visto che di materiale è piena la rete, indicherò invece dove trovare informazioni interessanti e come muoversi da neofiti.

## Introduzione
Arduino è stato ideato e sviluppato nel 2003 da alcuni membri dell'Interaction Design Institute Ivrea, istituto fondato dalla Olivetti e da Telecom Italia, come strumento per la prototipazione rapida (e poi dicono che in Italia non si fa tecnologia).
Il nome potrebbe evocare le gesta del condottiero italiano degli anni 1000 ma invece si rifà al nome del bar frequentato dai fondatori del progetto.
Arduino è completamente open source, sia a livello software per quanto riguarda l'ambiente di sviluppo integrato sia per l'hardware e in quest'ultimo campo è stato uno delle prime manifestazioni del movimento open source in ambito non software.
Il team di Arduino è composto da Massimo Banzi, David Cuartielles, Tom Igoe, Gianluca Martino, e David Mellis.

## Materiale usato
Di seguito vi indico cosa ho comprato, cosa ho reperito dalla rete e cosa ho letto per aiutarmi a districarmi in questo campo.

### Kit completo
Un kit che consiglio è quello di Geekcreit che è disponibile sia su Amazon che su store cinesi. Io ho trovato un buon kit su Banggood a 20 € con spedizione inclusa e tempi di spedizione sui 15 giorni... niente male

![Kit](/assets/2019-11-01/000_kit.jpg)

[UNO Basic Starter Learning Kit](https://www.banggood.com/UNO-Basic-Starter-Learning-Kit-Upgrade-Version-For-Arduino-p-970714.html?rmmds=myorder&cur_warehouse=CN). Il kit contiene la scheda Arduino, delle breadboard, resistenze, led, display, cavetteria e tutto quello che serve per iniziare senza bisogno di un saldatore. 

### Links
Per iniziare a ripassare le basi di elettronica ho trovato questi approfondimenti da [Instructables](https://www.instructables.com/). Questo materiale è accessibile anche da chi è completamente agnostico in materia: 
1. [https://www.instructables.com/id/Basic-Electronics/](https://www.instructables.com/id/Basic-Electronics/)
2. [https://www.instructables.com/class/Electronics-Class/](https://www.instructables.com/class/Electronics-Class/)

### Video 
Un buon video corso che vi segue passo passo è il seguente di [Paolo Aliverti](https://www.youtube.com/watch?v=mAW1KVjC_Vc&list=PL9_01HM23dGEDNNfR6BtlDWD8DDoAcLOT). Paolo è autore di diversi manuali per chi volesse approfondire con lui l'argomento. 

### Manuali
Ho scelto due manuali. Il primo è più teorico mentre il secondo è più informale e propone esercizi più particolari e stimolanti, anche se di pari difficoltà di quelli proposti dal primo.
1. Maik Schmidt, _Il manuale di Arduino: seconda edizione aggiornata (Maker Vol. 3)_, Apogeo. [Amazon](https://www.amazon.it/manuale-Arduino-seconda-edizione-aggiornata-ebook/dp/B00YHEZ9ZQ/ref=tmm_kin_swatch_0?_encoding=UTF8&qid=&sr=).
2. Brock Craft, _Creare progetti con Arduino For Dummies: Con 12 progetti facili da realizzare!_, Hoepli. [Amazon](https://www.amazon.it/Creare-progetti-Arduino-Dummies-realizzare-ebook/dp/B00N9SMFQW/ref=tmm_kin_swatch_0?_encoding=UTF8&qid=1570649798&sr=8-1).
  
## Primi esercizi
Per mantenere traccia degli esercizi fatti e di eventuali progetti personali con questa piattaforma ho pensato di creare un repository GIT su github che trovate a questo indirizzo: [https://github.com/capitanfuturo/arduinoSalad](https://github.com/capitanfuturo/arduinoSalad).

### Esercizio #1 Accensione e spegnimento del LED integrato nel PIN 13
Al PIN digitale 13 di Arduino UNO è associato un LED itnegrato alla scheda già predisposto con resistenza e circuito di sicurezza. Il primo esercizio che non necessita di null'altro che di Arduino è proprio questo.

![LED_13](/assets/2019-11-01/001_led13.png)

#### Variante 1:
Utilizzare una breadboard ed installaci sopra un led di quelli presenti nel kit e ed una resistenza sfruttando la legge di Ohm: V = R x i per non bruciare il led.

#### Variante 2:
Usare il comando analogWrite() ed un pin digitale dotato della caratteristica [Pulse-width_modulation](https://it.wikipedia.org/wiki/Pulse-width_modulation) per modificare la luminosità del led.

![PWM](/assets/2019-11-01/002_pwm.png)

#### Cosa ho imparato
1. Installazione dell'ambiente di sviluppo integrato IDE di Arduino
2. Come si struttura un programma Arduino studiando il metodo setup() e loop().
3. Uso di una breadboard e dei ponticelli
4. Ripasso della legge di Ohm per non dimensionare le resistenze senza bruciare i led sulla breadboard
5. Uso dei comandi digitalWrite(), analogWrite(),  delay() e pinMode()
6. Caricare un programma su Arduino
7. Alimentare Arduino con una batteria esterna

### Esercizio #2 Gioco di luci con 10 LED in stile KITT di supercar
La banda a LED rossa di Kitt la supercar del telefilm evoca pomeriggi a costruire macchinine con i LEGO. Per chi non lo ricordasse lascio il link della [sigla di Knight Rider](https://www.youtube.com/watch?v=oNyXYPhnUIs), la serie TV che questo esercizio vuole farci ricordare.
Tra l'altro quel telefilm ha descritto il funzionamento dell'autopilot di Tesla decenni prima che vedesse la luce!
In ogni caso l'idea dell'esercizio è quella di creare con una striscia di 10 led un gioco di luci simile a quello della sopracitata supercar.

#### Variante 1:
Variare la velocità dell'effetto luminoso utilizzando un potenziometro ed un'uscita analogica

![Potenziometro](/assets/2019-11-01/003.jpg)

#### Cosa ho imparato
1. Utilizzo del comando millis()
2. Utilizzo della classe String
3. Utilizzo della porta seriale e del monitor dell'IDE per leggere messaggi di log dalla scheda
4. Utilizzo dei PIN analogici

## Considerazioni
Arduino è un bellissimo strumento per avvicinarsi al mondo dell'elettronica. Non sono così sicuro che si possa approcciare senza nessuna minima conoscenza perchè se non si sa bene quello che si sta facendo si rischia seriamente di bruciare tutto al primo colpo. In ogni caso partendo dalle cose semplici e andando a complicare pian piano gli esperimenti in un percorso di apprendimento graduale si riescono a realizzare cose interessanti.
Il mio desiderio è quello di portare avanti questo argomento e sicuramente lo segnerò tra gli obiettivi del 2020. Scriverò altri post a riguardo.

> Una macchina può fare il lavoro di cinquanta uomini ordinari, ma nessuna macchina può fare il lavoro di un uomo straordinario.  (Elbert Green Hubbard)