set grade orange  
# options -> exact (not wildcard ) -- means end of options 
# -exact for matching without wildcard
switch -nocase -glob -- $grade {
    "apple" - "orange" {
        puts "well done its apple or orange   !"
    }
    bANANA {
        puts "excellent ! its bananaaa"
    }
    c {
        puts "you can do better "
    }
    d {
        puts "you would have done better "
    }
    default {
        puts "its fine prepare more next time "
    }

}