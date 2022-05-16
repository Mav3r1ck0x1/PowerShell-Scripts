#Get Host and print 
$hostname = Get-Content env:computername
Write-Output "Hostname: $hostname " 

$Session = New-Object -ComObject Microsoft.Update.Session
$Searcher = $Session.CreateUpdateSearcher()
$HistoryCount = $Searcher.GetTotalHistoryCount()
$Updates = $Searcher.QueryHistory(0,$HistoryCount)
$Updates |  Select Title,@{l='Name';e={$($_.Categories).Name}},Date
