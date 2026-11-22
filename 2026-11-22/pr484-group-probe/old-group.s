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
	ja	.LBB13_34
	movq	8(%rdx), %rax
	leaq	-1(%rax), %r10
	movq	%rax, %r11
	xorq	%r10, %r11
	cmpq	%r10, %r11
	jbe	.LBB13_34
	rep		bsfq	%rax, %rax
	addq	$-6, %rax
	cmpq	$4, %rax
	ja	.LBB13_34
	movzbl	32(%rdi), %r12d
	leaq	.LJTI13_0(%rip), %r10
	movslq	(%r10,%rax,4), %rax
	addq	%r10, %rax
	jmpq	*%rax
	leaq	(,%rcx,8), %rax
	xorl	%r10d, %r10d
	cmpq	$64, 8(%rdx,%r10,2)
	jne	.LBB13_34
	movq	(%rdx,%r10,2), %r11
	movq	%r11, 1096(%rsp,%r10)
	addq	$8, %r10
	cmpq	%r10, %rax
	jne	.LBB13_5
	movq	%rdi, 16(%rsp)
	movq	%r8, 8(%rsp)
	movq	%r9, 40(%rsp)
	leaq	1092(%rsp), %rbx
	leaq	60(%rsp), %rdi
	movl	$1028, %edx
	movl	%esi, %ebp
	movq	%rbx, %rsi
	movq	%rcx, %r14
	callq	*memcpy@GOTPCREL(%rip)
	movl	%r14d, 56(%rsp)
	movq	%r14, %rdx
	shlq	$5, %rdx
	movq	%rbx, %rdi
	xorl	%esi, %esi
	callq	*memset@GOTPCREL(%rip)
	movq	%r14, %rsi
	movl	%esi, 1088(%rsp)
	leaq	64(%rsp), %rdi
	movq	%r12, %rcx
	orq	$11, %rcx
	cmpb	$3, %bpl
	je	.LBB13_43
	movzbl	%bpl, %eax
	cmpl	$4, %eax
	jne	.LBB13_59
	movzbl	%cl, %eax
	movl	$1, %edx
	movq	16(%rsp), %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%rbx
	pushq	$0
	pushq	$0
	pushq	%rax
	callq	*blake3_servil_hash_many_avx2@GOTPCREL(%rip)
	jmp	.LBB13_67
	leaq	(,%rcx,8), %rax
	xorl	%r10d, %r10d
	cmpq	$1024, 8(%rdx,%r10,2)
	jne	.LBB13_34
	movq	(%rdx,%r10,2), %r11
	movq	%r11, 1096(%rsp,%r10)
	addq	$8, %r10
	cmpq	%r10, %rax
	jne	.LBB13_11
	movq	%rdi, 16(%rsp)
	movq	%r8, 8(%rsp)
	movq	%r9, 40(%rsp)
	leaq	1092(%rsp), %rbx
	leaq	60(%rsp), %rdi
	movl	$1028, %edx
	movl	%esi, %ebp
	movq	%rbx, %rsi
	movq	%rcx, %r15
	callq	*memcpy@GOTPCREL(%rip)
	movl	%r15d, 56(%rsp)
	movq	%r15, %rdx
	shlq	$5, %rdx
	movq	%rbx, %rdi
	xorl	%esi, %esi
	callq	*memset@GOTPCREL(%rip)
	movq	%r15, %rsi
	movl	%esi, 1088(%rsp)
	leaq	64(%rsp), %rdi
	cmpb	$5, %bpl
	je	.LBB13_36
	movzbl	%bpl, %eax
	movl	$16, %edx
	cmpl	$4, %eax
	jne	.LBB13_46
	movq	16(%rsp), %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%rbx
	pushq	$10
	pushq	$1
	pushq	%r12
	callq	*blake3_servil_hash_many_avx2@GOTPCREL(%rip)
	jmp	.LBB13_85
	leaq	(,%rcx,8), %rax
	xorl	%r10d, %r10d
	cmpq	$256, 8(%rdx,%r10,2)
	jne	.LBB13_34
	movq	(%rdx,%r10,2), %r11
	movq	%r11, 1096(%rsp,%r10)
	addq	$8, %r10
	cmpq	%r10, %rax
	jne	.LBB13_17
	movq	%rdi, %r14
	movq	%r8, 8(%rsp)
	movq	%r9, %r13
	leaq	1092(%rsp), %rbx
	leaq	60(%rsp), %rdi
	movl	$1028, %edx
	movl	%esi, %ebp
	movq	%rbx, %rsi
	movq	%rcx, %r15
	callq	*memcpy@GOTPCREL(%rip)
	movl	%r15d, 56(%rsp)
	movq	%r15, %rdx
	shlq	$5, %rdx
	movq	%rbx, %rdi
	xorl	%esi, %esi
	callq	*memset@GOTPCREL(%rip)
	movq	%r15, %rsi
	movl	%esi, 1088(%rsp)
	leaq	64(%rsp), %rdi
	cmpb	$5, %bpl
	je	.LBB13_39
	movzbl	%bpl, %eax
	movl	$4, %edx
	movq	%r14, %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	cmpl	$4, %eax
	jne	.LBB13_47
	pushq	%rbx
	pushq	$10
	pushq	$1
	pushq	%r12
	callq	*blake3_servil_hash_many_avx2@GOTPCREL(%rip)
	jmp	.LBB13_48
	leaq	(,%rcx,8), %rax
	xorl	%r10d, %r10d
	cmpq	$512, 8(%rdx,%r10,2)
	jne	.LBB13_34
	movq	(%rdx,%r10,2), %r11
	movq	%r11, 1096(%rsp,%r10)
	addq	$8, %r10
	cmpq	%r10, %rax
	jne	.LBB13_23
	movq	%rdi, %r14
	movq	%r8, 8(%rsp)
	movq	%r9, %r13
	leaq	1092(%rsp), %rbx
	leaq	60(%rsp), %rdi
	movl	$1028, %edx
	movl	%esi, %ebp
	movq	%rbx, %rsi
	movq	%rcx, %r15
	callq	*memcpy@GOTPCREL(%rip)
	movl	%r15d, 56(%rsp)
	movq	%r15, %rdx
	shlq	$5, %rdx
	movq	%rbx, %rdi
	xorl	%esi, %esi
	callq	*memset@GOTPCREL(%rip)
	movq	%r15, %rsi
	movl	%esi, 1088(%rsp)
	leaq	64(%rsp), %rdi
	cmpb	$5, %bpl
	je	.LBB13_41
	movzbl	%bpl, %eax
	movl	$8, %edx
	movq	%r14, %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	cmpl	$4, %eax
	jne	.LBB13_53
	pushq	%rbx
	pushq	$10
	pushq	$1
	pushq	%r12
	callq	*blake3_servil_hash_many_avx2@GOTPCREL(%rip)
	jmp	.LBB13_54
	leaq	(,%rcx,8), %rax
	xorl	%r10d, %r10d
	cmpq	$128, 8(%rdx,%r10,2)
	jne	.LBB13_34
	movq	(%rdx,%r10,2), %r11
	movq	%r11, 1096(%rsp,%r10)
	addq	$8, %r10
	cmpq	%r10, %rax
	jne	.LBB13_29
	movq	%rdi, %r14
	movq	%r8, 8(%rsp)
	movq	%r9, %r13
	leaq	1092(%rsp), %rbx
	leaq	60(%rsp), %rdi
	movl	$1028, %edx
	movl	%esi, %ebp
	movq	%rbx, %rsi
	movq	%rcx, %r15
	callq	*memcpy@GOTPCREL(%rip)
	movl	%r15d, 56(%rsp)
	movq	%r15, %rdx
	shlq	$5, %rdx
	movq	%rbx, %rdi
	xorl	%esi, %esi
	callq	*memset@GOTPCREL(%rip)
	movq	%r15, %rsi
	movl	%esi, 1088(%rsp)
	leaq	64(%rsp), %rdi
	cmpb	$5, %bpl
	je	.LBB13_44
	movzbl	%bpl, %eax
	movl	$2, %edx
	movq	%r14, %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	cmpl	$4, %eax
	jne	.LBB13_73
	pushq	%rbx
	pushq	$10
	pushq	$1
	pushq	%r12
	callq	*blake3_servil_hash_many_avx2@GOTPCREL(%rip)
	jmp	.LBB13_74
	xorl	%eax, %eax
	addq	$5192, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
	movq	_RNvNvNtCs3knUEvnIbmi_18blake3_servil_core8platform12x86_features8FEATURES@GOTPCREL(%rip), %r14
	movzbl	(%r14), %eax
	testb	%al, %al
	je	.LBB13_79
	testb	$16, %al
	jne	.LBB13_80
	xorl	%ecx, %ecx
	jmp	.LBB13_84
	movq	_RNvNvNtCs3knUEvnIbmi_18blake3_servil_core8platform12x86_features8FEATURES@GOTPCREL(%rip), %rbp
	movzbl	(%rbp), %eax
	testb	%al, %al
	je	.LBB13_91
	movl	$4, %edx
	movq	%r14, %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%rbx
	pushq	$10
	pushq	$1
	pushq	%r12
	callq	*blake3_servil_hash_many_avx512@GOTPCREL(%rip)
	jmp	.LBB13_48
	movq	_RNvNvNtCs3knUEvnIbmi_18blake3_servil_core8platform12x86_features8FEATURES@GOTPCREL(%rip), %rbp
	movzbl	(%rbp), %eax
	testb	%al, %al
	je	.LBB13_92
	movl	$8, %edx
	movq	%r14, %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%rbx
	pushq	$10
	pushq	$1
	pushq	%r12
	callq	*blake3_servil_hash_many_avx512@GOTPCREL(%rip)
	jmp	.LBB13_54
	movzbl	%cl, %eax
	movl	$1, %edx
	movq	16(%rsp), %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%rbx
	pushq	$0
	pushq	$0
	pushq	%rax
	callq	*blake3_servil_hash_many_sse41@GOTPCREL(%rip)
	jmp	.LBB13_67
	movq	_RNvNvNtCs3knUEvnIbmi_18blake3_servil_core8platform12x86_features8FEATURES@GOTPCREL(%rip), %rbp
	movzbl	(%rbp), %eax
	testb	%al, %al
	je	.LBB13_93
	movl	$2, %edx
	movq	%r14, %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%rbx
	pushq	$10
	pushq	$1
	pushq	%r12
	callq	*blake3_servil_hash_many_avx512@GOTPCREL(%rip)
	jmp	.LBB13_74
	movq	16(%rsp), %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%rbx
	pushq	$10
	pushq	$1
	pushq	%r12
	callq	*blake3_servil_hash_many_sse41@GOTPCREL(%rip)
	jmp	.LBB13_85
	pushq	%rbx
	pushq	$10
	pushq	$1
	pushq	%r12
	callq	*blake3_servil_hash_many_sse41@GOTPCREL(%rip)
	addq	$32, %rsp
	movl	1088(%rsp), %eax
	testq	%rax, %rax
	movq	8(%rsp), %r12
	je	.LBB13_72
	movq	%r13, %rdi
	shlq	$5, %rax
	movq	%r13, %rcx
	shlq	$5, %rcx
	addq	$32, %rcx
	xorl	%edx, %edx
	leaq	32(%rdx), %rsi
	cmpq	%rsi, %rcx
	je	.LBB13_95
	leaq	(%rbx,%rdx), %r8
	movups	(%r8), %xmm0
	movups	16(%r8), %xmm1
	movups	%xmm1, 16(%r12,%rdx)
	movups	%xmm0, (%r12,%rdx)
	movq	%rsi, %rdx
	cmpq	%rsi, %rax
	jne	.LBB13_50
	jmp	.LBB13_72
	pushq	%rbx
	pushq	$10
	pushq	$1
	pushq	%r12
	callq	*blake3_servil_hash_many_sse41@GOTPCREL(%rip)
	addq	$32, %rsp
	movl	1088(%rsp), %eax
	testq	%rax, %rax
	movq	8(%rsp), %r12
	je	.LBB13_72
	movq	%r13, %rdi
	shlq	$5, %rax
	movq	%r13, %rcx
	shlq	$5, %rcx
	addq	$32, %rcx
	xorl	%edx, %edx
	leaq	32(%rdx), %rsi
	cmpq	%rsi, %rcx
	je	.LBB13_95
	leaq	(%rbx,%rdx), %r8
	movups	(%r8), %xmm0
	movups	16(%r8), %xmm1
	movups	%xmm1, 16(%r12,%rdx)
	movups	%xmm0, (%r12,%rdx)
	movq	%rsi, %rdx
	cmpq	%rsi, %rax
	jne	.LBB13_56
	jmp	.LBB13_72
	movq	_RNvNvNtCs3knUEvnIbmi_18blake3_servil_core8platform12x86_features8FEATURES@GOTPCREL(%rip), %r15
	movzbl	(%r15), %eax
	testb	%al, %al
	je	.LBB13_94
	xorl	%edx, %edx
	testb	$4, %r12b
	je	.LBB13_66
	andb	$16, %al
	je	.LBB13_66
	movq	%rcx, 32(%rsp)
	movl	%esi, %eax
	andl	$240, %eax
	movq	%rax, 24(%rsp)
	movq	%rsi, %r15
	shrq	$4, %r15
	je	.LBB13_65
	movq	32(%rsp), %r12
	orq	$1073741824, %r12
	leaq	64(%rsp), %r13
	movq	%rbx, %rbp
	movl	$1, %esi
	movq	%r13, %rdi
	movq	16(%rsp), %rdx
	xorl	%ecx, %ecx
	movq	%r12, %r8
	movq	%rbp, %r9
	callq	*blake3_servil_avx512_p16@GOTPCREL(%rip)
	addq	$512, %rbp
	subq	$-128, %r13
	decq	%r15
	jne	.LBB13_64
	movq	%r14, %rsi
	movq	24(%rsp), %rdx
	cmpq	%r14, %rdx
	leaq	64(%rsp), %rdi
	movq	32(%rsp), %rcx
	je	.LBB13_68
	movl	%edx, %eax
	shll	$5, %eax
	leaq	(%rdi,%rdx,8), %rdi
	subq	%rdx, %rsi
	addq	%rbx, %rax
	movzbl	%cl, %r10d
	movl	$1, %edx
	movq	16(%rsp), %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%rax
	pushq	$0
	pushq	$0
	pushq	%r10
	callq	*blake3_servil_hash_many_avx512@GOTPCREL(%rip)
	addq	$32, %rsp
	movl	1088(%rsp), %eax
	testq	%rax, %rax
	movq	40(%rsp), %rdi
	movq	8(%rsp), %rcx
	je	.LBB13_72
	shlq	$5, %rax
	movq	%rdi, %rdx
	shlq	$5, %rdx
	addq	$32, %rdx
	xorl	%esi, %esi
	leaq	32(%rsi), %r8
	cmpq	%r8, %rdx
	je	.LBB13_95
	leaq	(%rbx,%rsi), %r9
	movups	(%r9), %xmm0
	movups	16(%r9), %xmm1
	movups	%xmm1, 16(%rcx,%rsi)
	movups	%xmm0, (%rcx,%rsi)
	movq	%r8, %rsi
	cmpq	%r8, %rax
	jne	.LBB13_70
	jmp	.LBB13_72
	pushq	%rbx
	pushq	$10
	pushq	$1
	pushq	%r12
	callq	*blake3_servil_hash_many_sse41@GOTPCREL(%rip)
	addq	$32, %rsp
	movl	1088(%rsp), %eax
	testq	%rax, %rax
	movq	8(%rsp), %r12
	je	.LBB13_72
	movq	%r13, %rdi
	shlq	$5, %rax
	movq	%r13, %rcx
	shlq	$5, %rcx
	addq	$32, %rcx
	xorl	%edx, %edx
	leaq	32(%rdx), %rsi
	cmpq	%rsi, %rcx
	je	.LBB13_95
	leaq	(%rbx,%rdx), %r8
	movups	(%r8), %xmm0
	movups	16(%r8), %xmm1
	movups	%xmm1, 16(%r12,%rdx)
	movups	%xmm0, (%r12,%rdx)
	movq	%rsi, %rdx
	cmpq	%rsi, %rax
	jne	.LBB13_76
	jmp	.LBB13_72
	movq	%rdi, %r13
	callq	*_RNvNtCs3knUEvnIbmi_18blake3_servil_core8platform17read_x86_features@GOTPCREL(%rip)
	movq	%r13, %rdi
	movq	%r15, %rsi
	movb	%al, (%r14)
	testb	$16, %al
	je	.LBB13_38
	movq	%r12, 24(%rsp)
	movl	%esi, %eax
	andl	$224, %eax
	movq	%rax, 48(%rsp)
	movq	%rsi, %r12
	shrq	$5, %r12
	je	.LBB13_83
	movq	24(%rsp), %rax
	addq	$1074397440, %rax
	movq	%rax, 32(%rsp)
	movq	blake3_servil_avx512_p32@GOTPCREL(%rip), %r14
	leaq	64(%rsp), %r13
	movq	%rbx, %rbp
	movl	$16, %esi
	movq	%r13, %rdi
	movq	16(%rsp), %rdx
	xorl	%ecx, %ecx
	movq	32(%rsp), %r8
	movq	%rbp, %r9
	callq	*%r14
	addq	$1024, %rbp
	addq	$256, %r13
	decq	%r12
	jne	.LBB13_82
	movq	%r15, %rsi
	movq	48(%rsp), %rcx
	cmpq	%r15, %rcx
	movq	24(%rsp), %r12
	leaq	64(%rsp), %rdi
	je	.LBB13_86
	movl	%ecx, %eax
	shll	$5, %eax
	leaq	(%rdi,%rcx,8), %rdi
	subq	%rcx, %rsi
	addq	%rbx, %rax
	movl	$16, %edx
	movq	16(%rsp), %rcx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	pushq	%rax
	pushq	$10
	pushq	$1
	pushq	%r12
	callq	*blake3_servil_hash_many_avx512@GOTPCREL(%rip)
	addq	$32, %rsp
	movl	1088(%rsp), %eax
	testq	%rax, %rax
	movq	40(%rsp), %rdi
	movq	8(%rsp), %rcx
	je	.LBB13_72
	shlq	$5, %rax
	movq	%rdi, %rdx
	shlq	$5, %rdx
	addq	$32, %rdx
	xorl	%esi, %esi
	leaq	32(%rsi), %r8
	cmpq	%r8, %rdx
	je	.LBB13_95
	leaq	(%rbx,%rsi), %r9
	movups	(%r9), %xmm0
	movups	16(%r9), %xmm1
	movups	%xmm1, 16(%rcx,%rsi)
	movups	%xmm0, (%rcx,%rsi)
	movq	%r8, %rsi
	cmpq	%r8, %rax
	jne	.LBB13_88
	movb	$1, %al
	jmp	.LBB13_35
	callq	*_RNvNtCs3knUEvnIbmi_18blake3_servil_core8platform17read_x86_features@GOTPCREL(%rip)
	leaq	64(%rsp), %rdi
	movq	%r15, %rsi
	movb	%al, (%rbp)
	jmp	.LBB13_40
	callq	*_RNvNtCs3knUEvnIbmi_18blake3_servil_core8platform17read_x86_features@GOTPCREL(%rip)
	leaq	64(%rsp), %rdi
	movq	%r15, %rsi
	movb	%al, (%rbp)
	jmp	.LBB13_42
	callq	*_RNvNtCs3knUEvnIbmi_18blake3_servil_core8platform17read_x86_features@GOTPCREL(%rip)
	leaq	64(%rsp), %rdi
	movq	%r15, %rsi
	movb	%al, (%rbp)
	jmp	.LBB13_45
	movq	%rdi, %r13
	movq	%rcx, %rbp
	callq	*_RNvNtCs3knUEvnIbmi_18blake3_servil_core8platform17read_x86_features@GOTPCREL(%rip)
	movq	%rbp, %rcx
	movq	%r13, %rdi
	movq	%r14, %rsi
	movb	%al, (%r15)
	xorl	%edx, %edx
	testb	$4, %r12b
	jne	.LBB13_61
	jmp	.LBB13_66
	leaq	.Lanon.f0e56ddb26158901aa185b1b70bdfefd.10(%rip), %rdx
	movq	%rdi, %rsi
	callq	*_RNvNtCsgxBkk5gSRhY_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
