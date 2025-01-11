# 📆 Finding Installation Date of `mega.privacy.android.app` on Android

To determine when the `mega.privacy.android.app` was installed, you can check specific artifacts within the Android file system or use tools like **Autopsy**, **ADB**, or **SQLite Browser**. Below are the key methods and artifact locations:

---

## 📂 **1. Package Manager Database**
- **Path:** `/data/system/packages.xml`  
- **Description:** This XML file maintains metadata about installed apps, including their installation timestamps.
- **How to analyze:**
   - Open `packages.xml` in a text editor or Autopsy.
   - Search for:
     ```xml
     <package name="mega.privacy.android.app" ... >
     ```
   - Look for the `firstInstallTime` attribute, which represents the app installation date and time.

### Example:
```xml
<package name="mega.privacy.android.app" codePath="/data/app/mega.privacy.android.app"
    firstInstallTime="2024-11-03T10:15:30.123Z"
    lastUpdateTime="2024-11-05T12:25:00.456Z"/>
```

- **Key Field:** `firstInstallTime`

---

## 🗂️ **2. App-Specific Folders' Timestamps**
- **Path:** `/data/data/mega.privacy.android.app/`  
- **Alternative Path:** `/data/app/mega.privacy.android.app-*`  
- **Description:** The folder's creation timestamp can indicate the approximate installation date.
- **How to analyze:**
   - Use ADB or forensic tools to check folder metadata:
     ```sh
     ls -l /data/data/mega.privacy.android.app/
     ```
   - Look for the **creation timestamp**.

---

## 📑 **3. Google Play Store Data**
- **Path:** `/data/data/com.android.vending/databases/library.db`  
- **Alternative Path:** `/data/data/com.android.vending/databases/suggestions.db`  
- **Description:** Tracks app installations via the Play Store.
- **How to analyze:**
   - Open `library.db` in SQLite Browser.
   - Query the installation history:
     ```sql
     SELECT * FROM app_state WHERE package_name='mega.privacy.android.app';
     ```
   - Look for fields like `install_time` or timestamps.

---

## 🛡️ **4. System Logs**
- **Path:** `/data/system/dropbox/`  
- **Description:** System logs may capture app installation events.
- **How to analyze:**
   - Search logs for:
     ```text
     Installed package: mega.privacy.android.app
     ```
   - Check timestamps nearby.

---

## 🔍 **5. ADB Command (If Device is Accessible)**
- Use ADB to directly retrieve installation information:
   ```sh
   adb shell dumpsys package mega.privacy.android.app | grep -i "firstInstallTime"
   ```
- **Output Example:**
   ```
   firstInstallTime=2024-11-03T10:15:30.123Z
   ```

---

## 🛠️ **6. Using Autopsy**
- In **Autopsy**, navigate to:
   - **Data Artifacts → Installed Applications**
   - Locate `mega.privacy.android.app`.
   - Check associated metadata, including `firstInstallTime`.

---

## 📝 **Key Takeaways:**
1. **Primary Source:** `/data/system/packages.xml` → `firstInstallTime` field.  
2. **Secondary Source:** Folder creation timestamps in `/data/data/` or `/data/app/`.  
3. **Additional Sources:** Play Store databases (`library.db`) and system logs (`/data/system/dropbox/`).  
4. **Quick Check (ADB):** `adb shell dumpsys package mega.privacy.android.app`

If you encounter difficulties extracting this data or need help analyzing the results, let me know! 🚀
