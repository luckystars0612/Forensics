# URL Scanning Tools
URL scanning tools are essential for assessing website safety, identifying technologies used, and checking security configurations. These tools often rely on public data sources like antivirus feeds and web archives.

- **[VirusTotal](https://www.virustotal.com/gui/)**: A versatile platform that scans URLs for malware using multiple antivirus engines, providing reputation scores and detailed reports. It's widely used for its comprehensive coverage, making it ideal for both novice and expert users.
- **[URLScan.io](https://urlscan.io/)**: Focuses on security issues by capturing HTTP request/response data, offering insights into potential vulnerabilities. It's user-friendly and provides visual snapshots, useful for quick assessments.
- **[SSL Labs](https://www.ssllabs.com/ssltest/)**: Provided by Qualys, this tool evaluates SSL/TLS configurations, ensuring websites meet security standards. It's particularly valuable for checking encryption strength, a critical aspect of website security.
- **[Wappalyzer](https://www.wappalyzer.com/)**: Identifies technologies used on websites, such as CMS, analytics, and frameworks, which can reveal potential vulnerabilities. It's available as a browser extension, making it accessible for real-time analysis.
- **[OSINT.SH](https://osint.sh/)**: An all-in-one platform offering DNS historical records, SSL certificate info, and technology stack checks. It supports URL-related tasks by providing comprehensive domain intelligence, though it's more of a web service than a standalone tool.

# IP Reputation Tools
IP reputation tools assess whether an IP address is associated with malicious activities, such as spam or botnet operations, using public blacklists and threat intelligence feeds.

- **[VirusTotal](https://www.virustotal.com/gui/)**: Extends to IP reputation, offering insights into whether an IP is linked to malicious domains or activities, leveraging its vast database.
- **[AbuseIPDB](https://www.abuseipdb.com/)**: A community-driven database for reporting and checking malicious IPs, providing scores based on abuse reports. It's free and widely used by sysadmins for quick checks.
- **(Cisco Talos)(https://talosintelligence.com/reputation_center)**: Offers IP and domain reputation data, derived from their extensive network of security appliances. While some features are free, it's more of a commercial service with open data access points.
- **[Shodan](https://www.shodan.io/)**: Known as a search engine for internet-connected devices, it provides IP details like open ports and services, which can indicate potential risks. While not a traditional reputation tool, it's valuable for exposure analysis.

# File Scanning Tools
File scanning tools detect malware or other threats within files, often using signatures or behavioral analysis from public sources.

- **[VirusTotal](https://www.virustotal.com/gui/)**: Allows file uploads for scanning against numerous antivirus engines, providing a consensus on whether a file is malicious. It's a go-to for quick file checks, especially for hashes.
- **[ClamAV](https://www.clamav.net/)**: An open-source antivirus engine, free for use, suitable for scanning files on local systems. It's widely integrated into security solutions, offering robust malware detection.
- **[MalwareBazaar](https://bazaar.abuse.ch/browse/)**: A repository of malware samples, searchable by hash, providing insights into known malicious files. It's open-source and community-driven, ideal for researchers.

# IOC Checking Tools
IOC checking involves searching for known indicators of compromise, such as file hashes, IPs, or domains, to identify potential threats.

- **[VirusTotal](https://www.virustotal.com/gui/)**: Supports searching for IOCs, including hashes, IPs, and domains, with detailed reports from its aggregated sources. It's a central hub for threat intelligence.
- **[OTXAlienVault](https://otx.alienvault.com/dashboard/new)**: A threat intelligence platform with a global community, offering over 14 million daily threat indicators. It's free and supports IOC searches, enhancing collaborative research.
- **[ThreatCrowd](http://ci-www.threatcrowd.org/)**: A search engine for threat intelligence, aggregating data on IPs, domains, and hashes from public sources, useful for quick lookups.

# General search
- [Virustotal](https://www.virustotal.com/gui/home/search)
- [Abuse hunting](https://hunting.abuse.ch/)

| Tool                        | URL Scanning | IP Reputation | File Scanning | IOC Checking | Notes                              |
|-----------------------------|--------------|--------------|--------------|--------------|------------------------------------|
| VirusTotal                  | Yes          | Yes          | Yes          | Yes          | Versatile, web-based service      |
| URLScan.io                  | Yes          | No           | No           | No           | Focus on HTTP analysis            |
| SSL Labs' SSL Test          | Yes          | No           | No           | No           | SSL/TLS focus                     |
| Wappalyzer                  | Yes          | No           | No           | No           | Tech detection                    |
| OSINT.SH                    | Yes          | Partial      | No           | Partial      | Domain-focused                    |
| AbuseIPDB                   | No           | Yes          | No           | No           | Community-driven IP checks        |
| Cisco Talos Intelligence    | No           | Yes          | No           | Partial      | Commercial with free data         |
| Shodan                      | Partial      | Yes          | No           | Partial      | Device discovery                  |
| ClamAV                      | No           | No           | Yes          | No           | Open-source antivirus             |
| MalwareBazaar               | No           | No           | Yes          | Partial      | Malware hash repository           |
| AlienVault OTX              | No           | Partial      | No           | Yes          | Community threat intelligence     |
| ThreatCrowd                 | No           | Partial      | No           | Yes          | Threat search engine              |
