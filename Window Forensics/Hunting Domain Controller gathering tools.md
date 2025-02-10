
# Tools to Gather Information About Domain Controllers

## **Built-in Windows Tools**
1. **PowerShell Commands**
   - `Get-ADDomainController`
   - `Get-ADDomain`
   - `Get-ADForest`
   - `Get-ADGroupMember`
   - `Get-ADReplicationPartnerMetadata`

2. **Nltest.exe**
   - `nltest /dsgetdc:<domain_name>` – Retrieve a domain controller.
   - `nltest /dclist:<domain_name>` – List domain controllers.
   - `nltest /server:<server_name> /sc_query:<domain_name>` – Check secure channel status.

3. **Net Commands**
   - `net view /domain`
   - `net group /domain`
   - `net user /domain`
   - `net accounts /domain`

4. **Active Directory Users and Computers (ADUC)**
   - GUI-based tool to manage domain controllers and view their details.

5. **Dsquery.exe**
   - `dsquery server -o rdn` – Find all domain controllers.
   - `dsquery user` – Query domain users.

6. **Repadmin.exe**
   - `repadmin /showrepl` – Show replication partners.
   - `repadmin /replsummary` – Get replication summary.

7. **System Information Tools**
   - `systeminfo` – Lists domain controller name if the machine is joined to a domain.
   - `ipconfig /all` – Shows the DNS server that might point to the domain controller.

---

## **Microsoft Management Tools**
1. **RSAT (Remote Server Administration Tools)**
   - Includes tools like ADUC, Active Directory Administrative Center, and PowerShell modules.

2. **Event Viewer**
   - Event logs (e.g., Directory Service logs) can give information about domain controllers.

3. **Group Policy Management Console (GPMC)**
   - Used to view policies associated with domain controllers.

---

## **Network Tools**
1. **Nslookup**
   - `nslookup -type=SRV _ldap._tcp.dc._msdcs.<domain_name>` – Find domain controllers.

2. **Ping**
   - To check the domain controller’s hostname or IP.

3. **LDAP Queries**
   - Use tools like **LDP.exe** or scripts to query the LDAP service for domain information.

---

## **Third-party and Open-source Tools**
1. **ADExplorer** (Sysinternals)
   - A GUI-based tool to browse and search Active Directory.

2. **BloodHound**
   - Visualizes Active Directory relationships, often used by red teams.

3. **LDAP Admin**
   - A free LDAP client for querying Active Directory.

4. **CIMCmdlets**
   - Powershell module for interacting with WMI and retrieving domain information.

5. **Advanced Port Scanners**
   - Tools like Nmap can identify domain controllers by looking for open LDAP, Kerberos, or SMB ports.

6. **Netdom**
   - `netdom query dc` – Lists all domain controllers in the current domain.

---

## **Custom Scripting**
1. **Python Libraries**
   - `ldap3` – For querying LDAP directories.
   - `pyad` – For interacting with Active Directory.

2. **Golang Libraries**
   - Libraries like `go-ldap` can interact with Active Directory for domain controller information.

---

## **Administrative Web Interfaces**
1. **ADFS Management**
   - If ADFS is configured, the management portal often reveals domain controllers.

2. **Azure AD Connect**
   - Sync information can give details about the on-premises domain controllers.
