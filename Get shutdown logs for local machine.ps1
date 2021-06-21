$logs = Get-EventLog system -InstanceId 41, 2147484723, 2147484722, 2147489656 | sort -property "TimeGenerated" -Descending
$i = $j = $k = $l = 0
foreach ($log in $logs){
		if ($logs[$i].InstanceId -eq 41){
			Add-Member -inputobject $logs[$i] -TypeName "ID" -Type NoteProperty -Value "41" -Name "ID"
			$logs[$i].ID = "41"
			$logs[$i] | Select-Object -Property "TimeGenerated", "ID"
			$i++
            $j++
		}
		if ($logs[$i].InstanceId -eq 2147484723){
			Add-Member -inputobject $logs[$i] -TypeName "ID" -Type NoteProperty -Value "6008" -Name "ID"
			$logs[$i].ID = "6008"
			$logs[$i] | Select-Object -Property "TimeGenerated", "ID"
			$i++
            $k++
		}
        if ($logs[$i].InstanceId -eq 2147489656){
			Add-Member -inputobject $logs[$i] -TypeName "ID" -Type NoteProperty -Value "6008" -Name "ID"
			$logs[$i].ID = "6008"
			$logs[$i] | Select-Object -Property "TimeGenerated", "ID"
			$i++
            $k++
		}
		if ($logs[$i].InstanceId -eq 2147484722){
			Add-Member -inputobject $logs[$i] -TypeName "ID" -Type NoteProperty -Value "1074" -Name "ID"
			$logs[$i].ID = "1074"
			$logs[$i] | Select-Object -Property "TimeGenerated", "ID"
			$i++
            $l++
		}
}
$logs = $logs | Select-Object -Property "TimeGenerated", "ID", "EntryType", "Message"
Write-Output "There are $j 41 logs, there are $k 6008 logs, and there are $l 1074 logs." >> C:\windows\temp\log.txt
Write-Output $logs >> C:\windows\temp\log.txt
