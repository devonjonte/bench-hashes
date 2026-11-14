.section .note.file-limit,"a",@note
.balign 4
.long 4, 4, 1
.asciz "APP"
.balign 4
.global note_limit
.type note_limit,@object
.size note_limit,4
note_limit:
.long LIMIT
.section .note.GNU-stack,"",@progbits
