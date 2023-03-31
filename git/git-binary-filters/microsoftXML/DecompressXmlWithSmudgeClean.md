# Overview

Microsoft XML formats (.docx, .xlsx, .pptx, etc.) are XML files that have been compressed. By uncompressing the files, these can be saved in Git in a text rather than binary format. A file can be decompressed by changing the extension from, e.g., `.docx`, to `.zip`. Then uncompress to see the data.

## Git clean() filter

```pseudocode
clean(){
  uncompress($1) -> $2/
  assemble($2) -> $1
}
```



## Git smudge() filter

```pseudocode
smudge(){
  compress($1) (zip, normal, deflate)
}
```



## Notes

For `git status`, ignore the actual file. Run a prestatus hook to convert changed Word document to decompressed XML, then have Git look a t XML for changes.

Git has no knowledge of .docx files, only XML folders. Whenever it processes or looks at one of these files, it first "cleans" it by uncompressing it as XML. Whenever it saves the file to the working directory for the user, it "smudges" it by compressing it again and saving it as a .docx

Will this work as uncompressing creates more files than were there originally? The filter needs to operate on multiple files... How does this get triggered?