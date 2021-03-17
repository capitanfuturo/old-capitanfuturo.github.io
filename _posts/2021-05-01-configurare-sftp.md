---
layout: post
title:  ":computer: Configurare un server SFTP per condividere contenuti"
date:   2021-05-01 22:24:04 +0100
categories: [ComputerScience]
published: false
---
## Introduzione
In questo articolo voglio annotarmi quello che ho imparato configurando un server SFTP Linux per permettere l'accesso ad utenze diverse. So che non è qualcosa di entusiasmante però conoscendomi preferisco scrivere per non dimenticarmi.

## Prerequisiti e assunzioni

Prima di iniziare utile fare delle assunzioni sull'ambiente e sui requisiti:

* Avere a disposizione un **server Linux**
* Avere installato un **server SSH**. Ad esempio il pacchetto `openssh-server`
* Conoscere l'utenza di **root**
* Assumiamo che la directory che conterrà i contenuti FTP sia `/home/sftp`
* Assumiamo che il gruppo Linux per gli utenti che accederanno alla directory precedente sia chiamato `ftpusers`
* **Gli utenti non possono navigare in qualunque directory**
* Si vuole che un web server possa scrivere sulle directory degli utenti

## Aggiungere il gruppo per gli utenti FTP

Aggiungiamo il gruppo con il comando:

~~~bash
groupadd sftpusers
~~~

e creaiamo la directory target:

~~~bash
mkdir -p /home/sftp
~~~

## Configurare il server SSH

L'idea di base nella configurazione del server SSH è quello di attivare il sistema `internal-sftp` e aggiungere delle regole di accesso per gli uteni. La prima configurazione permette di forzare il comando impostato in ForceCommand, ignorando qualunque altro comando impostato dal client in connessione per questioni di sicurezza mentre la seconda configurazione isola l'utente a navigare solo nella sua directory principale che vedrà come la direcotry di root.

Per fare questo dobbiamo modificare le sezioni seguenti del file `/etc/ssh/sshd_config` :

~~~bash
#Subsystem      sftp    /usr/libexec/openssh/sftp-server
Subsystem       sftp    internal-sftp

...

Match Group sftpusers
        ChrootDirectory /home/sftp/%u
        ForceCommand internal-sftp
        X11Forwarding no
        AllowTcpForwarding no
~~~

Una volta modificato il file di configurazione del server SSH possiamo provare la sintatti del file con il comando :

~~~bash
sshd -t
~~~

**NOTA**: Se si applicano le modifiche senza controllare prima eventuali errori si rischia di essere disconnessi dal server senza potervi più accedere via SSH.

Bene, una volta controllato il tutto possiamo riavviare il servizio SSH.

~~~bash
service sshd restart
~~~

## Aggiungere un utente SFTP

Una volta configurato il server SSH vediamo come aggiungere gli utenti che utilizzeranno il servizio SFTP.Per prima cosa aggiungiamo un nuovo utente  chiamato nomeUtente senza il supporto alla login da terminale.

~~~bash
useradd -g ftpusers -d /incoming -s /sbin/nologin nomeUtente
~~~

Impostiamo una password

~~~bash
passwd nomeUtente
~~~

Controlliamo che tutto torni. Dovremmo vedere un risultato de genere al comando `grep nomeUtente /etc/passwd`:

~~~bash
nomeUtente:x:500:500::/incoming:/sbin/nologin
~~~

Creaiamo la directory per nuovoUtente con i permessi di scrittura per il nostro web server che scriverà sulla directory `incoming` dell'utente appena creato.

~~~bash
mkdir -p /home/sftp/nomeUtente/incoming
chown nomeUtente:ftpusers /home/sftp/nomeUtente
chmod 766 /home/sftp/nomeUtente/incoming
~~~

## Conclusione

Configurare un server SFTP può richiedere qualche accortezza ma permette di dare ai propri utenti un servizio largamente usato specialmente in mabito legacy e per comunicazioni di file M2M machine 2 machine.

> Ho scoperto che imparo sempre più dai miei errori che dai miei successi. Se non fai degli sbagli, non stai cogliendo abbastanza opportunità. (John Sculley)
