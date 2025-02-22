
# Tracing Malicious Function Changes in Git Repository

## Step-by-Step Instructions

### 1. Ensure You're in a Git Repository
Verify the `.git` folder exists in your project directory:
```bash
ls -a
```

### 2. Examine Commit History
Use `git log` to view the commit history:
```bash
git log
```
List all commit
```bash
git log --oneline --graph --decorate --all
```
Show commit change code
```bash
git show commit_hash
```
- Look for suspicious commit messages like "cleanup", "fix comments", or "refactor code".

### 3. Find Changes in Specific Functions
Locate references to the malicious function using:
```bash
git grep "malicious_function_name"
```
Replace `malicious_function_name` with the function name or part of the comment.

### 4. Identify the Commit That Modified the Comments
Use `git blame` to see who modified the lines:
```bash
git blame file_name | grep "malicious_function_name"
```
Replace `file_name` with the file containing the malicious function.

### 5. Inspect Specific Commits
View changes in a particular commit:
```bash
git show commit_hash
```
Replace `commit_hash` with the commit hash from `git log` or `git blame`.

### 6. Search for Deletions
Find commits where specific text (like comments) was added or removed:
```bash
git log -S"comment text or malicious_function_name"
```
Replace `comment text or malicious_function_name` with part of the removed comment or function name.

### 7. Analyze the Working Tree
If there are uncommitted changes:
```bash
git diff
```

### 8. Rebuild Deleted History
Inspect the reflog to recover rewritten or deleted commits:
```bash
git reflog
```

### 9. Export and Save Findings
If needed, export specific commits or the entire repository for further analysis:
```bash
git archive --format=zip --output=repository.zip HEAD
```

## Summary
These steps help trace when and how comments for a malicious function were removed or altered. Use these commands to identify and analyze suspicious changes.

---

*Feel free to share any specific details or files for further assistance!*
