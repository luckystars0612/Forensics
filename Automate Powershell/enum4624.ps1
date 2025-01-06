# Define the log file path
$LogPath = "C:\Users\a\Desktop\SleighSlayer\OPTT6-SleighSlayer\santa_triage_PriorityHigh\C\Windows\System32\winevt\logs\Security.evtx"

# Define the log file path
$LogPath = "C:\Users\a\Desktop\SleighSlayer\OPTT6-SleighSlayer\santa_triage_PriorityHigh\C\Windows\System32\winevt\logs\Security.evtx"

# Read and filter Event ID 4624
$Events = Get-WinEvent -Path $LogPath -FilterXPath "*[System[(EventID=4624)]]" | 
    ForEach-Object {
        [PSCustomObject]@{
            AccountName        = ($_.Properties[5].Value)       # Account Name
            AccountDomain      = ($_.Properties[6].Value)       # Account Domain
            SourceNetworkAddress = ($_.Properties[18].Value)    # Source IP Address
            WorkstationName    = ($_.Properties[11].Value)      # Workstation Name
        }
    }

# Get unique entries based on Account Name, Account Domain, Source Network Address, and Workstation Name
$UniqueAccounts = $Events | Sort-Object AccountName, AccountDomain, SourceNetworkAddress, WorkstationName -Unique

# Display the results
$UniqueAccounts | Format-Table -AutoSize
