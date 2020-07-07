

if (Test-Path("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\")){
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Active Setup Temp Folders" -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\BranchCache" -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\D3D Shader Cache' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Delivery Optimization Files' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Diagnostic Data Viewer database files' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Downloaded Program Files' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Internet Cache Files' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Language Pack' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Offline Pages Files' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Old ChkDsk Files' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\RetailDemo Offline Content' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Setup Log Files' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error memory dump files' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error minidump files' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Files' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Thumbnail Cache' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Update Cleanup' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Defender' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting Files' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force 
}   

elseif (Test-Path("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name VolumeCaches -Force
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Active Setup Temp Folders" -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\BranchCache" -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\D3D Shader Cache' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Delivery Optimization Files' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Diagnostic Data Viewer database files' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Downloaded Program Files' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Internet Cache Files' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Language Pack' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Offline Pages Files' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Old ChkDsk Files' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\RetailDemo Offline Content' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Setup Log Files' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error memory dump files' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error minidump files' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Files' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Thumbnail Cache' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Update Cleanup' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Defender' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting Files' -Name "StateFlags0010" -Value "2" -PropertyType DWORD -Force 
}
else {
    return(-1)
    exit
}

cleanmgr.exe /Sagerun:10