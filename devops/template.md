---
header: "DevSecOps"
theme: gaia
size: 16:9
marp: true
paginate: false
style: |
  @font-face {
    font-family: 'CG-bold';
    src: url('./fonts/GOTHICB.TTF') format('truetype');
  }
  section::after {
    font-size: 0.45em;
    font-weight: 900;
    margin-right:26px;
    margin-bottom:-0.15em;
    font-family: CG-bold;
  }
---
<!--START style -->
<style>
  @font-face {
    font-family: 'CG';
    src: url('./fonts/CenturyGothic.ttf') format('truetype');
  }
  @font-face {
    font-family: 'CG-bold';
    src: url('./fonts/GOTHICB.TTF') format('truetype');
  }
  :root 
  {
    --color-background: #fff;
    --color-foreground: #333;
    --color-highlight: #f96;
    --color-dimmed: #888;
  }
  h1 {color: #ffba3a; padding-top:0.1em;}
  section {background-image: url(default/template.svg); background-size:cover;  font-family:CG; color:#4d4d4d;}
  p{font-size:0.7em; font-family:CG; text-align:justify;}
  footer {margin-bottom:1.8%; padding:0; height:5%; font-family:CG; text-align:center; color:black; font-size:0.3em;}
  header {color:#4d4d4d; padding:30px; margin-left:30px; font-size:0.6em;}
  pre {font-size: 0.6em; border: none;}
  ul li {font-size:0.7em; font-family:CG; text-align:justify;}
  ol li {font-size:0.7em; font-family:CG; text-align:justify;}
  table{font-size:0.5em; font-family:CG;}
  th{background:#005366 !important; }
  h5 {text-align:center;}

  
</style>
<!--END style -->

<style scoped>
    header{display:none;}
    footer{display:none;}
    section {background-color:white; }    
</style>
<!-- INTRO -->
<!-- paginate: false -->
![bg](default/start.svg)

---
<!-- paginate: true -->
<!-- header: '' -->
#
#
#
#
#
#
#
##### Esigenza

---
<!-- header: '**Esigenza** $\color{#ffba3a}{|}$  _Sviluppo sicuro_' -->
![bg contain](resources/esigenza.svg)
#
#
- Nel 2022 ci sono stati in tutto il mondo **2.479**  attacchi informatici;
- Nel 2023 il numero di attacchi è cresciuto del **+12%**;
- Il **56%** deglli attacchi  ha avuto conseguenze di gravità critica o elevata.


---
<!-- paginate: true -->
<!-- header: '' -->
#
#
#
#
#
#
#
##### Contesto

---
<style scoped>
li 
{
  text-align:left;
  padding-right: 10%;
  line-height: 1.5em;
}

</style>

<!-- header: '**Contesto** $\color{#ffba3a}{|}$  _DevOps secondo Gartner_' -->
#
![bg contain](resources/devops-gartner.svg)

---
<!-- header: '**Contesto** $\color{#ffba3a}{|}$  _Toolchain_' -->
#
![bg contain](resources/devops.svg)

---
<!-- paginate: true -->
<!-- header: '' -->
#
#
#
#
#
#
#
##### DevSecOps in pratica

---
<!-- header: '**DevSecOps in pratica** $\color{#ffba3a}{|}$  _Architettura_' -->
#
![bg contain](resources/architettura.svg)

---
<!-- header: '**DevSecOps in pratica** $\color{#ffba3a}{|}$  _Architettura_' -->
#
#
**Sviluppo locale**
- Il developer scrive codice per l'applicativo Accounts.
- Il developer Utilizza [Snyk CLI](https://docs.snyk.io/snyk-cli) per l'analisi SAST/SCA.

**Gestione del codice**
- Il codice è versionato in un bare repository su [GitHub](https://github.com/).
- Una GitHub Action verifica la code coverage nelle pull request.

**Build e rilascio**
- Dopo il merge su main, una [GitHub Action](https://github.com/features/actions) crea la release.
- L'immagine dell'applicativo viene pubblicata su [Docker Hub](https://hub.docker.com/).

---
<!-- header: '**DevSecOps in pratica** $\color{#ffba3a}{|}$  _Architettura_' -->
#
#
**Deploy automatizzato**
- Una GitHub Action esegue il deploy su [Render.com](https://render.com/) via [API](https://api-docs.render.com/reference/create-deploy).
- Render.com avvia un [web service](https://render.com/docs/web-services) basato sull'immagine Docker.

**Gestione dei secret**
- Le credenziali di accesso e altri parametri sensibili sono gestiti con [Render Secrets](https://render.com/docs/configure-environment-variables).
- I secret vengono passati automaticamente all’applicativo durante il deploy.

**Accesso alle API**
- Il client può interagire con le API del web service.

---

<style scoped>
  section {background-color:white; }
</style>
<!-- END -->
<!-- header: ''-->
<!-- paginate:  -->
#
![bg](default/end.svg)