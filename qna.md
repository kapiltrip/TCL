# Tcl Q&A: your logic questions

Questions collected from our discussion through 5 October 2026. The answers keep your namespace examples and explain how Tcl decides whether to read a variable, call a command, or pass text to another command.

## Question index

| Question | Main idea |
| --- | --- |
| [Q1. How do I write multiline comments?](#q1-how-do-i-write-multiline-comments) | Comment lines and temporarily disabled code |
| [Q2. What was wrong with my namespace setter and print procedure?](#q2-what-was-wrong-with-my-namespace-setter-and-print-procedure) | Procedure arguments and reading versus assigning with `set` |
| [Q3. Why do I write variable var1 inside every procedure?](#q3-why-do-i-write-variable-var1-inside-every-procedure) | Local procedure scope and access to a shared namespace variable |
| [Q4. Does variable var1 make it a global variable?](#q4-does-variable-var1-make-it-a-global-variable) | `::var1` versus `::n1::var1` |
| [Q5. Why does `puts $n4::var1` work, but `puts [n4::var1]` fail?](#q5-why-does-puts-n4var1-work-but-puts-n4var1-fail) | Variable substitution versus command substitution |
| [Q6. What is the difference between brackets, braces, and expr?](#q6-what-is-the-difference-between-brackets-braces-and-expr) | Grouping text, executing commands, and evaluating expressions |

For the file-running commands and VS Code setup, see [Run the code](README.md#run-the-code) and [What I did](what-i-did.md).

## Q1. How do I write multiline comments?

Put `#` at the beginning of each comment line. Indentation before it is fine:

```tcl
# This is the first comment line.
# This is the second comment line.
# Explain the purpose of the following code here.
puts "This runs"
```

Output:

```text
This runs
```

To temporarily disable several lines of code, put them inside a false `if` body:

```tcl
if {0} {
    puts "This does not run"
    puts "This does not run either"
}
puts "This runs"
```

The condition is false, so the body is skipped. Keep its braces balanced: Tcl must first find where the body starts and ends, even when it will skip execution. This is a conditional command, rather than a separate block-comment syntax. [if reference](https://www.tcl-lang.org/man/tcl8.6.14/TclCmd/if.htm)

For a comment after a command on the same line, end the command with a semicolon first:

```tcl
set a 10 ;# Store the starting value.
```

Inside a braced procedure or conditional body, braces written in comments still affect the outer grouping step. Avoid an unmatched brace in such comments. [Tcl comment and brace rules](https://www.tcl-lang.org/man/tcl8.6.14/TclCmd/Tcl.htm)

[Back to question index](#question-index)

## Q2. What was wrong with my namespace setter and print procedure?

Your code had two separate problems:

| Original line | Meaning or problem | Correction |
| --- | --- | --- |
| `proc print{} {` | `print{}` is one word; the empty argument list is missing as a separate word. | `proc print {} {` |
| `set var1` | Reads the current value; it does not store `user_in`. | `set var1 $user_in` |

The procedure command expects a name, an argument list, and a body. Your print definition failed first with `wrong # args: should be "proc name args body"`. After correcting only its spacing, the program printed `0`, because the setter still only read the initial value. [proc reference](https://www.tcl-lang.org/man/tcl8.6.14/TclCmd/proc.htm), [set reference](https://www.tcl-lang.org/man/tcl8.6.14/TclCmd/set.htm)

The complete corrected program is:

```tcl
namespace eval n1 {
    variable var1 0

    proc set_var1 {user_in} {
        variable var1
        set var1 $user_in
    }

    proc get_var1 {} {
        variable var1
        return $var1
    }

    proc print {} {
        variable var1
        puts "The variable is $var1"
    }
}

set var2 12
n1::set_var1 $var2
n1::print
```

Output:

```text
The variable is 12
```

The value moves through the program as follows:

| Step | Result |
| --- | --- |
| `variable var1 0` in `namespace eval n1` | Initializes `::n1::var1` to `0`. |
| `set var2 12` | Stores `12` in the top-level variable `var2`. |
| `n1::set_var1 $var2` | Passes the value `12` into the procedure's local parameter `user_in`. |
| `variable var1` inside the setter | Makes the procedure's name `var1` refer to `::n1::var1`. |
| `set var1 $user_in` | Stores `12` in the shared namespace variable. |
| `n1::print` | Reads that shared value and prints it. |

You pass the value of `var2`, so the setter updates `::n1::var1`; it does not create a connection back to `var2`.

[Back to question index](#question-index)

## Q3. Why do I write variable var1 inside every procedure?

Each procedure invocation has a local variable scope. Defining a procedure inside `n1` does not automatically make an unqualified variable name inside its body refer to `n1`'s variable. Parameters such as `user_in` are local to the call. [Procedure scope](https://www.tcl-lang.org/man/tcl8.6.14/TclCmd/proc.htm)

In your getter, `variable var1` tells Tcl to use the existing namespace variable when this procedure refers to `var1`. Using the namespace from Q2:

```tcl
proc n1::get_var1 {} {
    variable var1
    return $var1
}
puts [n1::get_var1]
```

Output:

```text
12
```

The setter, getter, and print procedure can therefore access the same `::n1::var1`. The declaration makes a local name refer to shared storage. It does not copy the value or reset it.

| Where the statement appears | Effect |
| --- | --- |
| `variable var1 0` in the namespace | Creates or identifies the namespace variable and sets its value to `0`. |
| `variable var1` in a procedure | Gives that call access to the namespace variable without assigning a new value. |
| `variable var1 0` in a procedure | Links the name and also sets the shared value to `0` on that call. |

When a call ends, its local scope ends. The namespace variable remains. The next call establishes its own access again. [variable reference](https://www.tcl-lang.org/man/tcl8.6.14/TclCmd/variable.htm)

If you remove the declaration and have not created a local `var1`, `return $var1` fails with:

```text
can't read "var1": no such variable
```

Another valid approach is to write the complete variable name directly:

```tcl
proc n1::get_var1 {} {
    return $::n1::var1
}
puts [n1::get_var1]
```

This also prints `12`; the full name already identifies the variable.

[Back to question index](#question-index)

## Q4. Does variable var1 make it a global variable?

It gives the procedure access to a namespace variable. In your code, the variable belongs to `n1`, with the full name `::n1::var1`. It is separate from the variable `::var1` in the global namespace.

| Name | Location |
| --- | --- |
| An ordinary local `var1` | The current procedure call |
| `::var1` | The global namespace `::` |
| `::n1::var1` | Namespace `::n1` |

Using the namespace from Q2:

```tcl
set ::var1 99
puts $::var1
puts $::n1::var1
```

Output:

```text
99
12
```

Inside a procedure defined in `n1`, `variable var1` selects `::n1::var1`. A declaration of `global var1` would select `::var1`. The declaration controls which storage the short name refers to; it does not move the namespace variable into another namespace. [variable reference](https://www.tcl-lang.org/man/tcl8.6.14/TclCmd/variable.htm), [global reference](https://www.tcl-lang.org/man/tcl8.6.14/TclCmd/global.htm)

A namespace groups names; it does not make variables private. Code outside `n1` can access its variable with `$::n1::var1`. The initial `::` makes the path absolute. [Namespace name resolution](https://www.tcl-lang.org/man/tcl8.6.14/TclCmd/namespace.htm)

[Back to question index](#question-index)

## Q5. Why does `puts $n4::var1` work, but `puts [n4::var1]` fail?

Your original comparison was `puts "$n4::var1"` versus `puts [n4::var1]`.

The first reads a variable. The second asks Tcl to execute a command named `n4::var1` and use its result. Creating a variable does not also create a command with that name.

This complete example shows three valid ways to print the value:

```tcl
namespace eval n4 {
    variable var1 12

    proc get_var1 {} {
        variable var1
        return $var1
    }
}

puts "$n4::var1"
puts [n4::get_var1]
puts [set ::n4::var1]
```

Output:

```text
12
12
12
```

| Expression | Action |
| --- | --- |
| `$n4::var1` at the top level | Reads `::n4::var1`. |
| `[n4::get_var1]` | Calls the getter procedure and uses its returned value. |
| `[set ::n4::var1]` | Calls `set` with one argument, which reads the variable. |
| `[n4::var1]` | Attempts to call a command named `n4::var1`. |

In this example, `puts [n4::var1]` fails with `invalid command name "n4::var1"`. A space before the closing bracket does not change that: Tcl is still looking for a command. [Reading with set](https://www.tcl-lang.org/man/tcl8.6.14/TclCmd/set.htm)

Double quotes allow substitution, so `"$n4::var1"` becomes the value. From code in any namespace, `$::n4::var1` explicitly identifies the same variable using its absolute name. [Tcl substitution rules](https://www.tcl-lang.org/man/tcl8.6.14/TclCmd/Tcl.htm)

[Back to question index](#question-index)

## Q6. What is the difference between brackets, braces, and expr?

Your question compared `[...]`, `{...}`, and expressions written with `expr`.

| Form | Purpose |
| --- | --- |
| `$a` | Reads the value of variable `a`. |
| `[command]` | Executes a Tcl command and inserts its returned value. |
| `{text}` | Groups text into one word without immediate variable or command substitution. |
| `"text"` | Groups text into one word while allowing substitution. |
| `expr {expression}` | Asks `expr` to evaluate a mathematical or logical expression. |

### What braces and quotes pass to puts

```tcl
set a 10
puts {$a + 5}
puts "$a + 5"
puts [expr {$a + 5}]
```

Output:

```text
$a + 5
10 + 5
15
```

The first line passes literal text to `puts`. The second substitutes the variable, but `puts` still prints text; it does not perform addition. The third evaluates an expression before printing the result. Braced words have a special backslash-newline processing exception, but ordinary `$a` and bracketed commands remain literal at that grouping step. [Tcl grouping and substitution rules](https://www.tcl-lang.org/man/tcl8.6.14/TclCmd/Tcl.htm)

### Why expr can read a variable inside braces

In `expr {$a + 5}`, the command parser passes the expression text to `expr`. The expression evaluator then interprets `$a` and performs the addition. The braces delay substitution until `expr` handles the expression; they do not prevent a receiving command from interpreting the text. Bracing expressions is the normal pattern and also allows efficient compilation. [expr reference](https://www.tcl-lang.org/man/tcl8.6.14/TclCmd/expr.htm)

For `puts [expr {$a + 5}]`, the execution order is:

| Step | What happens |
| --- | --- |
| 1 | Tcl encounters the bracketed command `expr {$a + 5}`. |
| 2 | The braces supply `$a + 5` to `expr` as one expression. |
| 3 | `expr` reads `a` as `10`, adds `5`, and returns `15`. |
| 4 | Command substitution supplies `15` as the argument to `puts`. |
| 5 | `puts` prints `15`. |

To store the result, use:

```tcl
set a 10
set result [expr {$a + 5}]
puts $result
```

This prints `15`. `expr` returns a value; it does not print by itself. In an interactive Tcl session, the prompt normally displays command results. In a saved script, use a command such as `puts` when you want visible output.

### Why expr [$a + 5] fails

With `a` set to `10`, `expr [$a + 5]` tries to execute the command inside the brackets first. After variable substitution, that command has the words `10`, `+`, and `5`. Tcl looks for a command named `10`, and fails with `invalid command name "10"` before it reaches the outer `expr`.

Write the arithmetic expression as `expr {$a + 5}`. When another command needs its result, surround the whole `expr` command with brackets: `[expr {$a + 5}]`.

`expr [set a]` can be valid: `set a` is a real command and returns a numeric expression. For your addition, the braced expression directly expresses the operation you want. [Expression operands](https://www.tcl-lang.org/man/tcl8.6.14/TclCmd/expr.htm)

[Back to question index](#question-index)

## Quick recall

| If you want to… | Use… |
| --- | --- |
| Assign a variable | `set a 10` |
| Read a variable | `$a` or `[set a]` |
| Read a namespace variable explicitly | `$::n1::var1` |
| Access that namespace variable inside a procedure in `n1` | `variable var1` |
| Use a procedure's result | `[n1::get_var1]` |
| Pass literal text | `{some text}` |
| Calculate and store a result | `set result [expr {$a + 5}]` |
| Temporarily disable a balanced block of code | `if {0} { ... }` |

The examples and error cases were checked with the folder's Tcl 8.6.18 interpreter. Q3 and Q4 use the namespace created by the corrected Q2 program.

[Back to question index](#question-index) · [Main study index](README.md)
