#These functions are a method I found to store the result of a command run remotely in a local variable.
function do-Command1{
    $com1 = Get-CimInstance Win32_OperatingSystem | Select-Object LastBootUpTime
    return $com1
}
function do-Command2{
    $com2 = Get-EventLog system -InstanceId 41, 2147484723, 2147484722, 2147489656 | sort -property "TimeGenerated" -Descending
    return $com2
}
#Get a list of computers that are joined to the domain, online, and running WinRM.
$i = 0
$n = 0
$k = 0
$DomainComputers = Get-ADComputer -Filter *
$TotalCount = $DomainComputers.Name
$TotalCount = $TotalCount.count
$WinRM = [Object[]]::new($TotalCount)
$OnlineComputers = [Object[]]::new($TotalCount)
$OfflineComputers = [Object[]]::new($TotalCount)
foreach ($Computer in $DomainComputers){
    if ($Computer -ne $null){
        $result = ping -n 1 $Computer.DNSHostname
        if ($result -like "*could not find host*"){
            $OfflineComputers[$i] = $Computer.DNSHostname
            $i++
        }
        else{
            $result = Test-WSMan -ComputerName $Computer.DNSHostname -ErrorAction SilentlyContinue -InformationAction SilentlyContinue -WarningAction SilentlyContinue
            if ($result.wsmid){
                $WinRM[$n] = $Computer.DNSHostname
                $n++
            }
            else{
                $OnlineComputers[$k] = $Computer.DNSHostname
                $k++
            }
        }
    }
}
#Runs remote commands on each computer and stores the result in a local file.
Mkdir C:\Windows\Temp\Logs\ -ErrorAction SilentlyContinue
$i=0
[string]$userName = Read-Host -Prompt 'Provide the Administrative Username in the format Domain\User'
[string]$userPassword = Read-Host -Prompt 'Password'
[SecureString]$secureString = $userPassword | ConvertTo-SecureString -AsPlainText -Force
[PSCredential]$CredentialObject = New-Object System.Management.Automation.PSCredential -ArgumentList $userName, $secureString
foreach ($Computer in $WinRM){
    if ($Computer -ne $null){
        Start-Sleep 1
        $com1 = invoke-command -ComputerName $Computer -Credential $CredentialObject -scriptblock ${function:do-Command1} -ErrorAction SilentlyContinue
        $com2 = invoke-command -ComputerName $Computer -Credential $CredentialObject -scriptblock ${function:do-Command2} -ErrorAction SilentlyContinue
        $com1.LastBootUpTime >> C:\Windows\Temp\Logs\$Computer.txt
        $com2 >> C:\Windows\Temp\Logs\$Computer.txt
        $i++
    }
}
Write-Output "These computers were online but could not be accessed with WinRM:" > C:\Windows\Temp\Logs\WinRMBlocked.txt
foreach ($Computer in $OnlineComputers){
    Write-Output $Computer >> C:\Windows\Temp\Logs\WinRMBlocked.txt
}
Write-Output "These computers were offline when the script was run:" > C:\Windows\Temp\Logs\OfflineComputers.txt
foreach ($Computer in $OfflineComputers){
    Write-Output $Computer >> C:\Windows\Temp\Logs\OfflineComputers.txt
}
