---
layout: post
title:  ":books: Domain-Driven Design Distilled. (Vaughn Vernon)"
date:   2020-03-15 18:24:04 +0100
categories: [Libri]
published: true
---
## Premessa
Da un paio di mesi sono coinvolto in un progetto orientato ai micro-servizi e alla costruzione di una piattaforma per supportare tutti i microservizi corporate del più importante player nella distribuzione di energia elettrica in Italia. Alla base di questo processo aziendale c'è l'acquisizione e la declinazionesul campo della teoria del Domain-Driven Design (da ora in poi abbreviato in DDD).
La DDD nasce dalla mente di Eric Evans ed è descritta nel libro _Domain-Driven Design: Tackling Complexity in the Heart of Software_. Per iniziare ad addentrarsi nell'argomento invece ho deciso di partire da _Domain-Driven Design Distilled_ di Vaugh Vernon. Questo testo può fare al caso, con alcuni ma, che descriverò in seguito.

## Appunti di Domain-Driven Design Distilled

La domain-driven design è un insieme di strumenti che permettono di modellare il software. Il fulcro del design è alla modellazione del *dominio* da descrivere nella maniera più esplicita possibile ed è proprio questo concetto il più arduo da spiegare.
Le tecniche della DDD partono da un prerequisito forte: il cambio organizzativo e non solo concettuale basato sulle seguenti osservazioni nel mondo business reale:

* Lo sviluppo del software è considerato un centro di costo e non un centro di profitto.
* Gli sviluppatori sono spesso orientati alle tecnologie e non al design e al dominio.
* Il database ha un ruolo troppo centrale e il modello dati tende ad avere più importanza rispetto ai processi di business.
* I servizi forniti sono spesso troppo accoppiati tra di loro

A partire da queste considerazioni l'autore identifica due modalità di disegno:

1. Strategic design
2. Tactical design

### Strategic design

Il primo strumento da introdurre come condizione sine qua non per poter comprendere il tactical design è lo strategic design. Il primo passo è usare il pattern Bounded Context per segregare i modelli di dominio e allo stesso tempo sviluppare un Ubiquitous Language associato al modello di dominio all'interno di un Bounded Context.
Un **Bounded Context** è un perimetro semantico contestuale: ogni componente al suo interno ha un significato specifico e fa delle cose specifiche per quel contesto semantico. All'interno di questo contesto esiste un linguaggio specifico e rigoroso utilizzato dai membri del team e che sta sotto il nome di **Ubiquitous Language**.
Questo implica che lo stesso termine possa avere diverse accezioni in Bounded Context diversi ed inoltre forza il team a concentrarsi su quello che è il cuore del contesto lasciando quello che rimane fuori come parte del Ubiquitous Language.
Quello che rimane fuori dal core, che chiamiamo **Core Domain** andrà via via a descrivere attraverso ubiquitous language specifici dei nuovi Bounded Context.
Per sviluppare un Ubiquitous Language viene consigliato l'uso di diverse sessioni di **Event Storming** nelle quali emergono i Bounded Context a partire dagli eventi di business che si identificano. La descrizione di scenari di funzionamento del modello aiuta a definire i contesti e i modelli di dominio che si vanno a delineare. Questa tecnica nella quale si parte dal comportamento del modello si chiama **Behavior-Driven Development** (BDD).
Per poter validare il modello di dominio sui vari scenari si possono descrivere dei test di accettazione. I test sono naturalmente scrivibili a partire dallo scenario e validano il dominio stesso.

#### Architettura

Un Bounded Context è composto da tre livelli:

1. **Input Adapters** come GUI, REST endpoints
2. **Application Services** che orchestrano gli use case e gestiscono le transazioni.
3. Il **Dominio** sul quale il libro si focalizza.
4. **Output Adapters** come la gestione della persistenza e dell'invio di messaggi.

Dati gli starti di cui sopra è possibile usare il DDD con una qualunque di queste architetture e pattern:

* **Event-Driven Architecture**; Event Sourcing.
* Command Query Responsibility Segregation (**CQRS**).
* **Reactive and Actor Model**.
* Representational State Transfer (**REST**).
* Service-Oriented Architecture (**SOA**).
* **Microservices** sono essenzialmente equivalenti ai Bounded Context.
* **Cloud computing**.

#### Subdomains

Un subdomain è una sottoparte di tutto il dominio di business. Si può pensare ad un subdomain coma un singolo, logico modello di dominio. Solitamente per un subdomain si designano uno o più esperti di dominio, **Domain Experts** che comprendono molto bene gli aspetti di business di quel specifico sotto dominio.

#### Tipi di Sottodomini

1. **Core domain** è il sottodominio più importante, essenziale per il business senza il quale il business non esiste. Solitamente è il primo da individuare e modellare.
2. **Supporting subdomain** è un sottodominio meno importate e di meno valore per il business ma senza il quale il business non può sopravvivere per molto tempo. In questo caso non è consigliabile affidarsi a soluzioni o componenti "buy".
3. **Generic subdomain** sono di meno valore e talmente generici che si possono considerare soluzioni proprietarie.

#### Context Mapping

Insieme al core domain esistono altri bounded context e sottodomini. Un modo per modellare la comunicazione tra questi contesti differenti è l'utilizzo del **Context Mapping**. Due bounded context hanno due ubiquitous language differenti: un context mapping è la traduzione di un termine da un contesto ad un altro.

#### Tipi di mappatura

1. **Partnership**: ogni team è responsabile di un bounded context. I due team con obiettivi diversi creano una collaborazione di durata variabile a seconda dell'opportunità in modo da allinearsi in modo tale che o falliscono o vincono insieme.
2. **Shared Kernel**: l'intersezione tra due bounded context è non nulla e quindi si condivide una parte di contesto. Questa soluzione è difficile da mantenere nel tempo perchè implica una comunicazione aperta tra i team.
3. **Customer-Supplier**: descrive una relazione tra contesti e team dove il Supplier è fornitore e Customer cliente delle informazioni.
4. **Conformist**: si ha quando il team supplier non ha bisogni specifici di supportare il customer. Il customer lato suo non ha possibilità di sostenere la traduzione verso il proprio ubiquitous language e quindi si uniforma a quello del supplier.
5. **Anticorruption Layer**: è la mappatura più difensiva. Si crea un layer di transcodifica tra i due linguaggi.
6. **Open Host Service** definisce un protocollo o interfaccia pubblica che da accesso al bounded context come insieme di servizi.
7. **Published Language** è un linguaggio di interscambio ben documentato. Spesso un open host service serve e consuma un published language.
8. **Separate Ways** descrive una sistuazione nella quale l'integrazione tra bounded context non produce valore.

### Deriva del modello

Una delle possibili derive del modello, dovuta a context mapping incontrollati è quella che viene chiamata **Big Ball of Mud**:

1. Un numero crescente di aggregati cross domini contaminano i contesti creando dipendenze.
2. Mantenere questa struttura causa un impatto su tutti i contesti.
3. Solamente un linguaggio non più specifico per dominio mantiene in piedi il modello rendendolo di fatto non più un DDD.

### Tactical design

Il secondo strumento di modellazione da applicare dopo il Strategic design è il Tactical, che descrive come far comunicare i contesti, come fornire degli aggregati e definisce il concetto di entità di dominio e value object.

#### Entity

Una Entità modella una singola cosa del contesto. Ogni entità ha un'identità univoca che la distingue da tutte le altre entità dello stesso tipo o di altri tipi.

#### Value Object

Un Value Object modella un concetto atomico immutabile e quindi nel modello il value non è altro che un valore. A differenza delle entità non ha un identificativo univoco.

#### Aggregate

Un Aggregate è composto da una o più Entità, quando ce n'è solo una si chiama **Aggregate Root**. Oltre alle entità possono concorrere anche dei value object in un aggregato. All'interno di un singolo aggregato tutte le parti devono essere consistenti, in accordo con le regole di business e ciò implica che un aggregate forma un **Transactional Consinstency Boundary**.
Per modellare un aggregate possiamo fare riferimento a queste 4 regole generiche:

1. Proteggere i concetti invarianti all'interno del perimetro dell'aggregato
2. Disegnare aggregati piccoli
3. Referenziare altri aggregati solo attraverso l'identificatore univoco
4. Aggiornare gli altri aggregati usando la **eventual consistency**
Un altra aspetto da tenere in considerazione è il **Single Responsibility Principle** (SRP). Se un aggregato sta proavndo a fare troppe cose allora va diviso. Inoltre è bene tenere a mente di non modificare istanze di aggregati diversi nella stessa transazione.
Ad ogni transazione dell'aggregato viene pubblicato un **Domain Event**. I Domain Events sono pubblicati da un aggregate e sottoscritti dai bounded context interessati.

#### Anemic Domain Model

Un'altra deriva del modello è l'Anemic Domain Model nel quale si usa un modello di dominio orientato ad oggetti, ogni oggetto è un oggetto pubblico con getter e setter e non contiene nessun comportamento di business.
Ciò accade se si applica un focus troppo tecnico e non orientato al business. Il dominio deve descrivere il business.

#### Domain Events

Un evento di dominio è un record di un'occorenza di business significativa in un bounded context. La creazione e la pubblicazione ordinata di eventi di dominio garantiscono che il contesto rimanga coerente. L'evento può essere arricchi to di informazioni oltre agli identificativi univoci in modo da rendere il contenuto dell'evento d'aiuto chi vi si sottoscrive. E' importante che l'aggregate modificato e l'evento di dominio sia salvato insieme nella stessa transazione. Se si usa la tecnica dell'**Event Sourcing** allora lo stato dell'aggregate è interamente rappresentato dagli stessi eventi di dominio.
L'ordine corretto di processamento è data al consumatore dell'evento che sa fino a che punto a processato gli eventi pubblicati e per i quali era in ascolto.

### Event Sourcing

Event Sourcing può essere descritto come il rendere persistenti tutti gli eventi di dominio. Il registro degli eventi permetti quindi di ricostruire lo stato attuale di un aggregate come la sequenza degli eventi che lo hanno interessato.

## Considerazioni

 Il libro, come dichiarato dallo stesso autore non è esaustivo ed è una reference con la quale iniziare ad addentrarsi nell'argomento. Quello che più mi ha perplesso è che i concetti vengono introdotti con un un unico esempio di modellazione di un team Agile e spesso alcuni termini vengono spiegati molto dopo esser stati usati causando dubbi al lettore che non sempre vengono dipanati.
Viceversa il concetto di base che più mi ha colpito è che alla base di tutto sta il fatto che **sviluppatori ed analisti funzionali parlano la stessa lingua**! Questo significa che agli sviluppatori viene richiesto di conoscere gli aspetti di dominio mentre agli analisti le tecnologie che declinano il dominio. Questa è un'affermazione molto forte che nelle realtà lavorative trova poco riscontro, almeno nella realtà italiana.
In definitiva non mi sentirei di consigliare la lettura di questo testo senza aver letto almeno qualche articolo sull'argomento, almeno per non trovarsi spiazzato di fronte a termini che vengono lasciati scontati per troppo tempo nel testo.
Spero personalmente di poter approfondire questi concetti e di poter trovare situazioni in cui sia possibile usare queste metodologie che richiedono un forte coinvolgimento del cliente o semplicemente del business aziendale.

## Riferimento

Vaughn Vernon, _Domain-Driven Design Distilled_, Addison-Wesley Professional, 2016. [Amazon](https://www.amazon.it/Domain-Driven-Design-Distilled-English-Vaughn-ebook/dp/B01JJSGE5S/ref=tmm_kin_swatch_0?_encoding=UTF8&qid=1579193749&sr=8-1)

> Il design deve funzionare, l’arte no.  (Donald Judd)
