
# 🔍 **Identify Attacker-Created User Account for Persistence**

To determine the **name of the user account** added by the attacker for persistence, focus on key logs and artifacts that track user account creation and privilege escalation.

---

## 📑 **1. Windows Security Event Logs (`Security.evtx`)**

- **Event ID 4720:** A user account was created.  
- **Event ID 4728/4732:** A user was added to a privileged group (`Administrators`).  
- **Event ID 4672:** Special privileges were assigned to a new account.

**Example Log Entry (Event ID 4720):**
```
Event ID: 4720
Account Created: backdooradmin
Creator Account: attacker_account
```

**Example Log Entry (Event ID 4732):**
```
Event ID: 4732
Group: Administrators
Member Added: backdooradmin
```

---

## 📑 **2. SAM Registry Hive**

- **Location:** `C:\Windows\System32\config\SAM`  
- **Purpose:** Stores local user account details.

**Tools for Analysis:**  
- `Registry Explorer` (Eric Zimmerman)  
- `SAMIParse` (Parse SAM hives)  

Look for **recently added accounts** or suspicious entries.

---

## 📑 **3. SYSTEM Registry Hive**

- **Location:** `C:\Windows\System32\config\SYSTEM`  
- **Check Paths:**  
   - `HKLM\SAM\Domains\Account\Users`  
   - Look for new **SID entries** (e.g., `S-1-5-21-XXXXXX-XXXXXX-XXXXXX-500`).

---

## 📑 **4. User Profile Directories**

- **Path:** `C:\Users\`  
- Look for **unusual user profile folders** such as:
   - `admin2`
   - `backup_admin`
   - `tempadmin`

---

## 📑 **5. Scheduled Tasks or Services**

Attackers may use **Scheduled Tasks** or **Services** to automate account creation.

- **Task Path:** `C:\Windows\System32\Tasks\`  
- Look for scripts or commands that include:
   ```cmd
   net user backdooradmin Password123 /add
   net localgroup Administrators backdooradmin /add
   ```

---

## 📑 **6. Logon Sessions (Event ID 4624)**

- Look for suspicious accounts with:
   - **Logon Type 2 (Interactive)**  
   - **Logon Type 10 (RemoteInteractive)**  

**Example Log Entry:**
```
Event ID: 4624
Logon Type: 2
Account Name: backdooradmin
```

---

## 🛠️ **Next Steps**

1. **Examine Security Logs:** Search for `Event ID 4720`, `4732`, `4672`.  
2. **Analyze SAM Hive:** Look for recently added user accounts.  
3. **Inspect User Profiles:** Check `C:\Users\` for anomalous directories.  
4. **Review Scheduled Tasks:** Look for account creation commands.  

If you have access to **logs** or **registry hives**, share the findings, and I’ll assist further! 🚀
