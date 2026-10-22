.intel_syntax noprefix
        vpaddd ymm0, ymm0, ymmword ptr [rsp]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+64]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+128]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+192]
        vpaddd ymm0, ymm0, ymm4
        vpaddd ymm1, ymm1, ymm5
        vpaddd ymm2, ymm2, ymm6
        vpaddd ymm3, ymm3, ymm7
        vpxor ymm12, ymm12, ymm0
        vpxor ymm13, ymm13, ymm1
        vpxor ymm14, ymm14, ymm2
        vpxor ymm15, ymm15, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+448]
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpshufb ymm15, ymm15, ymm8
        vpaddd ymm8, ymm12, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm13
        vpaddd ymm10, ymm10, ymm14
        vpaddd ymm11, ymm11, ymm15
        vpxor ymm4, ymm4, ymm8
        vpxor ymm5, ymm5, ymm9
        vpxor ymm6, ymm6, ymm10
        vpxor ymm7, ymm7, ymm11
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm4, 12
        vpslld ymm4, ymm4, 20
        vpor ymm4, ymm4, ymm8
        vpsrld ymm8, ymm5, 12
        vpslld ymm5, ymm5, 20
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 12
        vpslld ymm6, ymm6, 20
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 12
        vpslld ymm7, ymm7, 20
        vpor ymm7, ymm7, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+32]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+96]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+160]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+224]
        vpaddd ymm0, ymm0, ymm4
        vpaddd ymm1, ymm1, ymm5
        vpaddd ymm2, ymm2, ymm6
        vpaddd ymm3, ymm3, ymm7
        vpxor ymm12, ymm12, ymm0
        vpxor ymm13, ymm13, ymm1
        vpxor ymm14, ymm14, ymm2
        vpxor ymm15, ymm15, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+480]
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpshufb ymm15, ymm15, ymm8
        vpaddd ymm8, ymm12, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm13
        vpaddd ymm10, ymm10, ymm14
        vpaddd ymm11, ymm11, ymm15
        vpxor ymm4, ymm4, ymm8
        vpxor ymm5, ymm5, ymm9
        vpxor ymm6, ymm6, ymm10
        vpxor ymm7, ymm7, ymm11
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm4, 7
        vpslld ymm4, ymm4, 25
        vpor ymm4, ymm4, ymm8
        vpsrld ymm8, ymm5, 7
        vpslld ymm5, ymm5, 25
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 7
        vpslld ymm6, ymm6, 25
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 7
        vpslld ymm7, ymm7, 25
        vpor ymm7, ymm7, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+256]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+320]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+384]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+448]
        vpaddd ymm0, ymm0, ymm5
        vpaddd ymm1, ymm1, ymm6
        vpaddd ymm2, ymm2, ymm7
        vpaddd ymm3, ymm3, ymm4
        vpxor ymm15, ymm15, ymm0
        vpxor ymm12, ymm12, ymm1
        vpxor ymm13, ymm13, ymm2
        vpxor ymm14, ymm14, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+448]
        vpshufb ymm15, ymm15, ymm8
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpaddd ymm10, ymm10, ymm15
        vpaddd ymm11, ymm11, ymm12
        vpaddd ymm8, ymm13, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm14
        vpxor ymm5, ymm5, ymm10
        vpxor ymm6, ymm6, ymm11
        vpxor ymm7, ymm7, ymm8
        vpxor ymm4, ymm4, ymm9
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm5, 12
        vpslld ymm5, ymm5, 20
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 12
        vpslld ymm6, ymm6, 20
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 12
        vpslld ymm7, ymm7, 20
        vpor ymm7, ymm7, ymm8
        vpsrld ymm8, ymm4, 12
        vpslld ymm4, ymm4, 20
        vpor ymm4, ymm4, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+288]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+352]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+416]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+480]
        vpaddd ymm0, ymm0, ymm5
        vpaddd ymm1, ymm1, ymm6
        vpaddd ymm2, ymm2, ymm7
        vpaddd ymm3, ymm3, ymm4
        vpxor ymm15, ymm15, ymm0
        vpxor ymm12, ymm12, ymm1
        vpxor ymm13, ymm13, ymm2
        vpxor ymm14, ymm14, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+480]
        vpshufb ymm15, ymm15, ymm8
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpaddd ymm10, ymm10, ymm15
        vpaddd ymm11, ymm11, ymm12
        vpaddd ymm8, ymm13, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm14
        vpxor ymm5, ymm5, ymm10
        vpxor ymm6, ymm6, ymm11
        vpxor ymm7, ymm7, ymm8
        vpxor ymm4, ymm4, ymm9
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm5, 7
        vpslld ymm5, ymm5, 25
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 7
        vpslld ymm6, ymm6, 25
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 7
        vpslld ymm7, ymm7, 25
        vpor ymm7, ymm7, ymm8
        vpsrld ymm8, ymm4, 7
        vpslld ymm4, ymm4, 25
        vpor ymm4, ymm4, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+64]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+96]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+224]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+128]
        vpaddd ymm0, ymm0, ymm4
        vpaddd ymm1, ymm1, ymm5
        vpaddd ymm2, ymm2, ymm6
        vpaddd ymm3, ymm3, ymm7
        vpxor ymm12, ymm12, ymm0
        vpxor ymm13, ymm13, ymm1
        vpxor ymm14, ymm14, ymm2
        vpxor ymm15, ymm15, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+448]
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpshufb ymm15, ymm15, ymm8
        vpaddd ymm8, ymm12, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm13
        vpaddd ymm10, ymm10, ymm14
        vpaddd ymm11, ymm11, ymm15
        vpxor ymm4, ymm4, ymm8
        vpxor ymm5, ymm5, ymm9
        vpxor ymm6, ymm6, ymm10
        vpxor ymm7, ymm7, ymm11
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm4, 12
        vpslld ymm4, ymm4, 20
        vpor ymm4, ymm4, ymm8
        vpsrld ymm8, ymm5, 12
        vpslld ymm5, ymm5, 20
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 12
        vpslld ymm6, ymm6, 20
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 12
        vpslld ymm7, ymm7, 20
        vpor ymm7, ymm7, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+192]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+320]
        vpaddd ymm2, ymm2, ymmword ptr [rsp]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+416]
        vpaddd ymm0, ymm0, ymm4
        vpaddd ymm1, ymm1, ymm5
        vpaddd ymm2, ymm2, ymm6
        vpaddd ymm3, ymm3, ymm7
        vpxor ymm12, ymm12, ymm0
        vpxor ymm13, ymm13, ymm1
        vpxor ymm14, ymm14, ymm2
        vpxor ymm15, ymm15, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+480]
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpshufb ymm15, ymm15, ymm8
        vpaddd ymm8, ymm12, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm13
        vpaddd ymm10, ymm10, ymm14
        vpaddd ymm11, ymm11, ymm15
        vpxor ymm4, ymm4, ymm8
        vpxor ymm5, ymm5, ymm9
        vpxor ymm6, ymm6, ymm10
        vpxor ymm7, ymm7, ymm11
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm4, 7
        vpslld ymm4, ymm4, 25
        vpor ymm4, ymm4, ymm8
        vpsrld ymm8, ymm5, 7
        vpslld ymm5, ymm5, 25
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 7
        vpslld ymm6, ymm6, 25
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 7
        vpslld ymm7, ymm7, 25
        vpor ymm7, ymm7, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+32]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+384]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+288]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+480]
        vpaddd ymm0, ymm0, ymm5
        vpaddd ymm1, ymm1, ymm6
        vpaddd ymm2, ymm2, ymm7
        vpaddd ymm3, ymm3, ymm4
        vpxor ymm15, ymm15, ymm0
        vpxor ymm12, ymm12, ymm1
        vpxor ymm13, ymm13, ymm2
        vpxor ymm14, ymm14, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+448]
        vpshufb ymm15, ymm15, ymm8
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpaddd ymm10, ymm10, ymm15
        vpaddd ymm11, ymm11, ymm12
        vpaddd ymm8, ymm13, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm14
        vpxor ymm5, ymm5, ymm10
        vpxor ymm6, ymm6, ymm11
        vpxor ymm7, ymm7, ymm8
        vpxor ymm4, ymm4, ymm9
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm5, 12
        vpslld ymm5, ymm5, 20
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 12
        vpslld ymm6, ymm6, 20
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 12
        vpslld ymm7, ymm7, 20
        vpor ymm7, ymm7, ymm8
        vpsrld ymm8, ymm4, 12
        vpslld ymm4, ymm4, 20
        vpor ymm4, ymm4, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+352]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+160]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+448]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+256]
        vpaddd ymm0, ymm0, ymm5
        vpaddd ymm1, ymm1, ymm6
        vpaddd ymm2, ymm2, ymm7
        vpaddd ymm3, ymm3, ymm4
        vpxor ymm15, ymm15, ymm0
        vpxor ymm12, ymm12, ymm1
        vpxor ymm13, ymm13, ymm2
        vpxor ymm14, ymm14, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+480]
        vpshufb ymm15, ymm15, ymm8
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpaddd ymm10, ymm10, ymm15
        vpaddd ymm11, ymm11, ymm12
        vpaddd ymm8, ymm13, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm14
        vpxor ymm5, ymm5, ymm10
        vpxor ymm6, ymm6, ymm11
        vpxor ymm7, ymm7, ymm8
        vpxor ymm4, ymm4, ymm9
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm5, 7
        vpslld ymm5, ymm5, 25
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 7
        vpslld ymm6, ymm6, 25
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 7
        vpslld ymm7, ymm7, 25
        vpor ymm7, ymm7, ymm8
        vpsrld ymm8, ymm4, 7
        vpslld ymm4, ymm4, 25
        vpor ymm4, ymm4, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+96]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+320]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+416]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+224]
        vpaddd ymm0, ymm0, ymm4
        vpaddd ymm1, ymm1, ymm5
        vpaddd ymm2, ymm2, ymm6
        vpaddd ymm3, ymm3, ymm7
        vpxor ymm12, ymm12, ymm0
        vpxor ymm13, ymm13, ymm1
        vpxor ymm14, ymm14, ymm2
        vpxor ymm15, ymm15, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+448]
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpshufb ymm15, ymm15, ymm8
        vpaddd ymm8, ymm12, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm13
        vpaddd ymm10, ymm10, ymm14
        vpaddd ymm11, ymm11, ymm15
        vpxor ymm4, ymm4, ymm8
        vpxor ymm5, ymm5, ymm9
        vpxor ymm6, ymm6, ymm10
        vpxor ymm7, ymm7, ymm11
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm4, 12
        vpslld ymm4, ymm4, 20
        vpor ymm4, ymm4, ymm8
        vpsrld ymm8, ymm5, 12
        vpslld ymm5, ymm5, 20
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 12
        vpslld ymm6, ymm6, 20
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 12
        vpslld ymm7, ymm7, 20
        vpor ymm7, ymm7, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+128]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+384]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+64]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+448]
        vpaddd ymm0, ymm0, ymm4
        vpaddd ymm1, ymm1, ymm5
        vpaddd ymm2, ymm2, ymm6
        vpaddd ymm3, ymm3, ymm7
        vpxor ymm12, ymm12, ymm0
        vpxor ymm13, ymm13, ymm1
        vpxor ymm14, ymm14, ymm2
        vpxor ymm15, ymm15, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+480]
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpshufb ymm15, ymm15, ymm8
        vpaddd ymm8, ymm12, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm13
        vpaddd ymm10, ymm10, ymm14
        vpaddd ymm11, ymm11, ymm15
        vpxor ymm4, ymm4, ymm8
        vpxor ymm5, ymm5, ymm9
        vpxor ymm6, ymm6, ymm10
        vpxor ymm7, ymm7, ymm11
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm4, 7
        vpslld ymm4, ymm4, 25
        vpor ymm4, ymm4, ymm8
        vpsrld ymm8, ymm5, 7
        vpslld ymm5, ymm5, 25
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 7
        vpslld ymm6, ymm6, 25
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 7
        vpslld ymm7, ymm7, 25
        vpor ymm7, ymm7, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+192]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+288]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+352]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+256]
        vpaddd ymm0, ymm0, ymm5
        vpaddd ymm1, ymm1, ymm6
        vpaddd ymm2, ymm2, ymm7
        vpaddd ymm3, ymm3, ymm4
        vpxor ymm15, ymm15, ymm0
        vpxor ymm12, ymm12, ymm1
        vpxor ymm13, ymm13, ymm2
        vpxor ymm14, ymm14, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+448]
        vpshufb ymm15, ymm15, ymm8
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpaddd ymm10, ymm10, ymm15
        vpaddd ymm11, ymm11, ymm12
        vpaddd ymm8, ymm13, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm14
        vpxor ymm5, ymm5, ymm10
        vpxor ymm6, ymm6, ymm11
        vpxor ymm7, ymm7, ymm8
        vpxor ymm4, ymm4, ymm9
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm5, 12
        vpslld ymm5, ymm5, 20
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 12
        vpslld ymm6, ymm6, 20
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 12
        vpslld ymm7, ymm7, 20
        vpor ymm7, ymm7, ymm8
        vpsrld ymm8, ymm4, 12
        vpslld ymm4, ymm4, 20
        vpor ymm4, ymm4, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+160]
        vpaddd ymm1, ymm1, ymmword ptr [rsp]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+480]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+32]
        vpaddd ymm0, ymm0, ymm5
        vpaddd ymm1, ymm1, ymm6
        vpaddd ymm2, ymm2, ymm7
        vpaddd ymm3, ymm3, ymm4
        vpxor ymm15, ymm15, ymm0
        vpxor ymm12, ymm12, ymm1
        vpxor ymm13, ymm13, ymm2
        vpxor ymm14, ymm14, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+480]
        vpshufb ymm15, ymm15, ymm8
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpaddd ymm10, ymm10, ymm15
        vpaddd ymm11, ymm11, ymm12
        vpaddd ymm8, ymm13, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm14
        vpxor ymm5, ymm5, ymm10
        vpxor ymm6, ymm6, ymm11
        vpxor ymm7, ymm7, ymm8
        vpxor ymm4, ymm4, ymm9
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm5, 7
        vpslld ymm5, ymm5, 25
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 7
        vpslld ymm6, ymm6, 25
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 7
        vpslld ymm7, ymm7, 25
        vpor ymm7, ymm7, ymm8
        vpsrld ymm8, ymm4, 7
        vpslld ymm4, ymm4, 25
        vpor ymm4, ymm4, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+320]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+384]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+448]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+416]
        vpaddd ymm0, ymm0, ymm4
        vpaddd ymm1, ymm1, ymm5
        vpaddd ymm2, ymm2, ymm6
        vpaddd ymm3, ymm3, ymm7
        vpxor ymm12, ymm12, ymm0
        vpxor ymm13, ymm13, ymm1
        vpxor ymm14, ymm14, ymm2
        vpxor ymm15, ymm15, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+448]
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpshufb ymm15, ymm15, ymm8
        vpaddd ymm8, ymm12, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm13
        vpaddd ymm10, ymm10, ymm14
        vpaddd ymm11, ymm11, ymm15
        vpxor ymm4, ymm4, ymm8
        vpxor ymm5, ymm5, ymm9
        vpxor ymm6, ymm6, ymm10
        vpxor ymm7, ymm7, ymm11
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm4, 12
        vpslld ymm4, ymm4, 20
        vpor ymm4, ymm4, ymm8
        vpsrld ymm8, ymm5, 12
        vpslld ymm5, ymm5, 20
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 12
        vpslld ymm6, ymm6, 20
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 12
        vpslld ymm7, ymm7, 20
        vpor ymm7, ymm7, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+224]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+288]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+96]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+480]
        vpaddd ymm0, ymm0, ymm4
        vpaddd ymm1, ymm1, ymm5
        vpaddd ymm2, ymm2, ymm6
        vpaddd ymm3, ymm3, ymm7
        vpxor ymm12, ymm12, ymm0
        vpxor ymm13, ymm13, ymm1
        vpxor ymm14, ymm14, ymm2
        vpxor ymm15, ymm15, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+480]
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpshufb ymm15, ymm15, ymm8
        vpaddd ymm8, ymm12, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm13
        vpaddd ymm10, ymm10, ymm14
        vpaddd ymm11, ymm11, ymm15
        vpxor ymm4, ymm4, ymm8
        vpxor ymm5, ymm5, ymm9
        vpxor ymm6, ymm6, ymm10
        vpxor ymm7, ymm7, ymm11
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm4, 7
        vpslld ymm4, ymm4, 25
        vpor ymm4, ymm4, ymm8
        vpsrld ymm8, ymm5, 7
        vpslld ymm5, ymm5, 25
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 7
        vpslld ymm6, ymm6, 25
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 7
        vpslld ymm7, ymm7, 25
        vpor ymm7, ymm7, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+128]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+352]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+160]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+32]
        vpaddd ymm0, ymm0, ymm5
        vpaddd ymm1, ymm1, ymm6
        vpaddd ymm2, ymm2, ymm7
        vpaddd ymm3, ymm3, ymm4
        vpxor ymm15, ymm15, ymm0
        vpxor ymm12, ymm12, ymm1
        vpxor ymm13, ymm13, ymm2
        vpxor ymm14, ymm14, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+448]
        vpshufb ymm15, ymm15, ymm8
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpaddd ymm10, ymm10, ymm15
        vpaddd ymm11, ymm11, ymm12
        vpaddd ymm8, ymm13, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm14
        vpxor ymm5, ymm5, ymm10
        vpxor ymm6, ymm6, ymm11
        vpxor ymm7, ymm7, ymm8
        vpxor ymm4, ymm4, ymm9
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm5, 12
        vpslld ymm5, ymm5, 20
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 12
        vpslld ymm6, ymm6, 20
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 12
        vpslld ymm7, ymm7, 20
        vpor ymm7, ymm7, ymm8
        vpsrld ymm8, ymm4, 12
        vpslld ymm4, ymm4, 20
        vpor ymm4, ymm4, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+64]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+256]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+192]
        vpaddd ymm0, ymm0, ymm5
        vpaddd ymm1, ymm1, ymm6
        vpaddd ymm2, ymm2, ymm7
        vpaddd ymm3, ymm3, ymm4
        vpxor ymm15, ymm15, ymm0
        vpxor ymm12, ymm12, ymm1
        vpxor ymm13, ymm13, ymm2
        vpxor ymm14, ymm14, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+480]
        vpshufb ymm15, ymm15, ymm8
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpaddd ymm10, ymm10, ymm15
        vpaddd ymm11, ymm11, ymm12
        vpaddd ymm8, ymm13, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm14
        vpxor ymm5, ymm5, ymm10
        vpxor ymm6, ymm6, ymm11
        vpxor ymm7, ymm7, ymm8
        vpxor ymm4, ymm4, ymm9
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm5, 7
        vpslld ymm5, ymm5, 25
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 7
        vpslld ymm6, ymm6, 25
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 7
        vpslld ymm7, ymm7, 25
        vpor ymm7, ymm7, ymm8
        vpsrld ymm8, ymm4, 7
        vpslld ymm4, ymm4, 25
        vpor ymm4, ymm4, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+384]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+288]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+480]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+448]
        vpaddd ymm0, ymm0, ymm4
        vpaddd ymm1, ymm1, ymm5
        vpaddd ymm2, ymm2, ymm6
        vpaddd ymm3, ymm3, ymm7
        vpxor ymm12, ymm12, ymm0
        vpxor ymm13, ymm13, ymm1
        vpxor ymm14, ymm14, ymm2
        vpxor ymm15, ymm15, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+448]
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpshufb ymm15, ymm15, ymm8
        vpaddd ymm8, ymm12, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm13
        vpaddd ymm10, ymm10, ymm14
        vpaddd ymm11, ymm11, ymm15
        vpxor ymm4, ymm4, ymm8
        vpxor ymm5, ymm5, ymm9
        vpxor ymm6, ymm6, ymm10
        vpxor ymm7, ymm7, ymm11
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm4, 12
        vpslld ymm4, ymm4, 20
        vpor ymm4, ymm4, ymm8
        vpsrld ymm8, ymm5, 12
        vpslld ymm5, ymm5, 20
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 12
        vpslld ymm6, ymm6, 20
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 12
        vpslld ymm7, ymm7, 20
        vpor ymm7, ymm7, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+416]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+352]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+320]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+256]
        vpaddd ymm0, ymm0, ymm4
        vpaddd ymm1, ymm1, ymm5
        vpaddd ymm2, ymm2, ymm6
        vpaddd ymm3, ymm3, ymm7
        vpxor ymm12, ymm12, ymm0
        vpxor ymm13, ymm13, ymm1
        vpxor ymm14, ymm14, ymm2
        vpxor ymm15, ymm15, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+480]
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpshufb ymm15, ymm15, ymm8
        vpaddd ymm8, ymm12, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm13
        vpaddd ymm10, ymm10, ymm14
        vpaddd ymm11, ymm11, ymm15
        vpxor ymm4, ymm4, ymm8
        vpxor ymm5, ymm5, ymm9
        vpxor ymm6, ymm6, ymm10
        vpxor ymm7, ymm7, ymm11
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm4, 7
        vpslld ymm4, ymm4, 25
        vpor ymm4, ymm4, ymm8
        vpsrld ymm8, ymm5, 7
        vpslld ymm5, ymm5, 25
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 7
        vpslld ymm6, ymm6, 25
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 7
        vpslld ymm7, ymm7, 25
        vpor ymm7, ymm7, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+224]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+160]
        vpaddd ymm2, ymm2, ymmword ptr [rsp]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+192]
        vpaddd ymm0, ymm0, ymm5
        vpaddd ymm1, ymm1, ymm6
        vpaddd ymm2, ymm2, ymm7
        vpaddd ymm3, ymm3, ymm4
        vpxor ymm15, ymm15, ymm0
        vpxor ymm12, ymm12, ymm1
        vpxor ymm13, ymm13, ymm2
        vpxor ymm14, ymm14, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+448]
        vpshufb ymm15, ymm15, ymm8
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpaddd ymm10, ymm10, ymm15
        vpaddd ymm11, ymm11, ymm12
        vpaddd ymm8, ymm13, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm14
        vpxor ymm5, ymm5, ymm10
        vpxor ymm6, ymm6, ymm11
        vpxor ymm7, ymm7, ymm8
        vpxor ymm4, ymm4, ymm9
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm5, 12
        vpslld ymm5, ymm5, 20
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 12
        vpslld ymm6, ymm6, 20
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 12
        vpslld ymm7, ymm7, 20
        vpor ymm7, ymm7, ymm8
        vpsrld ymm8, ymm4, 12
        vpslld ymm4, ymm4, 20
        vpor ymm4, ymm4, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+64]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+96]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+32]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+128]
        vpaddd ymm0, ymm0, ymm5
        vpaddd ymm1, ymm1, ymm6
        vpaddd ymm2, ymm2, ymm7
        vpaddd ymm3, ymm3, ymm4
        vpxor ymm15, ymm15, ymm0
        vpxor ymm12, ymm12, ymm1
        vpxor ymm13, ymm13, ymm2
        vpxor ymm14, ymm14, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+480]
        vpshufb ymm15, ymm15, ymm8
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpaddd ymm10, ymm10, ymm15
        vpaddd ymm11, ymm11, ymm12
        vpaddd ymm8, ymm13, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm14
        vpxor ymm5, ymm5, ymm10
        vpxor ymm6, ymm6, ymm11
        vpxor ymm7, ymm7, ymm8
        vpxor ymm4, ymm4, ymm9
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm5, 7
        vpslld ymm5, ymm5, 25
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 7
        vpslld ymm6, ymm6, 25
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 7
        vpslld ymm7, ymm7, 25
        vpor ymm7, ymm7, ymm8
        vpsrld ymm8, ymm4, 7
        vpslld ymm4, ymm4, 25
        vpor ymm4, ymm4, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+288]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+352]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+256]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+480]
        vpaddd ymm0, ymm0, ymm4
        vpaddd ymm1, ymm1, ymm5
        vpaddd ymm2, ymm2, ymm6
        vpaddd ymm3, ymm3, ymm7
        vpxor ymm12, ymm12, ymm0
        vpxor ymm13, ymm13, ymm1
        vpxor ymm14, ymm14, ymm2
        vpxor ymm15, ymm15, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+448]
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpshufb ymm15, ymm15, ymm8
        vpaddd ymm8, ymm12, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm13
        vpaddd ymm10, ymm10, ymm14
        vpaddd ymm11, ymm11, ymm15
        vpxor ymm4, ymm4, ymm8
        vpxor ymm5, ymm5, ymm9
        vpxor ymm6, ymm6, ymm10
        vpxor ymm7, ymm7, ymm11
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm4, 12
        vpslld ymm4, ymm4, 20
        vpor ymm4, ymm4, ymm8
        vpsrld ymm8, ymm5, 12
        vpslld ymm5, ymm5, 20
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 12
        vpslld ymm6, ymm6, 20
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 12
        vpslld ymm7, ymm7, 20
        vpor ymm7, ymm7, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+448]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+160]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+384]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+32]
        vpaddd ymm0, ymm0, ymm4
        vpaddd ymm1, ymm1, ymm5
        vpaddd ymm2, ymm2, ymm6
        vpaddd ymm3, ymm3, ymm7
        vpxor ymm12, ymm12, ymm0
        vpxor ymm13, ymm13, ymm1
        vpxor ymm14, ymm14, ymm2
        vpxor ymm15, ymm15, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+480]
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpshufb ymm15, ymm15, ymm8
        vpaddd ymm8, ymm12, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm13
        vpaddd ymm10, ymm10, ymm14
        vpaddd ymm11, ymm11, ymm15
        vpxor ymm4, ymm4, ymm8
        vpxor ymm5, ymm5, ymm9
        vpxor ymm6, ymm6, ymm10
        vpxor ymm7, ymm7, ymm11
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm4, 7
        vpslld ymm4, ymm4, 25
        vpor ymm4, ymm4, ymm8
        vpsrld ymm8, ymm5, 7
        vpslld ymm5, ymm5, 25
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 7
        vpslld ymm6, ymm6, 25
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 7
        vpslld ymm7, ymm7, 25
        vpor ymm7, ymm7, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+416]
        vpaddd ymm1, ymm1, ymmword ptr [rsp]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+64]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+128]
        vpaddd ymm0, ymm0, ymm5
        vpaddd ymm1, ymm1, ymm6
        vpaddd ymm2, ymm2, ymm7
        vpaddd ymm3, ymm3, ymm4
        vpxor ymm15, ymm15, ymm0
        vpxor ymm12, ymm12, ymm1
        vpxor ymm13, ymm13, ymm2
        vpxor ymm14, ymm14, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+448]
        vpshufb ymm15, ymm15, ymm8
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpaddd ymm10, ymm10, ymm15
        vpaddd ymm11, ymm11, ymm12
        vpaddd ymm8, ymm13, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm14
        vpxor ymm5, ymm5, ymm10
        vpxor ymm6, ymm6, ymm11
        vpxor ymm7, ymm7, ymm8
        vpxor ymm4, ymm4, ymm9
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm5, 12
        vpslld ymm5, ymm5, 20
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 12
        vpslld ymm6, ymm6, 20
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 12
        vpslld ymm7, ymm7, 20
        vpor ymm7, ymm7, ymm8
        vpsrld ymm8, ymm4, 12
        vpslld ymm4, ymm4, 20
        vpor ymm4, ymm4, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+96]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+320]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+192]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+224]
        vpaddd ymm0, ymm0, ymm5
        vpaddd ymm1, ymm1, ymm6
        vpaddd ymm2, ymm2, ymm7
        vpaddd ymm3, ymm3, ymm4
        vpxor ymm15, ymm15, ymm0
        vpxor ymm12, ymm12, ymm1
        vpxor ymm13, ymm13, ymm2
        vpxor ymm14, ymm14, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+480]
        vpshufb ymm15, ymm15, ymm8
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpaddd ymm10, ymm10, ymm15
        vpaddd ymm11, ymm11, ymm12
        vpaddd ymm8, ymm13, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm14
        vpxor ymm5, ymm5, ymm10
        vpxor ymm6, ymm6, ymm11
        vpxor ymm7, ymm7, ymm8
        vpxor ymm4, ymm4, ymm9
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm5, 7
        vpslld ymm5, ymm5, 25
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 7
        vpslld ymm6, ymm6, 25
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 7
        vpslld ymm7, ymm7, 25
        vpor ymm7, ymm7, ymm8
        vpsrld ymm8, ymm4, 7
        vpslld ymm4, ymm4, 25
        vpor ymm4, ymm4, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+352]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+160]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+32]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+256]
        vpaddd ymm0, ymm0, ymm4
        vpaddd ymm1, ymm1, ymm5
        vpaddd ymm2, ymm2, ymm6
        vpaddd ymm3, ymm3, ymm7
        vpxor ymm12, ymm12, ymm0
        vpxor ymm13, ymm13, ymm1
        vpxor ymm14, ymm14, ymm2
        vpxor ymm15, ymm15, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+448]
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpshufb ymm15, ymm15, ymm8
        vpaddd ymm8, ymm12, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm13
        vpaddd ymm10, ymm10, ymm14
        vpaddd ymm11, ymm11, ymm15
        vpxor ymm4, ymm4, ymm8
        vpxor ymm5, ymm5, ymm9
        vpxor ymm6, ymm6, ymm10
        vpxor ymm7, ymm7, ymm11
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm4, 12
        vpslld ymm4, ymm4, 20
        vpor ymm4, ymm4, ymm8
        vpsrld ymm8, ymm5, 12
        vpslld ymm5, ymm5, 20
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 12
        vpslld ymm6, ymm6, 20
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 12
        vpslld ymm7, ymm7, 20
        vpor ymm7, ymm7, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+480]
        vpaddd ymm1, ymm1, ymmword ptr [rsp]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+288]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+192]
        vpaddd ymm0, ymm0, ymm4
        vpaddd ymm1, ymm1, ymm5
        vpaddd ymm2, ymm2, ymm6
        vpaddd ymm3, ymm3, ymm7
        vpxor ymm12, ymm12, ymm0
        vpxor ymm13, ymm13, ymm1
        vpxor ymm14, ymm14, ymm2
        vpxor ymm15, ymm15, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+480]
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpshufb ymm15, ymm15, ymm8
        vpaddd ymm8, ymm12, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm13
        vpaddd ymm10, ymm10, ymm14
        vpaddd ymm11, ymm11, ymm15
        vpxor ymm4, ymm4, ymm8
        vpxor ymm5, ymm5, ymm9
        vpxor ymm6, ymm6, ymm10
        vpxor ymm7, ymm7, ymm11
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm4, 7
        vpslld ymm4, ymm4, 25
        vpor ymm4, ymm4, ymm8
        vpsrld ymm8, ymm5, 7
        vpslld ymm5, ymm5, 25
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 7
        vpslld ymm6, ymm6, 25
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 7
        vpslld ymm7, ymm7, 25
        vpor ymm7, ymm7, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+448]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+64]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+96]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+224]
        vpaddd ymm0, ymm0, ymm5
        vpaddd ymm1, ymm1, ymm6
        vpaddd ymm2, ymm2, ymm7
        vpaddd ymm3, ymm3, ymm4
        vpxor ymm15, ymm15, ymm0
        vpxor ymm12, ymm12, ymm1
        vpxor ymm13, ymm13, ymm2
        vpxor ymm14, ymm14, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+448]
        vpshufb ymm15, ymm15, ymm8
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpaddd ymm10, ymm10, ymm15
        vpaddd ymm11, ymm11, ymm12
        vpaddd ymm8, ymm13, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm14
        vpxor ymm5, ymm5, ymm10
        vpxor ymm6, ymm6, ymm11
        vpxor ymm7, ymm7, ymm8
        vpxor ymm4, ymm4, ymm9
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm5, 12
        vpslld ymm5, ymm5, 20
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 12
        vpslld ymm6, ymm6, 20
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 12
        vpslld ymm7, ymm7, 20
        vpor ymm7, ymm7, ymm8
        vpsrld ymm8, ymm4, 12
        vpslld ymm4, ymm4, 20
        vpor ymm4, ymm4, ymm8
        vpaddd ymm0, ymm0, ymmword ptr [rsp+320]
        vpaddd ymm1, ymm1, ymmword ptr [rsp+384]
        vpaddd ymm2, ymm2, ymmword ptr [rsp+128]
        vpaddd ymm3, ymm3, ymmword ptr [rsp+416]
        vpaddd ymm0, ymm0, ymm5
        vpaddd ymm1, ymm1, ymm6
        vpaddd ymm2, ymm2, ymm7
        vpaddd ymm3, ymm3, ymm4
        vpxor ymm15, ymm15, ymm0
        vpxor ymm12, ymm12, ymm1
        vpxor ymm13, ymm13, ymm2
        vpxor ymm14, ymm14, ymm3
        vmovdqu ymm8, ymmword ptr [rdi+480]
        vpshufb ymm15, ymm15, ymm8
        vpshufb ymm12, ymm12, ymm8
        vpshufb ymm13, ymm13, ymm8
        vpshufb ymm14, ymm14, ymm8
        vpaddd ymm10, ymm10, ymm15
        vpaddd ymm11, ymm11, ymm12
        vpaddd ymm8, ymm13, ymmword ptr [rsp+512]
        vpaddd ymm9, ymm9, ymm14
        vpxor ymm5, ymm5, ymm10
        vpxor ymm6, ymm6, ymm11
        vpxor ymm7, ymm7, ymm8
        vpxor ymm4, ymm4, ymm9
        vmovdqa ymmword ptr [rsp+512], ymm8
        vpsrld ymm8, ymm5, 7
        vpslld ymm5, ymm5, 25
        vpor ymm5, ymm5, ymm8
        vpsrld ymm8, ymm6, 7
        vpslld ymm6, ymm6, 25
        vpor ymm6, ymm6, ymm8
        vpsrld ymm8, ymm7, 7
        vpslld ymm7, ymm7, 25
        vpor ymm7, ymm7, ymm8
        vpsrld ymm8, ymm4, 7
        vpslld ymm4, ymm4, 25
        vpor ymm4, ymm4, ymm8
