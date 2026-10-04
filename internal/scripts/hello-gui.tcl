# Run from PowerShell: .\internal\scripts\wish.cmd .\internal\scripts\hello-gui.tcl
package require Tk 8.6

ttk::style theme use clam
ttk::style configure TFrame -background white
ttk::style configure TLabel -background white -foreground #202020
ttk::style configure TEntry -fieldbackground white -foreground #202020
ttk::style map TEntry -fieldbackground {readonly white disabled #f2f2f2}
ttk::style configure Action.TButton -background #e3f1e7 -foreground #215534 -padding {14 8}
ttk::style map Action.TButton -background {pressed #bddac8 active #d0e6d8}
ttk::style configure Result.TLabel -background white -foreground #215534
ttk::style configure Version.TLabel -background white -foreground #555555
. configure -background white

wm title . "Tcl/Tk Practice"
wm minsize . 460 280

set name "Kapil"
set greeting "Type a name, then click Say hello."

proc sayHello {} {
    global name greeting
    set enteredName [string trim $name]
    if {$enteredName eq ""} {
        set greeting "Please enter a name."
    } else {
        set greeting "Hello, $enteredName! Your Tk window is working."
    }
}

ttk::frame .main -padding 24
pack .main -fill both -expand 1

ttk::label .main.title -text "Your first Tk window" -font {Segoe\ UI 16 bold}
ttk::label .main.prompt -text "Name"
ttk::entry .main.name -textvariable name -width 36
ttk::button .main.greet -text "Say hello" -command sayHello -style Action.TButton
ttk::label .main.result -textvariable greeting -wraplength 400 -style Result.TLabel
ttk::label .main.version -text "Tcl [info patchlevel] / Tk [package provide Tk]" -style Version.TLabel

grid .main.title -row 0 -column 0 -sticky w -pady {0 20}
grid .main.prompt -row 1 -column 0 -sticky w -pady {0 6}
grid .main.name -row 2 -column 0 -sticky ew -pady {0 12}
grid .main.greet -row 3 -column 0 -sticky w -pady {0 16}
grid .main.result -row 4 -column 0 -sticky w -pady {0 20}
grid .main.version -row 5 -column 0 -sticky w
grid columnconfigure .main 0 -weight 1

bind .main.name <Return> sayHello
focus .main.name
