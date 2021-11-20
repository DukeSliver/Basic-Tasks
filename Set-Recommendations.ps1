#Make sure that the Microsoft MSOnline is installed.
function Confirm-MSOnlineModule{
    New-Variable -Name MSOLCalled -Value 1 -Scope Global -ErrorAction SilentlyContinue
    $Module=Get-InstalledModule -Name MSOnline -MinimumVersion 1.1.183.57 -erroraction 'silentlycontinue'
    if($Module.count -eq 0){
        Write-Host Required MSOnline module is not installed  -ForegroundColor yellow 
        $Confirm= Read-Host Are you sure you want to install module? [Y] Yes [N] No
        if($Confirm -match "[yY]"){
        Install-Module MSOnline
        Connect-MsolService
        }
        else{
        Write-Host The MSOnline module is required. Please install module using Install-Module MSOnline cmdlet.
        }
    }
    else{
        Connect-MsolService
    }
}
#Make sure that the Microsoft Teams module is installed.
function Confirm-MicrosoftTeamsModule{
    New-Variable -Name MicrosoftTeamsCalled -Value 1 -Scope Global -ErrorAction SilentlyContinue
    $Module=Get-InstalledModule -Name MicrosoftTeams -MinimumVersion 2.0.0 -erroraction 'silentlycontinue'
    if($Module.count -eq 0){
        Write-Host Required Microsoft Teams module is not installed  -ForegroundColor yellow 
        $Confirm= Read-Host Are you sure you want to install module? [Y] Yes [N] No
        if($Confirm -match "[yY]"){
        Install-Module MicrosoftTeams
        Import-Module MicrosoftTeams
        Connect-MicrosoftTeams
        }
        else{
        Write-Host Microsoft Teams module is required. Please install module using Install-Module MicrosoftTeams cmdlet.
        }
    }
    else{
        Import-Module MicrosoftTeams
        Connect-MicrosoftTeams
    }
}
#Make sure that the AzureAD module is installed.
function Confirm-AADModule{
    New-Variable -Name AADModuleCalled -Value 1 -Scope Global -ErrorAction SilentlyContinue
    $Module=Get-InstalledModule -Name AzureAD -MinimumVersion 2.0.2.130 -erroraction 'silentlycontinue'
    if($Module.count -eq 0){
        Write-Host Required Azure AD module is not installed  -ForegroundColor yellow 
        $Confirm= Read-Host Are you sure you want to install module? [Y] Yes [N] No
        if($Confirm -match "[yY]"){
        Install-Module AzureAD
        Import-Module AzureAD
        Connect-AzureAD
        }
        else{
        Write-Host Azure AD module is required. Please install module using Install-Module AzureAD cmdlet.
        }
    }
    else{
        Import-Module AzureAD
        Connect-AzureAD
    }
}
#Make sure that the Exchange Online module is installed.
function Confirm-EXOModule {
    New-Variable -Name EXOModuleCalled -Value 1 -Scope Global -ErrorAction SilentlyContinue
    $Module=Get-InstalledModule -Name ExchangeOnlineManagement -MinimumVersion 2.0.3 -erroraction 'silentlycontinue'
    if($Module.count -eq 0){
        Write-Host Required Exchange Online'(EXO V2)' module is not installed  -ForegroundColor yellow 
        $Confirm= Read-Host Are you sure you want to install module? [Y] Yes [N] No
        if($Confirm -match "[yY]"){
        Install-Module ExchangeOnlineManagement
        Import-Module ExchangeOnlineManagement
        Connect-ExchangeOnline
        }
        else{
        Write-Host EXO V2 module is required to connect Exchange Online.Please install module using Install-Module ExchangeOnlineManagement cmdlet.
        }
    }
    else{
        Import-Module ExchangeOnlineManagement
        Connect-ExchangeOnline
    }
}

#Create a Conditional Access Policy that requires users with an admin role to use MFA when signing in.
function Set-AdminMFAPolicyAction{
    try{
        $conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
        $conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
        $conditions.Applications.IncludeApplications = "All"
        $conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
        $conditions.Users.IncludeRoles = @('62e90394-69f5-4237-9190-012177145e10', 'f28a1f50-f6e7-4571-818b-6a12f2af6b6c', '29232cdf-9323-42fd-ade2-1d097af3e4de', 'b1be1c3e-b65d-4f19-8427-f6fa0d97feb9', '194ae4cb-b126-40b2-bd5b-6091b380977d', '729827e3-9c14-49f7-bb1b-9608f156bbb8', '966707d0-3269-4727-9be2-8c3a10f19b9d', 'b0f54661-2d74-4c50-afa3-1ec803f12efe', 'fe930be7-5e62-47db-91af-98c3a49a38b1')
        $conditions.Users.ExcludeGroups = $ExcludeCAGroup.ObjectId
        $conditions.ClientAppTypes = @('Browser', 'MobileAppsAndDesktopClients')
        $controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
        $controls._Operator = "OR"
        $controls.BuiltInControls = "MFA"
        New-AzureADMSConditionalAccessPolicy -DisplayName "Require MFA for Admin users" -State "Disabled" -Conditions $conditions -GrantControls $controls -InformationAction SilentlyContinue
        Write-Output "Admin Multi-factor Authentication Not Registered DONE" >> C:\Windows\Temp\RapidFireRecommendations.txt
    }
    catch{
        Write-Host "At least a P1 license is required to create Conditional Access Policies."
    }
}
function Set-AdminMFAPolicyCall {
    [String]$Consent = Read-Host -Prompt "Do you want to force all users with an admin role to use MFA when signing in? This requires a P1 license. Be careful with this since you can lock yourself out. This policy is disabled by default. Do you want to proceed? [Y] Yes [N] No"
    if ($Consent -match "[yY]"){
        if($AADModuleCalled){
            Set-AdminMFAPolicyAction
        }
        else{
            Confirm-AADModule
            Set-AdminMFAPolicyAction
        }
    }
    else{
        Write-Host "Admin MFA Policy Skipped."
        Write-Output "Admin Multi-factor Authentication Not Registered SKIPPED" >> C:\Windows\Temp\RapidFireRecommendations.txt
    }
}

#Create a Conditional Access Policy that blocks clients using Legacy Authentication.
function Block-LegacyAuthenticationCAPAction{
    try{
        $conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
        $conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
        $conditions.Applications.IncludeApplications = "All"
        $conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
        $conditions.Users.IncludeUsers = "All"
        $conditions.Users.ExcludeGroups = $ExcludeCAGroup.ObjectId
        $conditions.ClientAppTypes = @('ExchangeActiveSync', 'Other')
        $controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
        $controls._Operator = "OR"
        $controls.BuiltInControls = "Block"
        New-AzureADMSConditionalAccessPolicy -DisplayName "Block Legacy authentication clients" -State "Enabled" -Conditions $conditions -GrantControls $controls -InformationAction SilentlyContinue
        Write-Output "Legacy Authentication Not Blocked DONE" >> C:\Windows\Temp\RapidFireRecommendations.txt
        }
        catch{
            Write-Host "At least a P1 license is required to create Conditional Access Policies."
        }
}
function Block-LegacyAuthenticationAPAction{
    New-AuthenticationPolicy -Name "Block Basic Auth"
    Set-AuthenticationPolicy -Identity "Block Basic Auth" -AllowBasicAuthImap:$false -AllowBasicAuthPop:$false -AllowBasicAuthSmtp:$false -Confirm
    Set-OrganizationConfig -DefaultAuthenticationPolicy "Block Basic Auth" 
}
function Block-LegacyAuthenticationCall{
    [String]$Consent = Read-Host -Prompt 'Do you want to block all clients attempting to use Legacy Authentication? [Y] Yes [N] No'
    if ($Consent -match "[yY]"){
        [String]$Method = Read-Host -Prompt 'Do you have a P1 license? [Y] Yes [N] No'
            if ($Method -match "[yY]"){
                if($AADModuleCalled){
                    Block-LegacyAuthenticationCAPAction
                }
                else{
                    Confirm-AADModule
                    Block-LegacyAuthenticationCAPAction
                }
            }
            else{
                if ($EXOModuleCalled){
                    Block-LegacyAuthenticationAPAction
                }
                else{
                    Confirm-EXOModule
                    Block-LegacyAuthenticationAPAction
                }
            }
    }
    else {
        Write-Host "Legacy Auth Policy Skipped."
        Write-Output "Legacy Authentication Not Blocked SKIPPED" >> C:\Windows\Temp\RapidFireRecommendations.txt
    }
}

#Restrict anonymous from joining meetings.
function Set-TeamsRestrictAnonymousAction{
Confirm-MicrosoftTeamsModule
        set-CsTeamsMeetingConfiguration -DisableAnonymousJoin $true -InformationAction SilentlyContinue
        set-CsTeamsMeetingConfiguration -DisableAppInteractionForAnonymousUsers $true -InformationAction SilentlyContinue
        Write-Output "meeting_restrictanonymousjoin_v1 DONE" >> C:\Windows\Temp\RapidFireRecommendations.txt
}
function Set-TeamsRestrictAnonymousCall{
    [String]$Consent = Read-Host -Prompt 'Do you want to restrict anonymous from joining Teams meetings? [Y] Yes [N] No'
    if ($Consent -match "[yY]"){
        if($MicrosoftTeamsCalled){
            Set-TeamsRestrictAnonymousAction
        }
        else{
            Confirm-MicrosoftTeamsModule
            Set-TeamsRestrictAnonymousAction
        }
    }
    else{
        Write-Host "Restrict Anonymous Skipped"
        Write-Output "meeting_restrictanonymousjoin_v1 SKIPPED" >> C:\Windows\Temp\RapidFireRecommendations.txt
    }
}
#Disable password expiration.
function Set-PassworedExpirationAction{
    $domains = Get-MsolDomain
    $domains = $domains.Name
    foreach ($domain in $domains){
        Set-MsolPasswordPolicy -DomainName "$domain" -ValidityPeriod 2147483647 -NotificationDays 30 -ErrorAction SilentlyContinue -InformationAction SilentlyContinue
    }
    Write-Output "Password Age Policy Enabled DONE" >> C:\Windows\Temp\RapidFireRecommendations.txt
}
function Set-PassworedExpirationCall{
    [String]$Consent = Read-Host -Prompt 'Do you want to set all passwords to never expire? [Y] Yes [N] No'
    if ($Consent -match "[yY]"){
        if ($MSOLCalled){
            Set-PassworedExpirationAction
        }
        else{
            Confirm-MSOnlineModule
            Set-PassworedExpirationAction
        }
    }
    else{
        Write-Output "Password Age Policy Enabled SKIPPED" >> C:\Windows\Temp\RapidFireRecommendations.txt
        Write-Host "Password Age Policy Skipped"
    }

}
#Disallow users from consenting to give information to 3rd party apps.
function Set-UserConsentAction{
    Set-MsolCompanySettings -UsersPermissionToUserConsentToAppEnabled $false
    Write-Output "Integrated Apps Not Regulated DONE" >> C:\Windows\Temp\RapidFireRecommendations.txt
}
function Set-UserConsentCall{
    [String]$Consent = Read-Host -Prompt 'Do you want to prevent users from consenting to apps that require access to their cloud user data? This will block things like the mail app on an iPhone. Do you want to proceed? [Y] Yes [N] No'
    if ($Consent -match "[yY]"){
        if ($MSOLCalled){
            Set-UserConsentAction
        }
        else{
            Confirm-MSOnlineModule
            Set-UserConsentAction
        }
    }
    else{
        Write-Output "Integrated Apps Not Regulated SKIPPED" >> C:\Windows\Temp\RapidFireRecommendations.txt
        Write-Host "Integrated Apps Not Regulated"
    }
}

function Set-Recommendations {
    Set-TeamsRestrictAnonymousCall
    Set-PassworedExpirationCall
    Set-UserConsentCall
    Block-LegacyAuthenticationCall
    Set-AdminMFAPolicyCall
}
Set-Recommendations
