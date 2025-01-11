# 📂 Google Play Search Artifact Locations in Autopsy

When analyzing Google Play Search artifacts in Autopsy, search activity is typically extracted from specific SQLite databases or cached files within the device's file system. These artifacts record user interactions with the Google Play Store search bar.

---

## 📍 **1. Google Play Store Database**
- **Path:** `/data/data/com.android.vending/databases/library.db`
- **Alternative Path:** `/data/data/com.android.vending/databases/suggestions.db`
- **Description:** Contains records of user searches and app recommendations.

---

## 📍 **2. Search History Cache**
- **Path:** `/data/data/com.google.android.googlequicksearchbox/databases/search_history.db`
- **Description:** Stores general search history, including searches made in Google Play.

---

## 📍 **3. User Activity (Google Account)**
- **Path:** `/data/data/com.google.android.gms/databases/`
- **Description:** Some Google Play searches may also be logged in Google Services databases.

---

## 📍 **4. Application Logs**
- **Path:** `/data/log`
- **Alternative Path:** `/data/system/dropbox/`
- **Description:** Residual logs of search activity may be found here.

---

## 📍 **5. XML Configurations**
- **Path:** `/data/data/com.android.vending/shared_prefs/`
- **Description:** Preferences and saved searches might reside here.

---

## 🛠️ **How to Extract in Autopsy**
1. Go to **Data Artifacts → Installed Applications → Google Play Store**
2. Look under **User Searches** or **App Suggestions**
3. Use **SQLite Browser** to manually analyze `library.db` and `suggestions.db`
4. Focus on specific tables like `search_history`, `recent_searches`, or similar

---

## 📊 **Key Fields to Look For:**
- `query`: The search term entered.
- `timestamp`: Time of search.
- `user_id`: User account associated with the search.

---

## 📝 **Recommendations:**
- Use **DB Browser for SQLite** to inspect the above files.
- Focus on fields like `query`, `timestamp`, or `user_id`.
- If files are missing, inspect cache and system logs for alternative traces.

---

For further assistance in parsing these databases or extracting specific details, feel free to ask! 🚀
