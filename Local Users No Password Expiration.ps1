$var = $(get-localuser).name
foreach ($N in $var){
    Set-LocalUser -Name "$N" -PasswordNeverExpires 1
}