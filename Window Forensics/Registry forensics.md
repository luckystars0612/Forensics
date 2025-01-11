[Reference](https://medium.com/@dziyaaa/registry-forensic-analysis-317192c9cf59)
# I. What is Registry
- The Windows Registry is a collection of databases that contains the system’s configuration data. This configuration data can be about the hardware, the software, or the user’s information. It also includes data about the recently used files, programs used, or devices connected to the system.
- The Windows registry consists of Keys and Values. When you open the regedit.exe utility to view the registry, the folders you see are Registry Keys. Registry Values are the data stored in these Registry Keys. A Registry Hive is a group of Keys, subkeys, and values stored in a single file on the disk.
- The registry on any Windows system contains the following five root keys:
    + HKEY_CURRENT_USER
    + HKEY_USERS
    + HKEY_LOCAL_MACHINE
    + HKEY_CLASSES_ROOT
    + HKEY_CURRENT_CONFIG
## 1. HKEY_CURRENT_USER
- Contains the root of the configuration information for the user who is currently logged on. This hive control user-level settings like the installed printers, desktop wallpaper, display settings, environment variables, keyboard layout, mapped network drives, and more.
## .2 HKEY_USERS: 
- Contains all the actively loaded user profiles on the computer. HKEY_CURRENT_USER is a subkey of HKEY_USERS. HKEY_USERS is sometimes abbreviated as HKU. It contains user-specific configuration information for all currently active users on the computer. This means the user logged in at the moment (you) and any other users who have also logged in but have since "switched users”.
```bash
\\\\//SAM hive. Accounts with RIDs starting with 10xx are user created accounts
S-1-5-7 Anonymous Logon
S-1-5-11 Authenticated Users
S-1-5-18 System (or LocalSystem)
S-1-5-19 NT Authority (LocalService)
S-1-5-20 Network Service
S-1-5-21 User accounts (and also domains?)

S-1-5-21-1004336348-1177238915-682003330-512
A revision level (1)
An identifier authority (5, NT Authority)
A domain identifier (21-1004336348-1177238915-682003330, Contoso)
A relative identifier (512, Domain Admins)

You can find all list in
https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-security-identifiers
```
## 3. HKEY_LOCAL_MACHINE
- Contains configuration information particular to the computer(including boot configuration and keyboard) (for any user). This key is sometimes abbreviated as HKLM.
```bash
HKEY_LOCAL_MACHINE\SOFTWARE\Classes\*\shellex\ContextMenuHandlers\WinRAR

in the field we are seeing this value:{B41DB860–64E4–11D2–9906-E49FADC173CA}
(copy the original value before changing it) if we change to “-” we cannot 
see 4 winrar options when we right-clict to a folder again.

Five main registry hives DEFAULT,SAM,SECURITY,SOFTWARE and system located to 
C:\Windows\System32\Config but some hiveslocated different paths such AmCache 
hive located at C:\Windows\AppCompat\Programs\Amcache.hve
//also we can change keyboard settings from here
```
## 4.  HKEY_CLASSES_ROOT
- HKEY_CLASSES_ROOT, often shortened as HKCR, is a registry hive in the Windows Registry and contains file extension association information, as well as a programmatic identifier (ProgID), Class ID (CLSID), and Interface ID (IID) data. If you delete this section even if computers opened you cannot open files.
## 5. HKEY_CURRENT_CONFIG
- Contains information about the hardware profile that is used by the local computer at system startup.
# II. Registry analysis artifacts
![plot](./resources/registry/registry1.png)
- In live system you will be able to access the registry using regedit.exe. However, in most cases you need to investigate registry hives on disk images you need to know path of it. The majority of these hives are located in the C:\Windows\System32\Config directory and are:
    + DEFAULT (mounted on HKEY_USERS\DEFAULT)
    + SAM (mounted on HKEY_LOCAL_MACHINE\SAM)
    + SECURITY (mounted on HKEY_LOCAL_MACHINE\Security)
    + SOFTWARE (mounted on HKEY_LOCAL_MACHINE\Software)
    + SYSTEM (mounted on HKEY_LOCAL_MACHINE\System)
## Hives containing user information:
- Apart from these hives, two other hives containing user information can be found in the User profile directory. For Windows 7 and above, a user’s profile directory is located in C:\Users\<username>\ where the hives are:
    + 1. NTUSER.DAT (mounted on HKEY_CURRENT_USER when a user logs in)
        The NTUSER.DAT hive is located in the directory **C:\Users\<username>\.**
    + 2. USRCLASS.DAT (mounted on HKEY_CURRENT_USER\Software\CLASSES)
        The USRCLASS.DAT hive is located in the directory **C:\Users\<username>\AppData\Local\Microsoft\Windows.**
    > !!! To open HKEY_USERS hives you may need to load NTUSER.DAT in to the HKEY_USERS .
## The Amcache Hive:
- Apart from these files, there is another very important hive called the AmCache hive. This hive is located in **C:\Windows\AppCompat\Programs\Amcache.hve**. Windows creates this hive to save information on programs that were recently run on the system.
## Transaction Logs and Backups:
- Some other very vital sources of forensic data are the registry transaction logs and backups. The transaction logs can be considered as the journal of the changelog of the registry hive. Windows often uses transaction logs when writing data to registry hives. This means that the transaction logs can often have the latest changes in the registry that haven’t made their way to the registry hives themselves. The transaction log for each hive is stored as a .LOG file in the same directory as the hive itself. It has the same name as the registry hive, but the extension is .LOG. For example, the transaction log for the SAM hive will be located in **C:\Windows\System32\Config** in the filename SAM.LOG. Sometimes there can be multiple transaction logs as well. In that case, they will have .LOG1, .LOG2 etc., as their extension. It is prudent to look at the transaction logs as well when performing registry forensics.
- Registry backups are the opposite of Transaction logs. These are the backups of the registry hives located in the **C:\Windows\System32\Config** directory. These hives are copied to the C:\Windows\System32\Config\RegBack directory every ten days. It might be an excellent place to look if you suspect that some registry keys might have been deleted/modified recently.
# III. Important parts
## 1. NTUSER.dat
- We can see the recently opened files by going to the ***RecentDocs*** file under NTUSER.DAT. C:\Users\<username>
- RunMRU shows the applications that are searched and run with the Run application ***(Windows key + R)*** from the RunMRU file.
## 2. SYSTEM hive
- By going under the ***USBTOR** file **(System/ControlSet/enum/usbstor)**, we can see the manufacturers, serial numbers and times of the inserted usb devices in detail. (Software/windows/windows portable devices/Devices)
- The ***MountedDevices*** file shows the storage devices installed in the computer.
## 3. SAM hive
- Under the SAM file ( location:**SAM\Domains\Account\Users**), we can access the last login date, password hint and password change dates of the users.
## 4. SOFTWARE hive
- CurrentVersion provides information about the operating system. It stored **SOFTWARE\Microsoft\Windows NT\CurrentVersion**
- Network name, connection date, departure date, etc. related to the wireless networks connected from the ***NetworkList*** section. we can access information.
- In the ***Run*** file, it shows the startup programs.
- The ***LogonUI*** file contains the last login user information.
- Under the ***Volume Info Cache*** file, we see the connected storage partitions.
- ***Uninstall*** provides information about the uninstalled applications.
- Under the ***Windows Portable Device*** file, there is information about the connected devices.
## 5. UserAssist
- Windows keeps track of applications launched by the user using Windows Explorer for statistical purposes in the User Assist registry keys. These keys contain information about the programs launched, the time of their launch, and the number of times they were executed. However, programs that were run using the command line can’t be found in the User Assist keys. The User Assist key is present in the NTUSER hive, mapped to each user’s GUID. We can find it at the following location:
**NTUSER.DAT\Software\Microsoft\Windows\Currentversion\Explorer\UserAssist\{GUID}\Count**
## 6. SimCache
- ShimCache is a mechanism used to keep track of application compatibility with the OS and tracks all applications launched on the machine. Its main purpose in Windows is to ensure backward compatibility of applications. It is also called Application Compatibility Cache (AppCompatCache). It is located in the following location in the SYSTEM hive:
**SYSTEM\CurrentControlSet\Control\Session Manager\AppCompatCache**
- ShimCache stores file name, file size, and last modified time of the executables.
- The used Registry Explorer tool, doesn’t parse ShimCache data in a human-readable format, so we go to another tool called AppCompatCache Parser, also a part of Eric Zimmerman’s tools. It takes the SYSTEM hive as input, parses the data, and outputs a CSV file.
```bash
AppCompatCacheParser.exe --csv <path to save output> -f <path to SYSTEM hive for data parsing> -c <control set to parse>
```
## 7. AmCache
- The AmCache hive is an artifact related to ShimCache. This performs a similar function to ShimCache, and stores additional data related to program executions. This data includes execution path, installation, execution and deletion times, and SHA1 hashes of the executed programs. This hive is located in the file system at:
**C:\Windows\appcompat\Programs\Amcache.hve**
- Information about the last executed programs can be found at the following location in the hive:
**Amcache.hve\Root\File\{Volume GUID}\***
## 8. BAM/DAM
- ***Background Activity Monitor or BAM*** keeps a tab on the activity of background applications. Similar ***Desktop Activity Moderator or DAM*** is a part of Microsoft Windows that optimizes the power consumption of the device. Both of these are a part of the Modern Standby system in Microsoft Windows.
- In the Windows registry, the following locations contain information related to BAM and DAM. This location contains information about last run programs, their full paths, and last execution time.
**SYSTEM\CurrentControlSet\Services\bam\UserSettings\{SID}**
**SYSTEM\CurrentControlSet\Services\dam\UserSettings\{SID}**