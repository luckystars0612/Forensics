# Hunting for Hidden Processes in Linux using Volatility 3

## 1. List Running Processes (Check for Hidden PIDs)
Run the `linux.pslist` plugin to check running processes:

```bash
volatility3 -f memory.img linux.pslist.PsList
```

- If a process is missing from `/proc`, but you suspect it's running, a **rootkit may be hiding it**.

---

## 2. Check Zombie or Unlinked Processes
Use the `linux.psaux` plugin to get a detailed list of processes, including those hidden from standard tools:

```bash
volatility3 -f memory.img linux.psaux.PsAux
```

- Look for **unusual PIDs** or processes with missing **PPID (Parent Process ID)**.
- If a process **exists in pslist but not in psaux**, it might be hidden.

---

## 3. Scan for Malicious Signals (SIGINVISIBLE 63)
Some rootkits **modify signal handlers** to hide processes. To detect such manipulation, check system call hooks:

```bash
volatility3 -f memory.img linux.check_syscall.Check_syscall
```

- Look for **hooked or modified syscalls** (`kill`, `tgkill`, `sys_kill`).
- Example rootkit modification:
  ```c
  if (sig == 63) {  // SIGINVISIBLE
      current->flags ^= PF_INVISIBLE;
      return 0;
  }
  ```

---

## 4. Detect Hidden Kernel Modules
If the rootkit is an **LKM (Loadable Kernel Module)**, it might be hiding processes using a kernel module.

```bash
volatility3 -f memory.img linux.hidden_modules.HiddenModules
```

- If a module is detected here, it is likely **malicious**.

---

## 5. Inspect Process Flags (PF_INVISIBLE)
Some rootkits use **`PF_INVISIBLE`** or similar flags in the process descriptor to hide processes.

```bash
volatility3 -f memory.img linux.proc.PsTree
```

- If a process exists **in memory but not in the process list**, it may be hidden.

---

## 6. Extract and Analyze Suspicious Modules
If a hidden module is found, extract it:

```bash
volatility3 -f memory.img linux.moddump.ModDump --output-dir dump/ -m <module_name>
```

- Analyze it with:
  ```bash
  strings dump/<module_name>.ko | less
  objdump -d dump/<module_name>.ko
  ```

---

## Conclusion
If a **process is missing from `pslist` but running**, or **a syscall is hooked to hide PIDs**, you likely have a **rootkit hiding processes via SIGINVISIBLE (63) or similar signals**.

Use these Volatility 3 techniques to hunt for hidden processes and malicious rootkits effectively. 🚀
