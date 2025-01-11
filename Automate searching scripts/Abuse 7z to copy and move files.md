
# Using 7-Zip to Copy and Move Files

## Copying Files Using 7-Zip
To **copy** files, you use the `a` (add) command to create an archive that includes the desired files.

### Syntax for Copying Files with 7-Zip:
```
7z a <archive_name> <file_path>
```

- `a`: Add files to an archive.  
- `<archive_name>`: The name of the new archive.  
- `<file_path>`: Path to the file or folder to copy.

### Example:
```
7z a archive.zip C:\source\file.txt
```

- **Effect:** Creates `archive.zip` containing `file.txt` in the current directory.  
- **Result:** File is effectively "copied" into the archive.

---

## Moving Files Using 7-Zip
7-Zip doesn't have a direct "move" command, but you can simulate a **move operation** by:
1. **Adding the file to an archive** (`a`)  
2. **Extracting it to a new location** (`x`)  
3. **Deleting the original file manually**

### Syntax for Moving Files:
#### Step 1: Archive the File (Copy Step)
```
7z a archive.zip C:\source\file.txt
```

#### Step 2: Extract to the Destination Path
```
7z x archive.zip -oC:\destination\
```

- `x`: Extract files from the archive.  
- `-o`: Specify the output directory.  

#### Step 3: Delete the Original File
```
del C:\source\file.txt
```

### One-Liner Move Example:
```
7z a archive.zip C:\source\file.txt && 7z x archive.zip -oC:\destination\ && del C:\source\file.txt
```

---

## Moving Entire Folders
You can apply the same principles to folders:

### Example: Move Folder
```
7z a archive.zip C:\source\folder\
7z x archive.zip -oC:\destination\
rd /s /q C:\source\folder\
```

- `rd /s /q`: Removes the original folder (`/s` removes all subfolders, `/q` skips confirmation).

---

## Real-World Example of Attacker Usage
An attacker might do something like this:
```
7z a sensitive_data.7z C:\SensitiveFolder
7z x sensitive_data.7z -oD:\HiddenFolder\
del C:\SensitiveFolder
```

- **Step 1:** Compress `C:\SensitiveFolder` into `sensitive_data.7z`
- **Step 2:** Extract it to `D:\HiddenFolder\`
- **Step 3:** Delete the original folder to cover tracks

---

## Tips and Flags for Stealth
- **`-p`**: Add a password to the archive  
  ```
  7z a -pMySecretPassword archive.zip C:\source\file.txt
  ```
- **`-mhe=on`**: Enable header encryption (hides filenames inside the archive)  
  ```
  7z a -pMySecretPassword -mhe=on archive.zip C:\source\file.txt
  ```
- **Quiet Mode (`-bso0 -bsp0`)**: Suppress console output for stealth  
  ```
  7z a archive.zip C:\source\file.txt -bso0 -bsp0
  ```

---

## Cheat Sheet

| **Operation**  | **Command**                           |
|-----------------|---------------------------------------|
| Copy a file    | `7z a archive.zip C:\source\file.txt`  |
| Move a file    | `7z a archive.zip C:\source\file.txt && 7z x archive.zip -oC:\destination\ && del C:\source\file.txt` |
| Copy a folder  | `7z a archive.zip C:\source\folder\`   |
| Move a folder  | `7z a archive.zip C:\source\folder\ && 7z x archive.zip -oC:\destination\ && rd /s /q C:\source\folder\` |
| Add password   | `7z a -pSecret archive.zip C:\file.txt` |
| Enable header encryption | `7z a -pSecret -mhe=on archive.zip C:\file.txt` |

---

