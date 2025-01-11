
# 🔍 **Forensic Investigation: Identifying Shared Folders on a Windows Host**

## 📂 **1. Registry Hives (Forensic Artifacts)**  
Shared folders are recorded in the Windows Registry.

### **Key Locations:**  
- **HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Shares**  
- **HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Shares\Security**  

### **Forensic Method:**  
1. Extract the `SYSTEM` hive from your forensic image.  
2. Open it in **Registry Viewer** (e.g., FTK Imager, RegistryExplorer, or Autopsy).  
3. Navigate to the `Shares` key to view shared folders.

**Example Entry:**  
```
SHARE1
    Path: C:\Program Files\Share1
SHARE2
    Path: D:\Folder\Share2
```

---

## 📂 **2. Event Logs**  
Check Windows **System Event Logs** (`System.evtx`) for share creation or access events.

### **Relevant Event IDs:**  
- **5142:** A network share object was added.  
- **5143:** A network share object was modified.  
- **5144:** A network share object was deleted.  

### **Tools:**  
- **Event Viewer**  
- **LogParser**  
- **Chainsaw**  

---

## 📂 **3. Filesystem Artifacts**  
Windows stores SMB (file share) metadata in **NTFS Alternate Data Streams (ADS)** or **FILE records**.

### **Tools:**  
- **FTK Imager:** Inspect the filesystem for known share paths.  
- **Autopsy/Sleuth Kit:** Search for paths manually.  
- **Plaso/Log2Timeline:** Build a timeline and look for share-related activity.  

---

## 📂 **4. Manual Artifact Search**  
Use keyword searches in your forensic tool for:
- `\\hostname\share`  
- `net share`  
- `C:\Windows\System32\drivers\etc\hosts`  
- `smb.conf` (if SMB configuration exists)  

---

## 🛠️ **5. Automated Tools for Artifact Analysis:**  
- **Volatility (if memory dump is available):**  
  ```bash
  python vol.py --profile=Win7SP1x64 shares
  ```  
- **KAPE (Kroll Artifact Parser and Extractor):**  
  Use the `Registry` and `System Event Log` modules.  

---

### ✅ **Expected Answer Format Example:**  
Once analyzed, your final answer should be formatted like this:  
```
C:\Program Files\Share1, D:\Folder\Share2
```

**Stay Methodical & Document Everything!**
