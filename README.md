# Claude Queue System (cl)

A lightweight, centralized queue system for Claude CLI that allows sequential execution of prompts in the background without cluttering your project directories.

## English Version

### Install
After cloning the repository, run the following command to set up the alias and initial configuration:
```bash
source ./bin/cl -c
```
This will:
1. Create the `storage/` directory.
2. Add the `cl` alias to your `~/.bashrc`.
3. Activate the alias in your current terminal session.

### Features
- **Background Execution:** Prompts are added to a queue and executed one by one.
- **Clean Projects:** No logs, queues, or lock files are created in your working directories.
- **Centralized Storage:** All data is stored in the `storage/` directory of the `claude-queue` project, organized by project path hashes.
- **Live Logs:** View progress in real-time with full scrolling support.
- **Interactive Mode:** Ability to jump into a full interactive session when the queue is free.

### Usage
- `cl "your prompt"` - Adds a task to the queue and returns to the terminal immediately.
- `cl` - Opens the log file for the current project in "follow" mode (`less +F`).
    - **Scroll:** Press `Ctrl+C` to stop following and use arrow keys to scroll.
    - **Resume Follow:** Press `Shift+F` to start following live output again.
    - **Quit:** Press `q` to return to your bash prompt.
- `cl -s` - Shows the current status of the worker and the queue for the current project.
- `cl -p` - Displays the full path to the storage and log file for the current project.
- `cl -i` - Waits for the queue to empty and starts an interactive Claude session.
- `cl -c` - Sets up the `cl` alias and initializes the central configuration.
- `cl -h` - Shows the help message.

### Configuration
You can customize Claude's flags in the `example.cl.conf` (global template) or in the central `.cl.conf` located in each project's storage directory (accessible via `cl -p`). Local `.cl.conf` in your working directory is also supported as an override.

---

## Česká verze

### Instalace
Po naklonování repozitáře spusťte následující příkaz pro nastavení aliasu a počáteční konfigurace:
```bash
source ./bin/cl -c
```
Tento příkaz:
1. Vytvoří adresář `storage/`.
2. Přidá alias `cl` do vašeho `~/.bashrc`.
3. Aktivuje alias v aktuální relaci terminálu.

### Funkce
- **Spouštění na pozadí:** Prompty jsou přidávány do fronty a vykonávány jeden po druhém.
- **Čisté projekty:** Ve vašich pracovních adresářích se nevytvářejí žádné logy, fronty ani zámky.
- **Centralizované úložiště:** Všechna data jsou uložena v adresáři `storage/` v projektu `claude-queue`, organizovaná podle hashe cesty projektu.
- **Živé logy:** Sledujte průběh v reálném čase s plnou podporou skrolování.
- **Interaktivní režim:** Možnost spustit plně interaktivní relaci, jakmile se fronta uvolní.

### Použití
- `cl "váš prompt"` - Přidá úlohu do fronty a okamžitě vám vrátí kontrolu nad terminálem.
- `cl` - Otevře soubor s logy pro aktuální projekt v režimu "sledování" (`less +F`).
    - **Skrolování:** Stiskněte `Ctrl+C` pro zastavení sledování a použijte šipky.
    - **Pokračovat ve sledování:** Stiskněte `Shift+F` pro opětovné živé sledování.
    - **Ukončit:** Stiskněte `q` pro návrat do bashe.
- `cl -s` - Zobrazí aktuální stav workeru a fronty pro aktuální projekt.
- `cl -p` - Zobrazí úplnou cestu k úložišti a logovacímu souboru pro aktuální projekt.
- `cl -i` - Počká na vyprázdnění fronty a spustí interaktivní sezení s Claudem.
- `cl -c` - Nastaví alias `cl` a inicializuje centrální konfiguraci.
- `cl -h` - Zobrazí nápovědu.

### Konfigurace
Vlajky (flags) pro Claude můžete upravit v `example.cl.conf` (globální šablona) nebo v centrálním `.cl.conf` umístěném v úložišti každého projektu (cesta k němu přes `cl -p`). Podporován je i lokální `.cl.conf` přímo ve vašem pracovním adresáři jako prioritní nastavení.
