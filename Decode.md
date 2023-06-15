# I. Decode with iconv 


```bash
# decode from text to base64 and pipe output to iconv
echo "text_to_decode" | base64 -d | iconv -f UTF-16LE -t UTF-8
# or use it directly
 iconv [options] [-f from-encoding] [-t to-encoding]
       [inputfile]..
```

