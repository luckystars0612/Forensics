
# 🛡️ Detecting Attacker Activity with 7-Zip

## 📚 Key Artifacts for 7-Zip Detection

| **Source**               | **Artifact**               | **Purpose**                   |
|---------------------------|----------------------------|--------------------------------|
| **Windows Security Logs**| Event ID **4688**          | Process creation details       |
|                          | Event ID **4663**          | File access (copy, modify)     |
|                          | Event ID **4656**          | Handle request (file access)   |
| **Windows Defender Logs**| Event ID **5001, 5004**    | Defender tampering detection   |
| **Prefetch Files**       | `7Z.EXE-[HASH].pf`         | File paths and execution times |
| **PowerShell History**   | `C:\Users\<User>\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt` | Command history |
| **Registry Artifacts**   | `HKCU\Software\7-Zip`      | Configuration & recent actions |

---

## 🛠️ Step-by-Step Detection Process

### 📊 Step 1: Process Creation Logs (Event ID 4688)

**Goal:** Find evidence of `7z.exe` execution and arguments passed.

**PowerShell Command:**
```powershell
# Search for 7-Zip Execution in Security Logs
$LogPath = "C:\Windows\System32\winevt\Logs\Security.evtx"

$Events = Get-WinEvent -Path $LogPath -FilterXPath "*[System[(EventID=4688)]]" |
    Where-Object { $_.Message -match "7z.exe" } |
    ForEach-Object {
        [PSCustomObject]@{
            TimeUTC     = $_.TimeCreated.ToUniversalTime()
            AccountName = $_.Properties[1].Value
            CommandLine = $_.Properties[10].Value
        }
    }

$Events | Sort-Object TimeUTC | Format-Table -AutoSize
```

**Look for:**  
- `CommandLine` field showing arguments (`7z a`, `7z x`, `-o`)  
- Account names associated with suspicious activity

---

### 📂 Step 2: File Access Logs (Event ID 4663)

**Goal:** Detect file creation, modification, or access.

**PowerShell Command:**
```powershell
# Search for File Access (Event ID 4663)
$FileEvents = Get-WinEvent -Path $LogPath -FilterXPath "*[System[(EventID=4663)]]" |
    Where-Object { $_.Message -match "7z.exe" } |
    ForEach-Object {
        [PSCustomObject]@{
            TimeUTC    = $_.TimeCreated.ToUniversalTime()
            FilePath   = $_.Properties[6].Value
            AccessType = $_.Properties[8].Value
        }
    }

$FileEvents | Sort-Object TimeUTC | Format-Table -AutoSize
```

**Look for:**  
- File paths accessed by `7z.exe`  
- Access types (`WRITE`, `READ`, `DELETE`)

---

### 🧠 Step 3: Analyze Prefetch Files

**Goal:** Prefetch tracks what files `7z.exe` interacted with.

**Tool:** WinPrefetchView or PECmd.exe

**Command Example:**
```cmd
PECmd.exe -d C:\Windows\Prefetch -f 7Z.EXE
```

**Look for:**  
- Files listed under `7z.exe` activity  
- Paths showing source and destination

---

### 🔍 Step 4: Search Command History

**PowerShell Command History:**  
Path: `C:\Users\<User>\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt`

Search for:
```
7z a
7z x
-o
```

**CMD Command History:**  
```cmd
doskey /history
```

---

### 🛡️ Step 5: Check Windows Defender Logs

**PowerShell Command:**  
```powershell
Get-WinEvent -Path "C:\Windows\System32\winevt\Logs\Microsoft-Windows-Windows Defender%4Operational.evtx" |
    Where-Object { $_.Message -match "7z.exe" } |
    Select-Object TimeCreated, Message | Format-Table -AutoSize
```

**Look for:**  
- Any alerts or logs mentioning `7z.exe`

---

## 🗂️ Step 6: Registry Artifacts

7-Zip writes recent paths in the registry:
```
HKCU\Software\7-Zip\FM
```

**Export the Key:**
```cmd
reg query "HKCU\Software\7-Zip\FM"
```

**Look for:**  
- Recent archive paths (source/destination)  
- Last opened files/folders

---

## 🚦 Correlate Findings

| **Time (UTC)**       | **Account Name** | **Command Line**                          | **FilePath**           | **AccessType** |
|-----------------------|------------------|-------------------------------------------|------------------------|---------------|
| 2024-12-24 18:45:32  | krampus          | 7z.exe a archive.zip C:\Sensitive\File.txt | C:\Sensitive\File.txt | Write         |
| 2024-12-24 18:46:10  | krampus          | 7z.exe x archive.zip -oD:\HiddenFolder\    | D:\HiddenFolder\       | Write         |

---

## ✅ Key Takeaways

1. **Focus on Event IDs:** `4688`, `4663`, `4656`
2. **Inspect Command Lines:** Look for `7z a`, `7z x`, `-o`
3. **Analyze Prefetch Files:** Trace execution paths
4. **Check Registry:** Look for recent archives
5. **Review Command Histories:** Inspect PowerShell and CMD logs

By cross-referencing these artifacts, you’ll reconstruct:  
- **What files were copied or moved.**  
- **Where the files were moved to.**  
- **Who executed the commands.**

🚀 **Stay vigilant and investigate thoroughly!**
