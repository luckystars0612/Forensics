$LogPath = "C:\Users\a\Desktop\jinkies\Jinkies_KAPE_output\TriageData\C\Windows\system32\winevt\logs\Security.evtx"

# Read, filter Event ID 4624, and Logon Type 2, then sort by time
$Events = Get-WinEvent -Path $LogPath -FilterXPath "*[System[(EventID=4624)]]" | 
    Where-Object {
        ($_.Properties[8].Value -eq "3") # Filter for Logon Type 3
    } | 
    ForEach-Object {
        [PSCustomObject]@{
            AccountName          = ($_.Properties[5].Value)       # Account Name
            AccountDomain        = ($_.Properties[6].Value)       # Account Domain
            SourceNetworkAddress = ($_.Properties[18].Value)      # Source IP Address
            WorkstationName      = ($_.Properties[11].Value)      # Workstation Name
            LogonTimeUTC         = ($_.TimeCreated.ToUniversalTime()) # Logon Time (UTC)
        }
    } | Sort-Object LogonTimeUTC

# Display the results in a table format
$Events | Format-Table -AutoSize
