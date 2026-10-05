# What I did: Tcl and VS Code setup

This records the setup work in `C:\Users\kapil\OneDrive\Desktop\TCL` on 5 October 2026. You can now write `.tcl` files in this folder, run them from PowerShell, and use the configured VS Code task or Tcl terminal profile.

The folder already contained portable Tcl/Tk 8.6.18 in `internal/runtime/`. I reused that interpreter and the existing launchers in `internal/scripts/`. The runtime details are recorded in [installation.json](internal/runtime/installation.json).

[How to run](#how-to-run-your-code) · [Files changed](#files-created-or-changed) · [VS Code settings](#what-i-configured-in-vs-code) · [Example file](#the-example-file) · [Verification](#what-i-verified)

## How to run your code

### From PowerShell

Open this folder in VS Code and choose **Terminal → New Terminal**. In a PowerShell terminal, enter:

```powershell
cd "C:\Users\kapil\OneDrive\Desktop\TCL"
.\tclsh.cmd .\practice.tcl
```

The first line selects this folder. The second starts Tcl and runs the saved code in `practice.tcl`, from top to bottom. The namespace version saved when this setup record was first written printed:

```text
8.6
Hello world
```

For another program, replace `practice.tcl` with its filename. For example:

```powershell
.\tclsh.cmd .\proj1.tcl
```

After editing a program, press **Ctrl+S** to save it and run the command again. Save new programs with the `.tcl` extension.

### With the VS Code shortcut

1. Open the `TCL` folder itself in VS Code so it loads the `.vscode` configuration.
2. Open the `.tcl` file you want to run and keep it as the active editor tab.
3. Press **Ctrl+S**, then **Ctrl+Shift+B**.
4. Read the output in the task terminal.

The configured task is named **Tcl: Run current file**. It runs the active saved file. The working directory is the outermost `TCL` folder, including when the file is inside a subfolder.

### At an interactive Tcl prompt

From PowerShell, start Tcl with:

```powershell
.\tclsh.cmd
```

When the prompt is `%`, enter Tcl commands directly:

```tcl
puts "Hello"
set a 10
puts [expr {$a + 5}]
source practice.tcl
```

`source practice.tcl` runs the file inside the current Tcl session. Enter `exit` to return to PowerShell. You can also choose **Tcl** from VS Code's new-terminal profile menu to open a Tcl prompt directly.

In a **new VS Code PowerShell terminal** opened after the workspace settings load, these shorter commands also work:

```powershell
tclsh .\practice.tcl
tclsh
```

The root-level `.\tclsh.cmd` launcher also works in an ordinary PowerShell terminal opened outside VS Code, when its current directory is this folder.

## Files created or changed

| File | Work done | Purpose |
| --- | --- | --- |
| [tclsh.cmd](tclsh.cmd) | Created at the outermost level | Runs the existing Tcl launcher without requiring its longer `internal/scripts/` path. |
| [.vscode/settings.json](.vscode/settings.json) | Created | Sets the terminal working directory, local Tcl environment, and Tcl terminal profile for this workspace. |
| [.vscode/tasks.json](.vscode/tasks.json) | Created | Defines the default task that runs the active file with **Ctrl+Shift+B**. |
| [proj1.tcl](proj1.tcl) | Renamed from `proj1.tcl.txt` | Gives your existing program the `.tcl` extension; its contents were preserved. |
| [practice.tcl](practice.tcl) | Created, then edited by you | Initially supplied a greeting and addition example; now contains your namespace exercise. |
| [README.md](README.md#run-the-code) | Updated | Explains the root launcher, interactive commands, VS Code task, and terminal profile. |
| [what-i-did.md](what-i-did.md) | Created | Keeps this setup record at the outermost level. |
| [AGENTS.md](AGENTS.md) | Created after your commit instruction | Records the repository workflow: verify, commit, and push after each completed editing task. |

The root launcher checks that `internal/runtime/bin/tclsh.exe` exists, calls `internal/scripts/tclsh.cmd`, passes along the filename and arguments, and returns Tcl's exit code. Its environment changes last only for that invocation.

## What I configured in VS Code

### Terminal settings

These are stored in [.vscode/settings.json](.vscode/settings.json). `${workspaceFolder}` means the folder opened as the VS Code workspace: this outermost `TCL` directory.

| Setting | Value or effect |
| --- | --- |
| `terminal.integrated.cwd` | Starts terminals in `${workspaceFolder}`. |
| `PATH` under `terminal.integrated.env.windows` | Places `internal/runtime/bin` before the existing terminal PATH so `tclsh` finds the local interpreter. |
| `TCL_LIBRARY` | Points to `internal/runtime/lib/tcl8.6`, which supplies Tcl's library files. |
| `TK_LIBRARY` | Points to `internal/runtime/lib/tk8.6` for Tk library files. |
| `TCLLIBPATH` | Removes an inherited value from the workspace terminal environment. |
| Terminal profile `Tcl` | Starts `internal/runtime/bin/tclsh.exe` directly. |
| Profile `overrideName` | Keeps the terminal title as `Tcl`. |

The PATH setting applies to terminals created for this workspace. Open a new terminal after loading the settings to use it. The profile adds a **Tcl** choice to the terminal menu; your usual default terminal profile still controls ordinary new terminals. See VS Code's [terminal profile documentation](https://code.visualstudio.com/docs/terminal/profiles) for the configuration format.

### Run task

These are stored in [.vscode/tasks.json](.vscode/tasks.json):

- **Task label:** `Tcl: Run current file`.
- **Task type:** `process`, starting the local `tclsh.exe` directly.
- **Program argument:** `${file}`, the full path of the active saved file.
- **Working directory:** `${workspaceFolder}`.
- **Environment:** the local Tcl and Tk library paths, with an empty `TCLLIBPATH`.
- **Shortcut:** the task is the default build task, used by **Ctrl+Shift+B**.
- **Output display:** the terminal is revealed, its previous output is cleared, and the task uses a shared panel with the terminal-reuse message hidden.
- **Problem matcher:** an empty list; Tcl errors remain visible as terminal output.

Save the `.tcl` file before running the task, because it executes the copy stored on disk. See VS Code's [task documentation](https://code.visualstudio.com/docs/debugtest/tasks) for how default build tasks work.

## The example file

I initially created [practice.tcl](practice.tcl) with this complete starter program:

```tcl
# Run from PowerShell in this folder:
# .\tclsh.cmd .\practice.tcl

puts "Hello, Kapil!"

# Change these numbers, save the file, and run it again.
set a 10
set b 20
puts "$a + $b = [expr {$a + $b}]"
```

That starter printed:

```text
Hello, Kapil!
10 + 20 = 30
```

`puts` prints text. `set` stores the two numbers in variables. `expr` adds them, and the surrounding square brackets insert the result into the printed message.

During setup documentation, you replaced the starter body with namespace practice using `n1::print` and `n1::n2::print`. Your edits were preserved. The launcher and VS Code task run whichever code you have saved in the file, so its output changes as you continue practicing.

## What I verified

| Check | Result |
| --- | --- |
| Run `proj1.tcl` through the root launcher | Printed `Hello world`. |
| Run the original `practice.tcl` starter through the root launcher | Printed the greeting and `10 + 20 = 30`. |
| Rerun your edited `practice.tcl` while documenting the setup | Printed `8.6` and `Hello world`. |
| Enter Tcl commands through the launcher | Reported Tcl `8.6.18`, evaluated an expression to `15`, and sourced `proj1.tcl`. |
| Forward Tcl's exit status | `exit 7` produced process exit code `7`. |
| Execute the command and environment defined in the VS Code task | Successfully ran `proj1.tcl`. |
| Resolve bare `tclsh` with the workspace terminal environment | Successfully ran `proj1.tcl`. |
| Start the configured Tcl profile executable | Reported Tcl `8.6.18`. |
| Rename the original program | Its SHA-256 hash matched before and after the rename. |

The configured task command and terminal environment were tested through shell commands. The VS Code shortcut and profile menu have not been exercised through the editor UI.

A local README preview was also created at `internal/.qa/tcl-run-preview.html`. The Chrome preview attempt failed because the browser-control connection could not load its request-header policy. This setup record was rendered locally to page images for a visual check. Preview files stay in the Git-ignored `.qa` folder.

This setup consists of workspace-local files and uses the interpreter that was already here. No VS Code extension or system-wide Tcl installation was added. Your later instruction to commit after each completed editing task is recorded in [AGENTS.md](AGENTS.md); the workflow includes pushing the current branch to the existing GitHub remote.
