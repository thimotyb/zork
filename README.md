# Zork I Play Instructions

This workspace already contains everything you need to play the newly open-licensed release of **Zork I** using the Frotz interpreter.

## Contents
- `frotz/`: local clone of the Frotz interpreter source tree.
- `frotz/build/dfrotz`: statically built dumb-terminal interpreter (ncurses-free, ideal for plain terminals).
- `zork1/`: official source drop of Zork I from the Historical Source archives. The compiled story file lives in `zork1/COMPILED/zork1.z3`.
- `play-zork1.sh`: helper script that wires the interpreter and story file together.

## Playing the Game
1. From the repository root run:

   ```bash
   ./play-zork1.sh
   ```

   The script verifies both the interpreter binary and the Z-machine story file before invoking Frotz, so you can focus on playing. Any additional options you provide will be passed directly to `dfrotz`; for example:

   ```bash
   ./play-zork1.sh -S 72    # wrap transcripts at 72 columns
   ./play-zork1.sh -i       # ignore fatal runtime errors
   ```

2. Interact with the game as normal (`look`, `north`, etc.).
3. Quit with `quit` followed by `y` when prompted.

Prefer a green-on-black “phosphor” vibe? Launch via `./play-zork1-green.sh` instead. It temporarily sets OSC 10/11 colors to a bright green foreground on black background and restores your defaults on exit. Override the colors if needed by exporting `ZORK_GREEN_*` variables (e.g., `ZORK_GREEN_FG=#7fff6e`).

## Rebuilding Frotz (optional)
A prebuilt interpreter is provided, but you can regenerate it with the bundled Zig compiler toolchain (stored under `downloads/zig-linux-x86_64-0.13.0`). From the repo root run:

```bash
./scripts/ensure-zig.sh
cd frotz
../downloads/zig-linux-x86_64-0.13.0/zig cc \
  -std=c99 -D_POSIX_C_SOURCE=200809L -Wall -g -fcommon -fwrapv \
  -Isrc/common -Isrc/dumb -Isrc/blorb -Isrc \
  -o build/dfrotz src/common/*.c src/dumb/*.c src/blorb/*.c -lm
```

This mirrors the build that produced the checked-in `dfrotz`. The Zig compiler acts as a drop-in replacement for GCC/Clang in this environment.

## Using Other Zork Releases
The Microsoft OSPO blog links similar repositories for Zork II and III. To add them:
1. Clone the repo (e.g., `git clone https://github.com/historicalsource/zork2.git`).
2. Point `play-zork1.sh` at the desired `COMPILED/*.z3` file or duplicate the script and adjust the story path.
3. Launch the game via the adjusted script.

## Troubleshooting
- **`Frotz interpreter not found`**: rebuild using the command above or ensure `frotz/build/dfrotz` still exists.
- **`Zork I story file not found`**: confirm `zork1/COMPILED/zork1.z3` is present. Re-clone `zork1` if needed.
- To capture transcripts and saves, use Frotz’s built-in commands (`script`, `save`, `restore`). Saved files are created relative to the working directory.
- **`Illegal instruction (core dumped)` when certain actions run**: rebuild using the command above. The `-fwrapv` flag disables Zig/Clang’s default signed-overflow traps so Frotz’s RNG can wrap as originally intended.

Enjoy exploring the Great Underground Empire!
