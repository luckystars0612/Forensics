# 📱 Android Forensics: Key Artifacts and Their Locations

In Android forensics, artifacts are digital traces left by user activity, system processes, and applications. Below is a comprehensive overview of the primary artifacts categorized by their sources.

---

## 📱 **1. Device Information**
- **Purpose:** Identify device specifics, settings, and system version.
- **Key Artifacts:**  
  - `/system/build.prop` → Device build properties (e.g., OS version, device model).  
  - `/system/etc/hosts` → Custom DNS settings.  
  - `/data/system/packages.xml` → Installed apps and permissions.  
  - `/data/system/users/` → User accounts on multi-user devices.

---

## 📞 **2. Call Logs & Contacts**
- **Purpose:** Communication history and user contacts.
- **Key Artifacts:**  
  - `/data/data/com.android.providers.contacts/databases/contacts2.db` → Contacts database.  
  - `/data/data/com.android.providers.contacts/databases/calllog.db` → Call logs.  
  - `/data/data/com.android.providers.telephony/databases/mmssms.db` → SMS and MMS messages.

---

## 📧 **3. Messaging and Chat Apps**
- **Purpose:** Recover text and multimedia messages.
- **Key Apps and Artifacts:**  
  - **WhatsApp:** `/data/data/com.whatsapp/databases/msgstore.db`  
  - **Telegram:** `/data/data/org.telegram.messenger/files`  
  - **Signal:** `/data/data/org.thoughtcrime.securesms/databases`  
  - **Facebook Messenger:** `/data/data/com.facebook.orca/databases/threads_db2`

---

## 🌐 **4. Web Browsing History**
- **Purpose:** Track internet activity and user searches.
- **Key Artifacts:**  
  - **Chrome:** `/data/data/com.android.chrome/app_chrome/Default/History`  
  - **Firefox:** `/data/data/org.mozilla.firefox/files/mozilla/*.default`  
  - **Samsung Internet:** `/data/data/com.sec.android.app.sbrowser/app_sbrowser/Default/History`

---

## 📍 **5. Location Data**
- **Purpose:** Track user movements and location history.
- **Key Artifacts:**  
  - `/data/data/com.google.android.apps.maps/databases` → Google Maps data.  
  - `/data/data/com.android.location.provider/databases` → Location services.  
  - `/data/system/locations` → Cached location data.

---

## 📷 **6. Media Files**
- **Purpose:** Access photos, videos, and audio recordings.
- **Key Artifacts:**  
  - `/storage/emulated/0/DCIM/` → Photos taken by the camera.  
  - `/storage/emulated/0/Download/` → Downloaded files.  
  - `/storage/emulated/0/WhatsApp/Media/` → WhatsApp media files.

---

## 🛡️ **7. Security and Authentication Data**
- **Purpose:** Unlock patterns, PINs, and biometric data.
- **Key Artifacts:**  
  - `/data/system/gesture.key` → Pattern lock (hashed).  
  - `/data/system/password.key` → PIN or password (hashed).  
  - `/data/system/locksettings.db` → Lock screen settings.

---

## 🛠️ **8. Application Data**
- **Purpose:** Extract data from installed apps.
- **Key Artifacts:**  
  - `/data/data/<package_name>` → App-specific data.  
  - `/data/data/<package_name>/shared_prefs/` → User preferences and configurations.  
  - `/data/user_de/0/<package_name>` → User encryption-related data.

---

## 📂 **9. System Logs**
- **Purpose:** Review system and app logs for crash reports and error analysis.
- **Key Artifacts:**  
  - `/data/log/` → System and kernel logs.  
  - `/data/anr/` → App Not Responding (ANR) logs.  
  - `/data/system/dropbox/` → Event logs.

---

## 🗺️ **10. Network Data**
- **Purpose:** Identify Wi-Fi connections, saved passwords, and network usage.
- **Key Artifacts:**  
  - `/data/misc/wifi/wpa_supplicant.conf` → Saved Wi-Fi networks (older versions).  
  - `/data/misc/wifi/WifiConfigStore.xml` → Wi-Fi configurations (newer versions).  
  - `/proc/net/` → Active network connections.

---

## 🔐 **11. Encrypted Data**
- **Purpose:** Analyze encrypted data if keys are available.
- **Key Artifacts:**  
  - `/data/misc/keystore` → Encryption keys.  
  - `/data/system/users/0/` → User-specific encrypted data.

---

## 🛒 **12. App Store Data**
- **Purpose:** Identify installed and downloaded apps.
- **Key Artifacts:**  
  - `/data/data/com.android.vending/databases/` → Google Play Store data.  
  - `/data/data/com.android.packageinstaller` → Package installation records.

---

## 🗑️ **13. Deleted Data**
- **Purpose:** Recover deleted files and records.
- **Techniques:**  
  - File carving tools (e.g., `Scalpel`, `Autopsy`).  
  - Analyze unallocated space.

---

## 🛡️ **14. Anti-Forensics Techniques**
- **Purpose:** Detect signs of user tampering or attempts to erase evidence.
- **Key Indicators:**  
  - Factory reset logs.  
  - Wiped cache/data partitions.  
  - Anomalous timestamps.

---

## 📊 **Tools for Android Forensics**
- **Autopsy**  
- **ADB (Android Debug Bridge)**  
- **Oxygen Forensic Suite**  
- **UFED (Cellebrite)**  
- **Magnet AXIOM**  
- **Mobiledit Forensic Express**  
- **ADB Extractor Tools**

---

### 📝 **Forensic Best Practices:**
1. Use a Faraday bag to isolate the device from networks.  
2. Acquire both logical and physical images.  
3. Ensure chain of custody documentation.  
4. Avoid modifying data during acquisition.

Let me know if you need in-depth details on any specific artifact or forensic tools! 🚀
