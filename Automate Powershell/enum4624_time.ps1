param(
    [string]$m
)

# Define the log file path
$LogPath = "C:\Users\a\Desktop\SleighSlayer\OPTT6-SleighSlayer\santa_triage_PriorityHigh\C\Windows\System32\winevt\logs\Security.evtx"

# Read and filter Event ID 4624
$Events = Get-WinEvent -Path $LogPath -FilterXPath "*[System[(EventID=4624)]]" | 
    ForEach-Object {
        [PSCustomObject]@{
            AccountName          = ($_.Properties[5].Value)       # Account Name
            AccountDomain        = ($_.Properties[6].Value)       # Account Domain
            SourceNetworkAddress = ($_.Properties[18].Value)      # Source IP Address
            WorkstationName      = ($_.Properties[11].Value)      # Workstation Name
            LogonTimeUTC         = ($_.TimeCreated.ToUniversalTime()) # Logon Time (UTC)
        }
    }

# Debug: Show raw events to ensure AccountName contains data
Write-Host "Debug: Total events fetched: $($Events.Count)" -ForegroundColor Cyan

# Apply username filter if provided
if ($m) {
    $FilteredEvents = $Events | Where-Object {
        $_.WorkstationName -and $_.WorkstationName -match $m
    }

    # Debug: Show filtered event count
    Write-Host "Debug: Filtered events matching '$m': $($FilteredEvents.Count)" -ForegroundColor Yellow
} else {
    $FilteredEvents = $Events
    Write-Host "Debug: No filter applied, showing all events." -ForegroundColor Green
}

# Get unique entries based on Account Name, Account Domain, Source Network Address, Workstation Name, and Logon Time
$UniqueAccounts = $FilteredEvents | Sort-Object AccountName, AccountDomain, SourceNetworkAddress, WorkstationName, LogonTimeUTC -Unique

# Display the results
if ($UniqueAccounts) {
    $UniqueAccounts | Format-Table -AutoSize
} else {
    Write-Host "No matching events found." -ForegroundColor Red
}
