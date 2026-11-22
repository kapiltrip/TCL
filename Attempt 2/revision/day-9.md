# Day 9 — File Paths, `glob` & File I/O

[← Attempt 2](../README.md) · [day-9.tcl](../day-9.tcl) · [timing.txt](../timing.txt) · [← Day 8](day-8.md)

## Path Rule

Use forward slashes `/` even on Windows (`C:/Users/.../timing.txt`) to avoid `\\` escaping, or construct paths with `file join`.

## Path & Filesystem Commands

| Command | Behavior | Example |
| --- | --- | --- |
| `file dirname $p` / `file rootname $p` | Parent folder / path without extension | `file rootname a/b.tcl` → `a/b` |
| `file nativename $p` | Converts `/` to OS-native separators (`\` on Windows) | `file nativename C:/a/b` → `C:\a\b` |
| `file split $p` / `file join {*}$parts` | Splits path into list / joins list back (`{*}` unpacks list args) | `file join {*}$lista` |
| `glob ?opts? pat` | Lists matching files (`*{.tcl,.txt}`, `-types f`, `-nocomplain`, `-directory $dir *`) | `glob -nocomplain *.c` → `{}` |
| `file mkdir dir` | Creates directory (and missing parents) | `file mkdir Temp_folder` |
| `file delete ?-force? path...` | Deletes files/dirs (`-force` for non-empty dir); does **not** expand `*` | `file delete {*}[glob -nocomplain *.txt]` |
| `file copy src dst` / `file rename src dst` | Copies or moves/renames files | `file rename old.tcl new.tcl` |
| `file exists` / `isfile` / `isdirectory` / `readable` / `size` | Boolean (`1`/`0`) checks and byte size | `file size day-1.tcl` |

## File I/O Modes & Patterns

| Mode | Meaning |
| --- | --- |
| `"r"` | Read existing file (error if missing) |
| `"w"` | Write: creates file or **truncates** existing content |
| `"a"` | Append: creates file or writes at end without erasing |

```tcl
# Line-by-line reading (preferred for logs / STA timing reports)
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
```

```tcl
# Whole-file read vs append write
set fid [open $file_path r]
set data [read $fid]          ;# or [read $fid 6] for first 6 chars
close $fid

set fid [open $file_path a]
puts $fid $line               ;# writes line + newline
puts -nonewline $fid $line    ;# writes without trailing newline
close $fid
```

- `gets $fid line` reads one line (stripping `\n`) into `line` and returns character count, or `-1` at EOF → loop condition is `>= 0` (so empty lines with length `0` still continue!).

## Traps & Fixes (from [day-9.tcl](../day-9.tcl))

| Trap | Why | Fix |
| --- | --- | --- |
| `file dirname file_path` (`day-9.tcl:4`) | Missing `$` passes literal `"file_path"` instead of the variable's value | Write `file dirname $file_path` |
| `glob -directory file_path` (`day-9.tcl:17`) | Missing `$` and missing pattern argument | Write `glob -directory $dir *` |
| `file delete *.txt` (`day-9.tcl:22`) | `file delete` does not glob-expand wildcards; looks for a file literally named `*.txt` | Expand with `glob`: `file delete {*}[glob -nocomplain *.txt]` |
| `#close $fileId` left commented (`day-9.tcl:36`) | Leaks open file handles and may leave write buffers unflushed | Always `close $fileId` after reading or writing |
| `llength $data` / `lindex $data 6` on raw file text (`day-9.tcl:38-39`) | Treats arbitrary text as a Tcl list; crashes on unmatched quotes/braces | Split lines explicitly (`split $data "\n"`) or read with `gets` |
| `puts -nonewline $fileId $data` in `"a"` mode (`day-9.tcl:69`) | Appends directly onto the previous line's end without a newline (seen on `timing.txt:5-6`) | Use `puts $fileId $data` when appending line-oriented records |

## Quick Recall

1. Why is the `gets` loop condition `[gets $fid line] >= 0` instead of `> 0`?
2. What does `{*}` do in `file join {*}$lista` and `file delete {*}[glob -nocomplain *.txt]`?
3. What happens if `glob *.c` finds no `.c` files without `-nocomplain`?

<details>
<summary>Answers</summary>

1. An empty line returns length `0`, while EOF returns `-1`; `> 0` would stop early on the first blank line.
2. Expands the list into separate arguments passed individually to the command.
3. `glob` throws an error (`no files matched glob pattern "*.c"`); `-nocomplain` makes it return `{}` instead.

</details>
