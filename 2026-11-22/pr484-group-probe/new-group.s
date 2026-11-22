	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$4096, %rsp
	movq	$0, (%rsp)
	subq	$1096, %rsp
	leaq	-2(%rcx), %rax
	cmpq	$126, %rax
	ja	.LBB13_10
	movq	8(%rdx), %rax
	leaq	-1(%rax), %r10
	movq	%rax, %r11
	xorq	%r10, %r11
	cmpq	%r10, %r11
	jbe	.LBB13_10
	rep		bsfq	%rax, %rax
	addq	$-6, %rax
	cmpq	$4, %rax
	ja	.LBB13_10
	movzbl	32(%rdi), %r13d
	leaq	.LJTI13_0(%rip), %r10
	movslq	(%r10,%rax,4), %rax
	addq	%r10, %rax
	jmpq	*%rax
	leaq	(,%rcx,8), %r10
	xorl	%r11d, %r11d
	cmpq	$64, 8(%rdx,%r11,2)
	sete	%al
	jne	.LBB13_11
	movq	(%rdx,%r11,2), %rbx
	movq	%rbx, 56(%rsp,%r11)
	addq	$8, %r11
	cmpq	%r11, %r10
	jne	.LBB13_5
	movq	%rcx, 1080(%rsp)
	leaq	-1(%rcx), %r10
	movl	%ecx, %edx
	andl	$3, %edx
	cmpq	$3, %r10
	jae	.LBB13_63
	xorl	%ebx, %ebx
	jmp	.LBB13_66
	xorl	%eax, %eax
	addq	$5192, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
	leaq	(,%rcx,8), %r10
	xorl	%r11d, %r11d
	cmpq	$1024, 8(%rdx,%r11,2)
	sete	%al
	jne	.LBB13_11
	movq	(%rdx,%r11,2), %rbx
	movq	%rbx, 56(%rsp,%r11)
	addq	$8, %r11
	cmpq	%r11, %r10
	jne	.LBB13_13
	movq	%rcx, 1080(%rsp)
	leaq	-1(%rcx), %r10
	movl	%ecx, %edx
	andl	$3, %edx
	cmpq	$3, %r10
	jae	.LBB13_33
	xorl	%ebx, %ebx
	jmp	.LBB13_36
	leaq	(,%rcx,8), %r10
	xorl	%r11d, %r11d
	cmpq	$256, 8(%rdx,%r11,2)
	sete	%al
	jne	.LBB13_11
	movq	(%rdx,%r11,2), %rbx
	movq	%rbx, 56(%rsp,%r11)
	addq	$8, %r11
	cmpq	%r11, %r10
	jne	.LBB13_18
	movq	%rcx, 1080(%rsp)
	leaq	-1(%rcx), %rdx
	movl	%ecx, %r10d
	andl	$3, %r10d
	cmpq	$3, %rdx
	jae	.LBB13_43
	xorl	%edx, %edx
	jmp	.LBB13_46
	leaq	(,%rcx,8), %r10
	xorl	%r11d, %r11d
	cmpq	$512, 8(%rdx,%r11,2)
	sete	%al
	jne	.LBB13_11
	movq	(%rdx,%r11,2), %rbx
	movq	%rbx, 56(%rsp,%r11)
	addq	$8, %r11
	cmpq	%r11, %r10
	jne	.LBB13_23
	movq	%rcx, 1080(%rsp)
	leaq	-1(%rcx), %rdx
	movl	%ecx, %r10d
	andl	$3, %r10d
	cmpq	$3, %rdx
	jae	.LBB13_53
	xorl	%edx, %edx
	jmp	.LBB13_56
	leaq	(,%rcx,8), %r10
	xorl	%r11d, %r11d
	cmpq	$128, 8(%rdx,%r11,2)
	sete	%al
	jne	.LBB13_11
	movq	(%rdx,%r11,2), %rbx
	movq	%rbx, 56(%rsp,%r11)
	addq	$8, %r11
	cmpq	%r11, %r10
	jne	.LBB13_28
	movq	%rcx, 1080(%rsp)
	leaq	-1(%rcx), %rdx
	movl	%ecx, %r10d
	andl	$3, %r10d
	cmpq	$3, %rdx
	jae	.LBB13_73
	xorl	%edx, %edx
	jmp	.LBB13_76
	movl	%ecx, %r10d
	andl	$252, %r10d
	leaq	1184(%rsp), %r11
	xorl	%ebx, %ebx
	xorps	%xmm0, %xmm0
	movups	%xmm0, -80(%r11)
	movups	%xmm0, -96(%r11)
	movups	%xmm0, -64(%r11)
	movups	%xmm0, -48(%r11)
	movups	%xmm0, -32(%r11)
	movups	%xmm0, -16(%r11)
	movups	%xmm0, (%r11)
	movups	%xmm0, 16(%r11)
	addq	$4, %rbx
	subq	$-128, %r11
	cmpq	%rbx, %r10
	jne	.LBB13_34
	testq	%rdx, %rdx
	je	.LBB13_39
	movq	%rbx, %r10
	shlq	$5, %r10
	addq	%rsp, %r10
	addq	$1088, %r10
	negq	%rdx
	xorl	%r11d, %r11d
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%r10)
	movups	%xmm0, (%r10)
	decq	%r11
	addq	$32, %r10
	cmpq	%r11, %rdx
	jne	.LBB13_37
	subq	%r11, %rbx
	movq	%rbx, 5184(%rsp)
	cmpb	$5, %sil
	je	.LBB13_83
	movzbl	%sil, %edx
	cmpl	$4, %edx
	jne	.LBB13_99
	cmpq	%rcx, %rbx
	jb	.LBB13_135
	movq	%rdi, %r10
	movl	%eax, %ebp
	movq	%r8, %r14
	movq	%r9, %r15
	leaq	1088(%rsp), %rax
	leaq	56(%rsp), %rdi
	movl	$16, %edx
	movq	%rcx, %rsi
	movq	%r10, %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%rax
	pushq	$10
	pushq	$1
	pushq	%r13
	callq	*blake3_servil_hash_many_avx2@GOTPCREL(%rip)
	jmp	.LBB13_101
	movl	%ecx, %r11d
	andl	$252, %r11d
	leaq	1184(%rsp), %rbx
	xorl	%edx, %edx
	xorps	%xmm0, %xmm0
	movups	%xmm0, -80(%rbx)
	movups	%xmm0, -96(%rbx)
	movups	%xmm0, -64(%rbx)
	movups	%xmm0, -48(%rbx)
	movups	%xmm0, -32(%rbx)
	movups	%xmm0, -16(%rbx)
	movups	%xmm0, (%rbx)
	movups	%xmm0, 16(%rbx)
	addq	$4, %rdx
	subq	$-128, %rbx
	cmpq	%rdx, %r11
	jne	.LBB13_44
	testq	%r10, %r10
	je	.LBB13_49
	movq	%rdx, %r11
	shlq	$5, %r11
	addq	%rsp, %r11
	addq	$1088, %r11
	negq	%r10
	xorl	%ebx, %ebx
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%r11)
	movups	%xmm0, (%r11)
	decq	%rbx
	addq	$32, %r11
	cmpq	%rbx, %r10
	jne	.LBB13_47
	subq	%rbx, %rdx
	movq	%rdx, 5184(%rsp)
	cmpb	$5, %sil
	je	.LBB13_87
	movzbl	%sil, %esi
	cmpl	$4, %esi
	jne	.LBB13_102
	cmpq	%rcx, %rdx
	jb	.LBB13_135
	movq	%rdi, %r10
	movl	%eax, %ebp
	movq	%r8, %r14
	movq	%r9, %r15
	leaq	1088(%rsp), %rax
	leaq	56(%rsp), %rdi
	movl	$4, %edx
	movq	%rcx, %rsi
	movq	%r10, %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%rax
	pushq	$10
	pushq	$1
	pushq	%r13
	callq	*blake3_servil_hash_many_avx2@GOTPCREL(%rip)
	jmp	.LBB13_104
	movl	%ecx, %r11d
	andl	$252, %r11d
	leaq	1184(%rsp), %rbx
	xorl	%edx, %edx
	xorps	%xmm0, %xmm0
	movups	%xmm0, -80(%rbx)
	movups	%xmm0, -96(%rbx)
	movups	%xmm0, -64(%rbx)
	movups	%xmm0, -48(%rbx)
	movups	%xmm0, -32(%rbx)
	movups	%xmm0, -16(%rbx)
	movups	%xmm0, (%rbx)
	movups	%xmm0, 16(%rbx)
	addq	$4, %rdx
	subq	$-128, %rbx
	cmpq	%rdx, %r11
	jne	.LBB13_54
	testq	%r10, %r10
	je	.LBB13_59
	movq	%rdx, %r11
	shlq	$5, %r11
	addq	%rsp, %r11
	addq	$1088, %r11
	negq	%r10
	xorl	%ebx, %ebx
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%r11)
	movups	%xmm0, (%r11)
	decq	%rbx
	addq	$32, %r11
	cmpq	%rbx, %r10
	jne	.LBB13_57
	subq	%rbx, %rdx
	movq	%rdx, 5184(%rsp)
	cmpb	$5, %sil
	je	.LBB13_90
	movzbl	%sil, %esi
	cmpl	$4, %esi
	jne	.LBB13_108
	cmpq	%rcx, %rdx
	jb	.LBB13_135
	movq	%rdi, %r10
	movl	%eax, %ebp
	movq	%r8, %r14
	movq	%r9, %r15
	leaq	1088(%rsp), %rax
	leaq	56(%rsp), %rdi
	movl	$8, %edx
	movq	%rcx, %rsi
	movq	%r10, %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%rax
	pushq	$10
	pushq	$1
	pushq	%r13
	callq	*blake3_servil_hash_many_avx2@GOTPCREL(%rip)
	jmp	.LBB13_110
	movl	%ecx, %r10d
	andl	$252, %r10d
	leaq	1184(%rsp), %r11
	xorl	%ebx, %ebx
	xorps	%xmm0, %xmm0
	movups	%xmm0, -80(%r11)
	movups	%xmm0, -96(%r11)
	movups	%xmm0, -64(%r11)
	movups	%xmm0, -48(%r11)
	movups	%xmm0, -32(%r11)
	movups	%xmm0, -16(%r11)
	movups	%xmm0, (%r11)
	movups	%xmm0, 16(%r11)
	addq	$4, %rbx
	subq	$-128, %r11
	cmpq	%rbx, %r10
	jne	.LBB13_64
	testq	%rdx, %rdx
	je	.LBB13_69
	movq	%rbx, %r10
	shlq	$5, %r10
	addq	%rsp, %r10
	addq	$1088, %r10
	negq	%rdx
	xorl	%r11d, %r11d
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%r10)
	movups	%xmm0, (%r10)
	decq	%r11
	addq	$32, %r10
	cmpq	%r11, %rdx
	jne	.LBB13_67
	subq	%r11, %rbx
	movq	%rbx, 5184(%rsp)
	movq	%r13, %r11
	orq	$11, %r11
	cmpb	$3, %sil
	je	.LBB13_93
	movzbl	%sil, %edx
	cmpl	$4, %edx
	jne	.LBB13_114
	cmpq	%rcx, %rbx
	jb	.LBB13_135
	movq	%rdi, %r10
	movl	%eax, %ebp
	movq	%r8, %r14
	movq	%r9, %r15
	leaq	1088(%rsp), %rax
	movzbl	%r11b, %r11d
	leaq	56(%rsp), %rdi
	movl	$1, %edx
	movq	%rcx, %rsi
	movq	%r10, %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%rax
	pushq	$0
	pushq	$0
	pushq	%r11
	callq	*blake3_servil_hash_many_avx2@GOTPCREL(%rip)
	jmp	.LBB13_95
	movl	%ecx, %r11d
	andl	$252, %r11d
	leaq	1184(%rsp), %rbx
	xorl	%edx, %edx
	xorps	%xmm0, %xmm0
	movups	%xmm0, -80(%rbx)
	movups	%xmm0, -96(%rbx)
	movups	%xmm0, -64(%rbx)
	movups	%xmm0, -48(%rbx)
	movups	%xmm0, -32(%rbx)
	movups	%xmm0, -16(%rbx)
	movups	%xmm0, (%rbx)
	movups	%xmm0, 16(%rbx)
	addq	$4, %rdx
	subq	$-128, %rbx
	cmpq	%rdx, %r11
	jne	.LBB13_74
	testq	%r10, %r10
	je	.LBB13_79
	movq	%rdx, %r11
	shlq	$5, %r11
	addq	%rsp, %r11
	addq	$1088, %r11
	negq	%r10
	xorl	%ebx, %ebx
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%r11)
	movups	%xmm0, (%r11)
	decq	%rbx
	addq	$32, %r11
	cmpq	%rbx, %r10
	jne	.LBB13_77
	subq	%rbx, %rdx
	movq	%rdx, 5184(%rsp)
	cmpb	$5, %sil
	je	.LBB13_96
	movzbl	%sil, %esi
	cmpl	$4, %esi
	jne	.LBB13_129
	cmpq	%rcx, %rdx
	jb	.LBB13_135
	movq	%rdi, %r10
	movl	%eax, %ebp
	movq	%r8, %r14
	movq	%r9, %r15
	leaq	1088(%rsp), %rax
	leaq	56(%rsp), %rdi
	movl	$2, %edx
	movq	%rcx, %rsi
	movq	%r10, %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%rax
	pushq	$10
	pushq	$1
	pushq	%r13
	callq	*blake3_servil_hash_many_avx2@GOTPCREL(%rip)
	jmp	.LBB13_131
	cmpq	%rcx, %rbx
	jb	.LBB13_136
	movq	_RNvNvNtCsd7xTwLwyJsN_18blake3_servil_core8platform12x86_features8FEATURES@GOTPCREL(%rip), %r14
	movzbl	(%r14), %edx
	testb	%dl, %dl
	je	.LBB13_138
	testb	$16, %dl
	jne	.LBB13_139
	movq	%rdi, %r14
	xorl	%edx, %edx
	jmp	.LBB13_143
	cmpq	%rcx, %rdx
	jb	.LBB13_136
	movq	%rdi, %rbx
	movl	%eax, %ebp
	movq	%r8, %r14
	movq	%r9, %r15
	movq	_RNvNvNtCsd7xTwLwyJsN_18blake3_servil_core8platform12x86_features8FEATURES@GOTPCREL(%rip), %r12
	movzbl	(%r12), %eax
	testb	%al, %al
	je	.LBB13_151
	leaq	1088(%rsp), %rax
	leaq	56(%rsp), %rdi
	movl	$4, %edx
	movq	%rcx, %rsi
	movq	%rbx, %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%rax
	pushq	$10
	pushq	$1
	pushq	%r13
	callq	*blake3_servil_hash_many_avx512@GOTPCREL(%rip)
	jmp	.LBB13_104
	cmpq	%rcx, %rdx
	jb	.LBB13_136
	movq	%rdi, %rbx
	movl	%eax, %ebp
	movq	%r8, %r14
	movq	%r9, %r15
	movq	_RNvNvNtCsd7xTwLwyJsN_18blake3_servil_core8platform12x86_features8FEATURES@GOTPCREL(%rip), %r12
	movzbl	(%r12), %eax
	testb	%al, %al
	je	.LBB13_152
	leaq	1088(%rsp), %rax
	leaq	56(%rsp), %rdi
	movl	$8, %edx
	movq	%rcx, %rsi
	movq	%rbx, %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%rax
	pushq	$10
	pushq	$1
	pushq	%r13
	callq	*blake3_servil_hash_many_avx512@GOTPCREL(%rip)
	jmp	.LBB13_110
	cmpq	%rcx, %rbx
	jb	.LBB13_137
	movq	%rdi, %r10
	movl	%eax, %ebp
	movq	%r8, %r14
	movq	%r9, %r15
	leaq	1088(%rsp), %rax
	movzbl	%r11b, %r11d
	leaq	56(%rsp), %rdi
	movl	$1, %edx
	movq	%rcx, %rsi
	movq	%r10, %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%rax
	pushq	$0
	pushq	$0
	pushq	%r11
	callq	*blake3_servil_hash_many_sse41@GOTPCREL(%rip)
	addq	$32, %rsp
	movq	%r15, %r9
	movq	%r14, %r8
	jmp	.LBB13_124
	cmpq	%rcx, %rdx
	jb	.LBB13_136
	movq	%rdi, %rbx
	movl	%eax, %ebp
	movq	%r8, %r14
	movq	%r9, %r15
	movq	_RNvNvNtCsd7xTwLwyJsN_18blake3_servil_core8platform12x86_features8FEATURES@GOTPCREL(%rip), %r12
	movzbl	(%r12), %eax
	testb	%al, %al
	je	.LBB13_153
	leaq	1088(%rsp), %rax
	leaq	56(%rsp), %rdi
	movl	$2, %edx
	movq	%rcx, %rsi
	movq	%rbx, %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%rax
	pushq	$10
	pushq	$1
	pushq	%r13
	callq	*blake3_servil_hash_many_avx512@GOTPCREL(%rip)
	jmp	.LBB13_131
	cmpq	%rcx, %rbx
	jb	.LBB13_137
	movq	%rdi, %r10
	movl	%eax, %ebp
	movq	%r8, %r14
	movq	%r9, %r15
	leaq	1088(%rsp), %rax
	leaq	56(%rsp), %rdi
	movl	$16, %edx
	movq	%rcx, %rsi
	movq	%r10, %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%rax
	pushq	$10
	pushq	$1
	pushq	%r13
	callq	*blake3_servil_hash_many_sse41@GOTPCREL(%rip)
	addq	$32, %rsp
	movq	%r15, %r9
	movq	%r14, %r8
	jmp	.LBB13_145
	cmpq	%rcx, %rdx
	jb	.LBB13_137
	movq	%rdi, %r10
	movl	%eax, %ebp
	movq	%r8, %r14
	movq	%r9, %r15
	leaq	1088(%rsp), %rax
	leaq	56(%rsp), %rdi
	movl	$4, %edx
	movq	%rcx, %rsi
	movq	%r10, %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%rax
	pushq	$10
	pushq	$1
	pushq	%r13
	callq	*blake3_servil_hash_many_sse41@GOTPCREL(%rip)
	addq	$32, %rsp
	movq	5184(%rsp), %rcx
	testq	%rcx, %rcx
	movl	%ebp, %eax
	je	.LBB13_11
	movq	%r15, %rdi
	shlq	$5, %rcx
	movq	%r15, %rdx
	shlq	$5, %rdx
	addq	$32, %rdx
	xorl	%esi, %esi
	leaq	32(%rsi), %r8
	cmpq	%r8, %rdx
	je	.LBB13_155
	leaq	(%rsp,%rsi), %r9
	addq	$1088, %r9
	movups	(%r9), %xmm0
	movups	16(%r9), %xmm1
	movups	%xmm1, 16(%r14,%rsi)
	movups	%xmm0, (%r14,%rsi)
	movq	%r8, %rsi
	cmpq	%r8, %rcx
	jne	.LBB13_106
	jmp	.LBB13_11
	cmpq	%rcx, %rdx
	jb	.LBB13_137
	movq	%rdi, %r10
	movl	%eax, %ebp
	movq	%r8, %r14
	movq	%r9, %r15
	leaq	1088(%rsp), %rax
	leaq	56(%rsp), %rdi
	movl	$8, %edx
	movq	%rcx, %rsi
	movq	%r10, %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%rax
	pushq	$10
	pushq	$1
	pushq	%r13
	callq	*blake3_servil_hash_many_sse41@GOTPCREL(%rip)
	addq	$32, %rsp
	movq	5184(%rsp), %rcx
	testq	%rcx, %rcx
	movl	%ebp, %eax
	je	.LBB13_11
	movq	%r15, %rdi
	shlq	$5, %rcx
	movq	%r15, %rdx
	shlq	$5, %rdx
	addq	$32, %rdx
	xorl	%esi, %esi
	leaq	32(%rsi), %r8
	cmpq	%r8, %rdx
	je	.LBB13_155
	leaq	(%rsp,%rsi), %r9
	addq	$1088, %r9
	movups	(%r9), %xmm0
	movups	16(%r9), %xmm1
	movups	%xmm1, 16(%r14,%rsi)
	movups	%xmm0, (%r14,%rsi)
	movq	%r8, %rsi
	cmpq	%r8, %rcx
	jne	.LBB13_112
	jmp	.LBB13_11
	cmpq	%rcx, %rbx
	jb	.LBB13_136
	movq	_RNvNvNtCsd7xTwLwyJsN_18blake3_servil_core8platform12x86_features8FEATURES@GOTPCREL(%rip), %r14
	movzbl	(%r14), %edx
	testb	%dl, %dl
	movq	%r11, 16(%rsp)
	je	.LBB13_154
	xorl	%esi, %esi
	movq	%rdi, %r14
	testb	$4, %r13b
	je	.LBB13_122
	andb	$16, %dl
	je	.LBB13_122
	movl	%eax, 4(%rsp)
	movq	%r8, 40(%rsp)
	movq	%r9, 32(%rsp)
	movl	%ecx, %eax
	andl	$240, %eax
	movq	%rax, 8(%rsp)
	movq	%rcx, 24(%rsp)
	movq	%rcx, %rax
	shrq	$4, %rax
	movq	%rbx, %rbp
	shrq	$4, %rbp
	cmpq	%rax, %rbp
	cmovaeq	%rax, %rbp
	testq	%rbp, %rbp
	je	.LBB13_121
	movq	16(%rsp), %r15
	orq	$1073741824, %r15
	leaq	1088(%rsp), %r12
	leaq	56(%rsp), %r13
	movl	$1, %esi
	movq	%r13, %rdi
	movq	%r14, %rdx
	xorl	%ecx, %ecx
	movq	%r15, %r8
	movq	%r12, %r9
	callq	*blake3_servil_avx512_p16@GOTPCREL(%rip)
	addq	$512, %r12
	subq	$-128, %r13
	decq	%rbp
	jne	.LBB13_120
	movq	24(%rsp), %rcx
	movq	8(%rsp), %rsi
	cmpq	%rcx, %rsi
	movq	32(%rsp), %r9
	movq	40(%rsp), %r8
	movl	4(%rsp), %eax
	je	.LBB13_125
	shlq	$5, %rbx
	movl	%esi, %edi
	shll	$5, %edi
	cmpq	%rbx, %rdi
	ja	.LBB13_150
	movl	%eax, %ebp
	movq	%r8, %r15
	movq	%r9, %r12
	leaq	(%rsp,%rsi,8), %rax
	addq	$56, %rax
	subq	%rsi, %rcx
	leaq	(%rsp,%rdi), %r10
	addq	$1088, %r10
	movzbl	16(%rsp), %r11d
	movl	$1, %edx
	movq	%rax, %rdi
	movq	%rcx, %rsi
	movq	%r14, %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%r10
	pushq	$0
	pushq	$0
	pushq	%r11
	callq	*blake3_servil_hash_many_avx512@GOTPCREL(%rip)
	addq	$32, %rsp
	movq	%r12, %r9
	movq	%r15, %r8
	movl	%ebp, %eax
	movq	5184(%rsp), %rcx
	testq	%rcx, %rcx
	je	.LBB13_11
	shlq	$5, %rcx
	movq	%r9, %rdx
	shlq	$5, %rdx
	addq	$32, %rdx
	xorl	%esi, %esi
	leaq	32(%rsi), %rdi
	cmpq	%rdi, %rdx
	je	.LBB13_156
	leaq	(%rsp,%rsi), %r10
	addq	$1088, %r10
	movups	(%r10), %xmm0
	movups	16(%r10), %xmm1
	movups	%xmm1, 16(%r8,%rsi)
	movups	%xmm0, (%r8,%rsi)
	movq	%rdi, %rsi
	cmpq	%rdi, %rcx
	jne	.LBB13_127
	jmp	.LBB13_11
	cmpq	%rcx, %rdx
	jb	.LBB13_137
	movq	%rdi, %r10
	movl	%eax, %ebp
	movq	%r8, %r14
	movq	%r9, %r15
	leaq	1088(%rsp), %rax
	leaq	56(%rsp), %rdi
	movl	$2, %edx
	movq	%rcx, %rsi
	movq	%r10, %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%rax
	pushq	$10
	pushq	$1
	pushq	%r13
	callq	*blake3_servil_hash_many_sse41@GOTPCREL(%rip)
	addq	$32, %rsp
	movq	5184(%rsp), %rcx
	testq	%rcx, %rcx
	movl	%ebp, %eax
	je	.LBB13_11
	movq	%r15, %rdi
	shlq	$5, %rcx
	movq	%r15, %rdx
	shlq	$5, %rdx
	addq	$32, %rdx
	xorl	%esi, %esi
	leaq	32(%rsi), %r8
	cmpq	%r8, %rdx
	je	.LBB13_155
	leaq	(%rsp,%rsi), %r9
	addq	$1088, %r9
	movups	(%r9), %xmm0
	movups	16(%r9), %xmm1
	movups	%xmm1, 16(%r14,%rsi)
	movups	%xmm0, (%r14,%rsi)
	movq	%r8, %rsi
	cmpq	%r8, %rcx
	jne	.LBB13_133
	jmp	.LBB13_11
	leaq	.Lanon.69ef12a1b09752e6607c64e28a8a726f.2(%rip), %rdi
	leaq	.Lanon.69ef12a1b09752e6607c64e28a8a726f.4(%rip), %rdx
	movl	$53, %esi
	callq	*_RNvNtCsgxBkk5gSRhY_4core9panicking5panic@GOTPCREL(%rip)
	leaq	.Lanon.69ef12a1b09752e6607c64e28a8a726f.2(%rip), %rdi
	leaq	.Lanon.69ef12a1b09752e6607c64e28a8a726f.8(%rip), %rdx
	movl	$53, %esi
	callq	*_RNvNtCsgxBkk5gSRhY_4core9panicking5panic@GOTPCREL(%rip)
	leaq	.Lanon.69ef12a1b09752e6607c64e28a8a726f.2(%rip), %rdi
	leaq	.Lanon.69ef12a1b09752e6607c64e28a8a726f.6(%rip), %rdx
	movl	$53, %esi
	callq	*_RNvNtCsgxBkk5gSRhY_4core9panicking5panic@GOTPCREL(%rip)
	movq	%r9, %r15
	movq	%r13, 8(%rsp)
	movq	%r8, %r13
	movl	%eax, 4(%rsp)
	movq	%rdi, %rbp
	movq	%rcx, %r12
	callq	*_RNvNtCsd7xTwLwyJsN_18blake3_servil_core8platform17read_x86_features@GOTPCREL(%rip)
	movq	%r12, %rcx
	movq	%rbp, %rdi
	movq	%r13, %r8
	movq	8(%rsp), %r13
	movq	%r15, %r9
	movl	%eax, %edx
	movl	4(%rsp), %eax
	movb	%dl, (%r14)
	testb	$16, %dl
	je	.LBB13_86
	movq	%r13, 8(%rsp)
	movq	%rdi, %r14
	movl	%eax, 4(%rsp)
	movq	%r8, 40(%rsp)
	movq	%r9, 32(%rsp)
	movl	%ecx, %eax
	andl	$224, %eax
	movq	%rax, 48(%rsp)
	movq	%rcx, 24(%rsp)
	movq	%rcx, %rax
	shrq	$5, %rax
	movq	%rbx, %rbp
	shrq	$5, %rbp
	cmpq	%rax, %rbp
	cmovaeq	%rax, %rbp
	testq	%rbp, %rbp
	je	.LBB13_142
	movq	8(%rsp), %rax
	addq	$1074397440, %rax
	movq	%rax, 16(%rsp)
	leaq	1088(%rsp), %r12
	leaq	56(%rsp), %r13
	movq	blake3_servil_avx512_p32@GOTPCREL(%rip), %r15
	movl	$16, %esi
	movq	%r13, %rdi
	movq	%r14, %rdx
	xorl	%ecx, %ecx
	movq	16(%rsp), %r8
	movq	%r12, %r9
	callq	*%r15
	addq	$1024, %r12
	addq	$256, %r13
	decq	%rbp
	jne	.LBB13_141
	movq	24(%rsp), %rcx
	movq	48(%rsp), %rdx
	cmpq	%rcx, %rdx
	movq	32(%rsp), %r9
	movq	40(%rsp), %r8
	movl	4(%rsp), %eax
	movq	8(%rsp), %r13
	je	.LBB13_146
	shlq	$5, %rbx
	movl	%edx, %edi
	shll	$5, %edi
	cmpq	%rbx, %rdi
	ja	.LBB13_150
	movl	%eax, %ebp
	movq	%r8, %r15
	movq	%r9, %r12
	leaq	(%rsp,%rdx,8), %rax
	addq	$56, %rax
	subq	%rdx, %rcx
	leaq	(%rsp,%rdi), %r10
	addq	$1088, %r10
	movl	$16, %edx
	movq	%rax, %rdi
	movq	%rcx, %rsi
	movq	%r14, %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%r10
	pushq	$10
	pushq	$1
	pushq	%r13
	callq	*blake3_servil_hash_many_avx512@GOTPCREL(%rip)
	addq	$32, %rsp
	movq	%r12, %r9
	movq	%r15, %r8
	movl	%ebp, %eax
	movq	5184(%rsp), %rcx
	testq	%rcx, %rcx
	je	.LBB13_11
	shlq	$5, %rcx
	movq	%r9, %rdx
	shlq	$5, %rdx
	addq	$32, %rdx
	xorl	%esi, %esi
	leaq	32(%rsi), %rdi
	cmpq	%rdi, %rdx
	je	.LBB13_156
	leaq	(%rsp,%rsi), %r10
	addq	$1088, %r10
	movups	(%r10), %xmm0
	movups	16(%r10), %xmm1
	movups	%xmm1, 16(%r8,%rsi)
	movups	%xmm0, (%r8,%rsi)
	movq	%rdi, %rsi
	cmpq	%rdi, %rcx
	jne	.LBB13_148
	jmp	.LBB13_11
	leaq	.Lanon.69ef12a1b09752e6607c64e28a8a726f.9(%rip), %rcx
	movq	%rbx, %rsi
	movq	%rbx, %rdx
	callq	*_RNvNtNtCsgxBkk5gSRhY_4core5slice5index16slice_index_fail@GOTPCREL(%rip)
	movq	%r13, 8(%rsp)
	movq	%rcx, %r13
	callq	*_RNvNtCsd7xTwLwyJsN_18blake3_servil_core8platform17read_x86_features@GOTPCREL(%rip)
	movq	%r13, %rcx
	movq	8(%rsp), %r13
	movb	%al, (%r12)
	jmp	.LBB13_89
	movq	%r13, 8(%rsp)
	movq	%rcx, %r13
	callq	*_RNvNtCsd7xTwLwyJsN_18blake3_servil_core8platform17read_x86_features@GOTPCREL(%rip)
	movq	%r13, %rcx
	movq	8(%rsp), %r13
	movb	%al, (%r12)
	jmp	.LBB13_92
	movq	%r13, 8(%rsp)
	movq	%rcx, %r13
	callq	*_RNvNtCsd7xTwLwyJsN_18blake3_servil_core8platform17read_x86_features@GOTPCREL(%rip)
	movq	%r13, %rcx
	movq	8(%rsp), %r13
	movb	%al, (%r12)
	jmp	.LBB13_98
	movq	%r9, %r15
	movq	%r13, 8(%rsp)
	movq	%r8, %r13
	movl	%eax, 4(%rsp)
	movq	%rdi, %rbp
	movq	%rcx, %r12
	callq	*_RNvNtCsd7xTwLwyJsN_18blake3_servil_core8platform17read_x86_features@GOTPCREL(%rip)
	movq	%r12, %rcx
	movq	%rbp, %rdi
	movq	%r13, %r8
	movq	8(%rsp), %r13
	movq	%r15, %r9
	movl	%eax, %edx
	movl	4(%rsp), %eax
	movb	%dl, (%r14)
	xorl	%esi, %esi
	movq	%rdi, %r14
	testb	$4, %r13b
	jne	.LBB13_117
	jmp	.LBB13_122
	leaq	.Lanon.69ef12a1b09752e6607c64e28a8a726f.18(%rip), %rdx
	movq	%rdi, %rsi
	callq	*_RNvNtCsgxBkk5gSRhY_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
	leaq	.Lanon.69ef12a1b09752e6607c64e28a8a726f.18(%rip), %rdx
	movq	%r9, %rdi
	movq	%r9, %rsi
	callq	*_RNvNtCsgxBkk5gSRhY_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
