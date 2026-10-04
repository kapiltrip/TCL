# Tcl/Tk practice

Tcl/Tk practice scripts, day-wise study notes, and assignment reviews. Use Tcl for scripts and Tk for graphical programs.

The local practice folder is configured with a portable **Tcl/Tk 8.6.18 for Windows x64** runtime from [Magicsplat Tcl/Tk for Windows](https://www.magicsplat.com/tcl-installer/), a distribution listed by the [Tcl project](https://www.tcl-lang.org/software/tcltk/bindist.html). Downloaded executables and libraries stay local; the repository tracks the runtime's [installation details](runtime/installation.json).

## Days 1–3 study files

| Day | Topics | Code and notes | Assignment review |
| --- | --- | --- | --- |
| 1 | Variables, substitution, comments, saving scripts | [Day 1 Code](assignments/Day%201/Day%201%20Code.md) | [Assignments 1–5](assignments/Day%201/Day%201%20Assignments.md) |
| 2 | Grouping, string tests, indexing, matching, transformations | [Day 2 Code](assignments/Day%202/Day%202%20Code.md) | [Assignments 6–10](assignments/Day%202/Day%202%20Assignments.md) |
| 3 | Expressions, logical and bitwise operations, units and rounding | [Day 3 Code](assignments/Day%203/Day%203%20Code.md) | [Assignments 11–16](assignments/Day%203/Day%203%20Assignments.md) |

Assignments 1–16 have numeric drafts entered in dedicated Chrome tabs for Kapil to review and submit. The review files include screenshots and complete code; no assignment was submitted by Codex.

## Start practicing

The launchers below use `runtime/bin` and `runtime/lib` in the local practice folder. For a fresh clone, prepare that runtime layout first, or run the `.tcl` examples with an existing Tcl/Tk installation.

- Double-click [start-tcl.cmd](start-tcl.cmd) to open an interactive Tcl console.
- Double-click [start-gui.cmd](start-gui.cmd) to open the Tk greeting example.

In the Tcl console, try:

```tcl
puts "Hello, Kapil!"
set a 12
set b 8
puts [expr {$a + $b}]
source examples/hello.tcl
```

Type `exit` to close the console. Tcl commands go in the Tcl console; the commands below go in PowerShell.

## Run and edit scripts

Open PowerShell in this folder and run:

```powershell
# Console example
.\tclsh.cmd .\examples\hello.tcl

# GUI example
.\wish.cmd .\examples\hello-gui.tcl

# Your own script, saved as my-script.tcl
.\tclsh.cmd .\my-script.tcl
```

Edit [hello.tcl](examples/hello.tcl) to practice variables, expressions, procedures, and loops. Edit [hello-gui.tcl](examples/hello-gui.tcl) to practice widgets and button callbacks. You can use a code editor or Notepad; save scripts with the `.tcl` extension.

## Runtime and Vivado

Keep your scripts outside `runtime/`, which contains the interpreter, libraries, packages, and licenses. The launchers configure Tcl for their own process. Setup details and the downloaded installer's SHA-256 are recorded in [installation.json](runtime/installation.json).

For general Tcl/Tk exercises, work here. Vivado 2024.1 is already present at `C:\Xilinx\Vivado\2024.1`. Use its Tcl console when you need FPGA commands such as `create_project` or `synth_design`; those commands belong to Vivado's environment. See [AMD's Tcl shell documentation](https://docs.amd.com/r/2025.1-English/ug895-vivado-system-level-design-entry/Launching-the-Vivado-Design-Suite-Tcl-Shell).
