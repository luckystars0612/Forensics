
# 🛡️ **Techniques to Identify the Full Username Used for Lateral Movement**

When an attacker moves **laterally** from one system to another, they typically authenticate using valid credentials. To determine the **full username used**, we must focus on **authentication logs, session activities, and network traces**.

---

## 📑 **1. Windows Security Logs (`Security.evtx`)**

### **🔑 Key Event IDs to Investigate:**
- **4624:** Successful logon  
   - **Logon Type 3:** Network logon (e.g., SMB)  
   - **Logon Type 10:** RemoteInteractive (e.g., RDP)  
- **4648:** Explicit Credential Logon (Account explicitly used to log into a remote system)  
- **4768:** Kerberos Authentication Ticket (TGT) was requested  
- **4769:** Kerberos Service Ticket was requested  

**🛠️ Technique:**  
- Look for **Logon Type 3 or 10** events.  
- Cross-reference the **Account Name**, **Domain**, and **Source IP Address** fields.  
- Focus on timestamps immediately after suspicious activity on Bingle's workstation.

**Example (Event ID 4624):**
```
Logon Type: 3
Account Name: elfdesksupport
Account Domain: NORTHPOLE-BINGL
Source IP Address: 10.1.2.15
```

---

## 📑 **2. Remote Desktop (RDP) Logs**

### **🔑 Key Event IDs:**
- **Event ID 1149 (TerminalServices-RemoteConnectionManager):** Successful RDP authentication  
- **Event ID 21 (TerminalServices-LocalSessionManager):** Session logon  
- **Event ID 25:** Session disconnected  

**🛠️ Technique:**  
- Look at `TerminalServices` logs to identify usernames used during remote sessions.  
- Pay attention to `Account Name` and `Account Domain` fields.

**Example (Event ID 21):**
```
Account Name: NORTHPOLE-BINGL\elfdesksupport
Session ID: 2
```

---

## 📑 **3. Windows PowerShell Logs**

### **🔑 Logs to Analyze:**
- **Microsoft-Windows-PowerShell/Operational**
- **Event ID 4104:** Script Block Logging  
- **Event ID 4103:** Module Logging  

**🛠️ Technique:**  
- Search for commands related to `Enter-PSSession` or `Invoke-Command`.  
- Check for `-Credential` or explicit usernames in the logs.

**Example Command:**
```powershell
Enter-PSSession -ComputerName TargetSystem -Credential NORTHPOLE-BINGL\elfdesksupport
```

---

## 📑 **4. Network Traffic Logs (PCAP, Firewall, Proxy Logs)**

### **🔑 Key Indicators:**
- SMB Authentication (`smbclient`)  
- NTLM Authentication Traffic (`NTLMSSP`)  
- Kerberos Ticket Requests (`krb5`)  

**🛠️ Technique:**  
- Analyze network logs for authentication attempts.  
- Look at NTLM or Kerberos username fields.

**Example (Wireshark Filter):**
```
smb2 && tcp.port == 445
```

---

## 📑 **5. Security Information and Event Management (SIEM) Tools**

If logs are aggregated in a **SIEM** (e.g., Splunk, ELK, QRadar):  
- Query for `Event ID 4624`, `4648`, and `1149`.  
- Filter by **Source IP** (originating from Bingle's workstation).  
- Extract **Account Name** and **Domain** fields.

**Example Splunk Query:**
```spl
index=windows source="WinEventLog:Security" EventID=4624 LogonType=3 OR LogonType=10
| search Source_Network_Address="10.65.47.23"
| stats count by Account_Name, Account_Domain
```

---

## 📑 **6. Scheduled Tasks and Services**

Attackers sometimes create tasks to authenticate on remote systems:  
- **Check Scheduled Tasks:** `schtasks /query /fo LIST /v`  
- **Analyze Service Logs:** Look for services running with specific accounts.

---

## 📑 **7. Windows Registry (Run Keys, Winlogon Keys)**

### **🔑 Registry Paths:**
- `HKLM\Software\Microsoft\Windows\CurrentVersion\Run`
- `HKCU\Software\Microsoft\Windows\CurrentVersion\Run`

**🛠️ Technique:**  
- Look for commands/scripts containing `net use`, `Enter-PSSession`, or `RDP` connections.

---

## ✅ **Summary Table of Techniques**

| **Technique** | **Key Logs/Artifacts** | **Focus Field** |
|---------------|-------------------------|---------------|
| **Security Logs** | Event IDs: 4624, 4648, 4768 | Account Name, Domain |
| **RDP Logs** | Event IDs: 1149, 21 | Account Name, Domain |
| **PowerShell Logs** | Event ID 4104, 4103 | Explicit Credentials |
| **Network Traffic** | SMB, NTLM, Kerberos Traffic | Username in Auth Fields |
| **SIEM Tools** | Queries via Splunk/ELK | Filter by Source IP |
| **Scheduled Tasks/Services** | schtasks / Services | User Context |

---

## 🛠️ **Next Steps**
1. Start with **Security Logs (4624, 4648)** and **RDP Logs (1149, 21)**.  
2. Cross-reference **Source IP**, **Account Name**, and **Domain** fields.  
3. If ambiguous, move to **PowerShell Logs** and **Network Logs**.

If you have logs or specific data from these sources, feel free to share, and I’ll help pinpoint the **full username used for lateral movement**! 🚀
