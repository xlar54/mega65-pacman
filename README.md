# Pac-Man 65

Pac-Man 65 is a Pac-Man-style game written in BASIC 65 for the MEGA65. It uses
hardware sprites for Pac-Man, the ghosts, score popups, and level bonus items,
along with custom character definitions for the maze and status display.

## Features

- Four ghosts with scatter, chase, frightened, eaten, and ghost-house behavior.
- Power pellets, ghost combos, an extra life at 10,000 points, and multiple
  levels.
- Bonus items that appear after 70 and 170 pellets on every maze.
- A persistent top-ten leaderboard stored as a sequential disk file.
- An attract screen that alternates between the character roster and high
  scores every three seconds.
- Keyboard or joystick start controls and a blinking start prompt.

## Controls

- Move Pac-Man with the joystick directional controls.
- Press joystick fire or any keyboard key to start from the attract screen.

## Bonus items

Each bonus item remains visible for approximately nine seconds or until Pac-Man
collects it. The bottom-right status row shows the current and recent level
items.

| Item | Levels | Points |
|---|---:|---:|
| Cherry | 1 | 100 |
| Strawberry | 2 | 300 |
| Orange | 3-4 | 500 |
| Apple | 5-6 | 700 |
| Melon | 7-8 | 1,000 |
| Galaxian flagship | 9-10 | 2,000 |
| Bell | 11-12 | 3,000 |
| Key | 13+ | 5,000 |

## Building

Run:

```bat
build.bat
```

The build performs the following steps:

1. Tokenizes `src\pacman.bas` as a BASIC 65 program using `petcat`.
2. Applies fixes for newer BASIC 65 tokens that VICE `petcat` does not emit.
3. Creates `target\pacman.prg` with a `$2001` load address.
4. Creates `target\pacman.d81` containing `PACMAN` and the `SCORES` SEQ file.

The build requires:

- Python 3 available as `python` or `py`.
- `petcat.exe` on `PATH`, or in the sibling `..\basic65-compiler` repository.
- The bundled `c1541.exe` disk-image tool.

Running the build recreates the D81 and installs the sample `src\scores.seq`
leaderboard.

## Running

Run:

```bat
run.bat
```

This rebuilds the game and launches `target\pacman.d81` in Xemu with autoload
enabled. `run.bat` currently expects Xemu at:

```text
C:\Emulation\Mega65\xmega65.exe
```

Update that path if Xemu is installed elsewhere.

## High scores

At startup, the game reads `SCORES` from the D81 and sorts the ten highest
entries. If the file is missing or contains no valid records, the attract screen
shows `NO SCORES YET`.

After game over, a score that qualifies for the top ten prompts for a player
name. Names are converted to uppercase and commas are replaced with spaces. The
game then rewrites `SCORES` in descending score order.

Each SEQ record is comma-delimited:

```text
PACMAN, 12-OCT-2026 10:30:00, 200
```

The timestamp combines the BASIC 65 built-in `DT$` date and `TI$` time values.

## Project layout

| Path | Purpose |
|---|---|
| `src\pacman.bas` | Game source, sprite patterns, character definitions, and disk-score logic |
| `src\scores.seq` | Sample leaderboard copied onto new disk images |
| `tools\fix_basic65_petcat_tokens.py` | Post-processes tokenized BASIC for missing BASIC 65 tokens |
| `build.bat` | Builds the PRG and D81 image |
| `run.bat` | Builds and launches the game in Xemu |
| `target\pacman.prg` | Generated tokenized BASIC program |
| `target\pacman.d81` | Generated MEGA65 disk image |
