# I. Volatility 3 

## 1. View running processes in Window

```bash
python3 vol.py -f /path/to/file windows.pslist
```

## 2. Scan the active network connections
```bash
python3 vol.py -f /path/to/file windows.netscan
```

## 3. Search for files open
```bash
python3 vol.py -f /path/to/file windows.filescan
# if want to find a specific file
python3 vol.py -f /path/to/file windows.filescan | grep "filename"
```

## 4. Dump files in a specific memory address
```bash
# if want to dump a specific file in physical memory
python3 vol.py -f /path/to/file -o /path/to/dir windows.dumpfiles --physaddr "memaddr"
# if want to dump a specific file in virtual memory
python3 vol.py -f /path/to/file -o /path/to/dir windows.dumpfiles --virtaddr "memaddr"
```