# 🌐 Progetto: **Reti Di Calcolatori & Internet**

<p align="center">
  <img src="https://img.shields.io/badge/Stato-In%20sviluppo-blue?style=for-the-badge" alt="Stato: In sviluppo"/>
  <img src="https://img.shields.io/badge/Linguaggio-MATLAB/SIMULINK/TrueTime-green?style=for-the-badge" alt="Lingua: MATLAB"/>
  <img src="https://img.shields.io/badge/Focus-Simulazione di Rete%20%26%20Prestazioni-orange?style=for-the-badge" alt="Focus: Simulazione di rete"/>
</p>

---

## 🧠 Descrizione sintetica

Questo progetto mira alla realizzazione di una rete simulata composta da **sensori**, **controllori** e **attuatori** interconnessi tramite un **gateway centrale**. L’obiettivo è analizzare il comportamento della rete in termini di **comunicazione**, **temporizzazione**, **schedulazione** e **prestazioni di controllo**, sfruttando le potenzialità di **MATLAB**, **Simulink** e del toolbox **TrueTime**.

Il documento ha un tono generale e introduttivo: fungerà da base per la strutturazione del progetto man mano che esso prenderà forma.

---

## 🎯 Obiettivi del progetto

* Definire un’architettura modulare per una rete distribuita di sensori e attuatori.
* Simulare il comportamento temporale e comunicativo dei nodi con TrueTime.
* Analizzare metriche come latenza, throughput e robustezza.
* Studiare strategie di scheduling e protocolli di rete real-time.

---

## 🧩 Architettura generale

1. **Nodi sensore** → raccolgono dati ambientali (es. temperatura, pressione, stato digitale) e li inviano periodicamente o su evento.
2. **Nodi controllore** → ricevono dati dai sensori, elaborano logiche di controllo e inviano comandi.
3. **Nodi attuatore** → eseguono azioni simulate in base ai comandi ricevuti.
4. **Gateway centrale** → gestisce la comunicazione, l’instradamento e l’interfaccia di monitoraggio.

Ogni nodo sarà rappresentato in **Simulink/TrueTime** con parametri di rete configurabili (latenza, banda, errori, priorità, ecc.).

---

## 🧰 Strumenti e tecnologie

* **MATLAB** → sviluppo e analisi.
* **Simulink** → modellazione a blocchi e integrazione.
* **TrueTime** → simulazione real-time e comunicazione distribuita.
* **Git** (consigliato) → versionamento e collaborazione.

---

## ⚙️ Setup iniziale (livello alto)

> I dettagli tecnici verranno definiti successivamente, in base alla configurazione dell’ambiente.

1. Installare **MATLAB** e **Simulink** con licenze valide.
2. Installare il toolbox **TrueTime** compatibile con la versione di MATLAB.
3. Clonare il repository (quando disponibile).
4. Aprire il modello principale in Simulink e configurare i parametri di rete.

---

## 🤝 Collaborazione e contributi

Il progetto è pensato per essere sviluppato in **team**: ogni componente è modulare per favorire il lavoro parallelo e l’integrazione graduale. Si raccomanda l’uso di **branch dedicati**, **commit descrittivi** e **documentazione chiara** per ogni nuova funzionalità.

---

<h2 align="center">✨ Autori</h2>

<p align="center">
  <strong>Giovanni Giuseppe Iacuzzo</strong><br>
  <em>Studente di Ingegneria Dell'IA e della CyberSecurity · Università degli Studi Kore di Enna</em>
</p>

<p align="center">
  <a href="https://github.com/giovanniIacuzzo" target="_blank">
    <img src="https://img.shields.io/badge/GitHub-%40giovanni Iacuzzo-181717?style=for-the-badge&logo=github" alt="GitHub"/>
  </a>
  <a href="mailto:giovanni.iacuzzo@unikorestudent.com">
    <img src="https://img.shields.io/badge/Email-Contattami-blue?style=for-the-badge&logo=gmail" alt="Email"/>
  </a>
</p>

<p align="center">
  <strong>Chiara Maria Milazzo</strong><br>
  <em>Studente di Ingegneria Informatica · Università degli Studi Kore di Enna</em>
</p>

<p align="center">
  <a href="https://github.com/chiaram02" target="_blank">
    <img src="https://img.shields.io/badge/GitHub-%40Chiara Milazzo-181717?style=for-the-badge&logo=github" alt="GitHub"/>
  </a>
  <a href="mailto:chiara.milazzo@unikorestudent.com">
    <img src="https://img.shields.io/badge/Email-Contattami-blue?style=for-the-badge&logo=gmail" alt="Email"/>
  </a>
</p>

---

> 🚧 *Progetto attualmente in fase di sviluppo. Aggiornamenti e dettagli saranno aggiunti man mano che la simulazione prende forma.*
