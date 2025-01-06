# Define the log file path
$LogPath = "C:\Users\a\Desktop\SleighSlayer\OPTT6-SleighSlayer\santa_triage_PriorityHigh\C\Windows\System32\winevt\logs\Microsoft-Windows-Windows Defender%4Operational.evtx"

# Read and filter relevant Event IDs
$Events = Get-WinEvent -Path $LogPath -FilterXPath "*[System[(EventID=5001 or EventID=5004 or EventID=5010 or EventID=5025 or EventID=104)]]" | 
    ForEach-Object {
        [PSCustomObject]@{
            EventID      = $_.Id
            Level        = $_.LevelDisplayName
            Message      = $_.Message
            TimeUTC      = $_.TimeCreated.ToUniversalTime()
        }
    }

# Display the results
if ($Events) {
    Write-Host "Windows Defender disable events found:" -ForegroundColor Cyan
    $Events | Sort-Object TimeUTC | Format-Table -AutoSize
} else {
    Write-Host "No relevant events found." -ForegroundColor Red
}
