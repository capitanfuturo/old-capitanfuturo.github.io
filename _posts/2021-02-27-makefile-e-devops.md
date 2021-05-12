---
layout: post
title: ":computer: Makefile e DevOps, una breve guida"
date: 2021-02-27 18:24:04 +0100
categories: [ComputerScience]
published: true
---
## Introduzione
Oltre ad Ansible, per motivi lavorativi mi sono messo a giocare con infrastrutture e architetture basate su container docker in ambito docker-compose. Lo so che chi sta leggendo penserà che attualmente esiste solo kubernates per queste cose però mi sono dovuto ricredere anche io su questo tema.

Docker-compose è un ottimo strumento, direi un passo abilitante e che consiglio a tutti per entrare nell'ottica non solo dei microservizi, intesi nello specifico come ristrutturazione di monoliti software ma anche per iniziare a spostarsi nelle competenze devops, nella parte di netowrking e infrastrutture.

Ma bando alle ciance, perchè **Makefile**? Uno strumento che chi come me ha sempre visto di fianco alle guide per compilarsi qualche pacchetto linux quando sulla tua distro preferita, nel mio caso Slackware... perchè?

Beh, ultimamente **make** è tornato in voga nell'ambito della gestione dei container per alcuni pregi:

- è facilmente **portabile**
- è uno strumento per **eseguire task ripetitivi** (vedi compilazione)
- non necessita di particolari dipendenze, anzi è **out-of-the-box** nel caso di sistemi GNU\Linux e affini.
- **descrive le dipendenze** tra i vari target

## Storia

Make è uno strumento scritto nel 1976 da Stuart Feldman nei Bell Labs. Serve per compilare codice C / C++ e può essere paraganato a Maven, Ant, Gradle per Java, (i linguaggi interpretati come Javascript e Python non necessitano di questi strumenti).

## Makefile

`Makefile` è il file che contiene le istruzioni da far eseguire a `make`. E' come il pom.xml per maven. Per provare il tutto basterà quindi avere un terminale linux e un editor di testo.

## Rules

Essenzialmente un Makefile descrive una serie di regole che hanno questa struttura base:

```c
target1 target2 target3: prereq1 prereq2
 commands
 commands
 commands
```

dove:

- _target1_ sono i file di **output** da produrre
- _prereq1 ... prereqn_ sono gli n-file dai quali target dipende. Sono le **dipendenze di target**
- _commands_ sono i comandi necessari per produrre target

Spesso troverete i task più generici in testa al file, mentre man mano che si hanno task più complessi nel fondo in un orientamento top-down

### Hello World

L'esempio più semplice è il classico Hello World

```c
hello:
 @echo "Hello World"
```

se eseguiamo il comando `make hello` vedremo il risultato atteso.

### Hello World - Attenzione

Se invece proviamo questo esempio:

```c
hello:
 touch hello
```

e lo eseguiamo due volte vedremo che la seconda esecuzione non verrà eseguita perchè abbiamo creato un file chiamato hello che è il target della rule hello.

### Rule di default

La rule di default può essere impostata aggiungendo all'inizio del file questa costante riservata

```c
.DEFAULT_GOAL := hello
```

## Costanti

Makefile permette di dichiarare le costanti. Solitamente a inizio del file makefile attraverso la seguente sintassi. Nell'esempio che segue dichiaro la costante _ECHO_HELLO_WORLD_. Le costanti sono per convenzione dichiarati tutti in maiuscolo

```c
.DEFAULT_GOAL := echo1

ECHO_HELLO_WORLD := @echo "Hello World"

echo1:
 $(ECHO_HELLO_WORLD)
```

## Variabili

Le variabili sono definite come nell'esempio che segue:

```c
.DEFAULT_GOAL := echo1

x = hello
y = world

echo1:
 @echo $(x) $(y)
```

## PHONY targets

Come abbiamo visto, make nasce per compilare dei file, ma per i nostri scopi spesso i target che scriviamo non producono file e vogliamo che siano eseguiti sempre. Per fare questo possiamo usare il target PHONY aggiungendo i nostri target come prerequisiti di questo target particolare.

```c
.PHONY: echo1

echo1:
 @echo Hello World
```

## Funzioni

Un'altro costrutto utile è quello della dichiarazione di funzioni. La sintassi per richiamare una funzione è la seguente:

```c
$(function-name arg1[, argn])

$(call function-name,arg1,...,argn)
```

mentre la sua dichiarazione è la seguente:

```c
define nome_funzione
 corpo della funzione
 posso usare $1 per accedere al primo parametro
 posso usare $2 per accedere al secondo parametro
 e via dicendo
endef
```

questo un esempio completo:

```c
.DEFAULT_GOAL := scoping_issue

define parent
 echo "parent has two parameters: $1, $2"
 $(call child $1)
endef

define child
 echo "child has one parameter: $1"
 echo "but child can also see parent's second parameter: $2!"
endef

scoping_issue:
 @$(call parent one two)
```

## Tips

### Formattazione

L'**identazione** è configurata di default con i TAB, per modificare questo aspetto usare la variabile .RECIPEPREFIX

### Shell di default

Si può impostare la shell di default con la variabile SHELL

```c
SHELL=/bin/bash

cool:
    echo "Hello from bash"
```

### Utilizzare file .env

Con docker e docker-compose ci siamo abituati a sfruttare al massimo le variabili di ambiente, per configurare a parità di file ambienti di distribuzione diversa. I Makefile sfruttano le variabili attualmente in uso nella shell. Un trucco per poter avere anche in questo contesto i nostri amati .env è l'utilizzo di questo snippet:

```c
ifneq (,$(wildcard ./.env))
    include .env
    export
endif
```

## Conclusione

Questo post non vuole essere una guida esaustiva anzi come il resto del blog è un appunto personale che spero possa essere utile anche per qualcun'altro. Ovviamente andrò ad integrare in futuro sullo stesso post se dovessi utilizzare altri costrutti di make.

Da questo primo utilizzo posso dire che i Makefile possono essere utilizzati per automatizzare i comandi più ricorrenti in ambito docker ma anche in fase di sviluppo può tornare utili. Sono molto comodi per aprire vscode con parametri particolari e uguali per tutto il team dev o per wrappare i comandi git per esempio in modo da garantire che prima di una commit vena eseguito un pull del repository per esempio.

Conto di ritornare su questo post perchè sono sicuro di aver solo scalfito le potenzialità di questo strumento.

## Links

- <https://makefiletutorial.com/>
- <https://alexharv074.github.io/2019/12/26/gnu-make-for-devops-engineers.html>
- <https://lithic.tech/blog/2020-05/makefile-dot-env>

> Non aspettatetvi dei problemi, perchè tendono a non deludere le aspettative. (Napoleon Hill)
