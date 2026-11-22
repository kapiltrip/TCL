# Day 9 — File Paths, `glob` & File I/O

[← Attempt 2](../README.md) · [day-9.tcl](../day-9.tcl) · [timing.txt](../timing.txt) · [← Day 8](day-8.md)

## Definitions

- **Channel (`fileId`)**: An opaque Tcl I/O handle (e.g. `file1a2b3c`) returned by `open`, wrapping an OS file descriptor, a read/write cursor, an internal buffer, and automatic newline translation (`\r\n` ↔ `\n`). `stdin`, `stdout`, and `stderr` are pre-opened channels.
- **Path Operations vs Filesystem Operations (`file`)**: Pure path helpers (`dirname`, `tail`, `rootname`, `extension`, `split`, `join`, `nativename`) manipulate path strings without touching disk. Filesystem ops (`mkdir`, `delete`, `copy`, `rename`) and queries (`exists`, `isfile`, `isdirectory`, `readable`, `size`) interact with the OS.
- **Argument Expansion (`{*}`)**: Syntax prefix that unpacks a single list value into separate command arguments before execution (`file join {*}{C:/ a b}` → `file join C:/ a b`).
- **Globbing (`glob`)**: Filesystem wildcard search (`*`, `?`, `{.tcl,.txt}`) returning a list of matching paths. Unlike Unix shells, Tcl does **not** expand `*` automatically in other commands — `glob` must be called explicitly. Throws an error on 0 matches unless `-nocomplain` is passed.
- **Open Modes (`r`, `w`, `a`)**: `"r"` reads existing file from byte 0 (errors if missing); `"w"` creates or **truncates** to 0 bytes; `"a"` creates or forces every write to append at EOF without erasing existing content.
- **EOF (End of File) & `gets` vs `read`**: `read $fid` loads the entire remaining stream into memory; `gets $fid line` reads one line (stripping `\r\n`/`\n`), stores it in `line`, and returns character count (`0` for a blank line, `-1` at EOF).

## Path, `glob` & Filesystem Reference

Use forward slashes `/` even on Windows (`C:/Users/.../timing.txt`) to avoid `\\` escaping, or assemble paths with `file join`.

| Command | Mechanism | Example |
| --- | --- | --- |
| `file dirname $p` / `tail $p` / `rootname $p` | Parent dir / final filename / path minus extension | `file rootname a/b.tcl` → `a/b` |
| `file nativename $p` | Converts `/` to OS-native separator (`\` on Windows) | `file nativename C:/a/b` → `C:\a\b` |
| `file split $p` / `file join {*}$parts` | Splits path into list of segments / rejoins with OS rules | `file join {*}$lista` |
| `glob ?opts? pat` | Returns matching file list (`*{.tcl,.txt}`, `-types f\|d`, `-nocomplain`, `-directory $dir *`) | `glob -nocomplain *.c` → `{}` |
| `file mkdir dir` | Creates `dir` and any missing parent directories | `file mkdir Temp_folder` |
| `file delete ?-force? path...` | Removes files/dirs (`-force` required for non-empty dir); no implicit globbing | `file delete {*}[glob -nocomplain *.txt]` |
| `file copy src dst` / `file rename src dst` | Copies or moves/renames files (add `-force` to overwrite existing `dst`) | `file rename old.tcl new.tcl` |
| `file exists` / `isfile` / `isdirectory` / `readable` / `size` | Boolean (`1`/`0`) checks and byte length | `file size day-1.tcl` |

## File I/O Patterns & Buffering

```tcl
# 1. Line-by-line streaming (preferred for logs / STA timing reports)
set total_paths 0
set violation_count 0
set fid [open $file_path r]
while {[gets $fid line] >= 0} {
    incr total_paths
    if {[regexp {viol\w+} $line]} {
        incr violation_count
    }
}
close $fid

# 2. Whole-file read vs append write
set fid [open $file_path r]
set data [read $fid]          ;# or [read $fid 6] for first 6 chars
close $fid

set fid [open $file_path a]
puts $fid $line               ;# writes line + newline
puts -nonewline $fid $line    ;# writes without trailing newline
close $fid                    ;# flushes write buffer & releases OS handle
```

### Mechanical Notes (`day-9.tcl:50-70` & [timing.txt](../timing.txt))

- **Why `gets` tests `>= 0` (not `> 0`)**: A blank line has length `0`, while true EOF returns `-1`. Using `> 0` terminates prematurely on the first empty line.
- **Why `close $fid` is mandatory**: `puts $fid ...` writes into an in-memory buffer first; `close` flushes pending bytes to disk and frees the OS file descriptor.
- **Trace on [timing.txt](../timing.txt)**: Across the original 5 STA paths, `regexp {viol\w+}` matches Paths 1, 3, and 5 (`Setup violation`, `Hold violation`, `Setup violation` → `violation_count = 3`, `total_paths = 5`). Running lines 66–70 (`open ... "a"` + `puts -nonewline`) appended onto line 5 without a newline and added line 6 (making `total_paths = 6` on later reads).
- **Why `file delete *.txt` fails**: Tcl passes the literal word `"*.txt"` to `file delete`. Combining `glob` + `{*}` (`file delete {*}[glob -nocomplain *.txt]`) first builds the matched filename list and then unpacks it into individual arguments.

## Traps & Fixes (from [day-9.tcl](../day-9.tcl))

| Trap | Why | Fix |
| --- | --- | --- |
| `file dirname file_path` (`day-9.tcl:4`) | Missing `$` passes literal `"file_path"` instead of the stored path | Write `file dirname $file_path` |
| `glob -directory file_path` (`day-9.tcl:17`) | Missing `$` and missing required pattern argument | Write `glob -directory $file_path *` |
| `file delete *.txt` (`day-9.tcl:22`) | `file delete` does not glob-expand; searches for a file literally named `*.txt` | Use `file delete {*}[glob -nocomplain *.txt]` |
| `#close $fileId` commented out (`day-9.tcl:36`) | Leaks the OS channel handle and may leave write buffers unflushed | Always `close $fileId` when done |
| `llength $data` / `lindex $data 6` on raw file text (`day-9.tcl:38-39`) | Treats arbitrary text as a Tcl list; throws `unmatched open quote/brace` on real files | Split lines explicitly (`split $data "\n"`) or stream with `gets` |
| `puts -nonewline $fileId $data` in `"a"` mode (`day-9.tcl:69`) | Concatenates directly onto the last line when no trailing newline exists (`timing.txt:5-6`) | Use `puts $fileId $data` when appending line-based records |

## Quick Recall

1. Why does `file delete *.txt` do nothing instead of deleting `.txt` files, and how does `{*}` fix it?
2. Why is `[gets $fid line] >= 0` required instead of `[gets $fid line] > 0`?
3. Why can running `llength $data` on `[read $fid]` crash on ordinary text files?

<details>
<summary>Answers</summary>

1. Tcl never auto-expands `*` in command arguments; `glob -nocomplain *.txt` returns a list of matching paths and `{*}` unpacks that list into individual arguments for `file delete`.
2. Empty lines return `0` while EOF returns `-1`; `> 0` would stop early on the first blank line.
3. `llength` parses the string using Tcl list syntax, which errors if the file contains unmatched quotes `"` or braces `{}`.

</details>

## Tcl 8.6 Reference

- [file(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/file.htm) · [glob(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/glob.htm) · [open(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/open.htm) · [read(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/read.htm) · [gets(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/gets.htm) · [puts(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/puts.htm) · [close(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/close.htm)
