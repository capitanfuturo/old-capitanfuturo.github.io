---
layout: post
title:  ":floppy_disk: Chocolatey, il package manager per Windows"
date:   2019-10-16 19:24:04 +0100
categories: [Software]
---
![Chocolatey_screenshot](/assets/2019-10-16/chocolatey_screenshot.png)

Con la distribuzione di Windows 10, Microsoft ha introdotto nel suo sistema operativo l'App Store. 
Il mondo mobile e per prima Apple, che ne ha avuto l'idea, ha inventato questo marketplace integrato nei propri sistemi per l'installazione di software. Questo strumento permette ai publisher migliori o che pagano sponsorizzazioni di essere in vetrina mentre il proprietario della piattaforma può controllarne aspetti di sicurezza e standard applicativi che altrimenti non potrebbe gestire.

I software contengono per natura errori (sono sempre scritti, almeno per ora, da esseri fallibili) e per un produttore di sistemi operativi avere la possibilità di garantire qualità e sicurezza in quello che gli utenti installano è un vantaggio sui competitors, rende l'esperienza più piacevole e permette di far emergere i prodotti migliori rendendo l'esperienza utente più piacevole.

Nel mondo GNU/Linux la maggior parte delle distribuzioni più usate hanno sempre offerto all'utenza dei repository di software installabile per la versione e l'architettura CPU utilizzata, e dei comandi per gestire l'installazione. Forse il più famoso per chi è passato per Debian e derivate è [APT](https://it.wikipedia.org/wiki/Advanced_Packaging_Tool) (Advanced Packaging Tool) anche se ultimamente vanno di moda meccanismi cross distro come [flatpak](https://flatpak.org/) e [snapcraft](https://snapcraft.io/). Essendo l'open source un ambiente decentralizzato per natura, apt non può considerarsi un vero marketplace mentre gli ultimi due strumenti citati incarnano meglio il concetto di App Store.

Per Windows 7 e successivi esiste un progetto Open Source molto interessante che si chiama [Chocolatey](https://chocolatey.org/). Si tratta di un repository stile APT con integrazione alla linea di comando, come per esempio powershell. Questo approccio permette di costruirsi degli script semplici per installare e replicare l'installazione su diversi computer dello stesso insieme di applicazioni. Di seguito ve ne descriverò brevemente le caratteristiche e come lo uso personalmente.

## Requisiti

- Windows 7 o successivo / Windows Server 2003 o successivo
- PowerShell v2 (solitamente già presente)
- .NET Framework 4+ (se non disponibile verrà installato automaticamente)

## Installazione

1. Per installare Chocolatey avviare powershell come amministratore. 
2. Una volta comparso il prompt dei comandi powershell eseguire lo statement qui riportato

~~~bash
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
~~~

Ora avete chocolatey nel vostro sistema. Per rendere attivo il comando bisogna riavviare la powershell. 
Un primo programma se volete sfruttare chocolatey graficamente o semplicemente per esplorare il repository è l'interfaccia grafica installabile da powershell con il seguente comando

~~~bash
choco install chocolateygui -y
~~~

Ora potete sfruttare sia la GUI per navigare e curiosare il repository oltre che installare e aggiornare massivamente le applicazioni installate oppure sfruttare la potenza della CLI.

## Script personale

Prendendo spunto da un progetto su GitHub molto interessante in ambito Linux: [https://dotfiles.github.io/](https://dotfiles.github.io/) ho deciso di creare un repository git per salvare lo script powershell con i programmi che solitamente installo in una worksation.

Questo è un buon modo per avere un backup di questa configurazione.
Come lo uso? Dopo aver installato chocolatey scarico il file da [qui](https://github.com/capitanfuturo/chocolatey-setup/blob/master/chocolatey-setup.ps1) ed eseguo lo script dal pc che voglio configurare... semplice no.
Per verificare che tutto sia installato si può usare il comando

~~~bash
choco list --local-only
~~~

### Nota se non si riesce ad eseguire lo script

Può capitare la prima volta che si esegue uno script powershell che questo dia errore perchè lo script non è firmato ma costruito in locale.

Per ovviare a questo si deve eseguire powershell in modalità amministratore ed eseguire il comando

~~~bash
set-executionpolicy remotesigned
~~~
e rispondere 'S' alla domanda di prompt.

## Pro

- con un solo comando è possibile aggiornare tutto il software installato
- è possibile preparare uno script per poter replicare l'installazione della propria lista di app su altri PC.
- la GUI anche se spartana permette di scoprire e provare software che magari prima non si conosceva.
- Open source (Apache v2.0) nella versione free

## Cons

- la versione ad uso personale non permettere di impostare un disco di default per l'installazione dei programmi. Nella maggior parte dei casi questo non costituisce un problema ma per esempio nel low-cost PC da dove scrivo il blog: un fantastico Ezbook Pro 3 v4 il disco principale è un modesto eMMC da 64GB che diciamo non essere proprio il massimo della capienza.
- Non sono riuscito ad installare correttamente lo stack necessario per eseguire questo blog in locale. Attualmente quello che leggete è costruito a partire da [Jekyll](https://jekyllrb.com/) che necessita di [Ruby + devKit](https://rubyinstaller.org/) + [msys2](https://www.msys2.org/) in Windows.
- A volte ho riscontrato dei problemi negli aggiornamenti che non vengono terminati correttamente
- I pacchetti possono cambiare nome e quindi ci si ritrova con una lista "falsata" del software installato

## Conclusioni

Chocolatey è una buona soluzione in ambiente Windows per automatizzare in stile Linux l'installazione dei programmi senza scaricarsi gli installer dai vari siti. Nel mio repository GIT trovate la mia configurazione attuale se volete farvi un'idea.
L'interfaccia grafica è spartana ma fa il suo dovere e permette di aggiornare selettivamente o massivamente tutto il software installato.
Probabilmente la versione a pagamento dà più soddisfazioni ma già la versione base è completa per un uso personale.

Ha ancora diversi bug in fase di aggiornamento dei pacchetti che a volte si bloccano per cause sconosciute. Il progetto è interessante anche se lo sconsiglio alemno per adesso come uso quotidiano.

> I bravi programmatori sanno cosa scrivere. I migliori sanno cosa riscrivere (e riusare). (Eric Steven Raymond)
