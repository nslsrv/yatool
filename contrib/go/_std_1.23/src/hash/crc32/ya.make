GO_LIBRARY()
IF (OS_DARWIN AND ARCH_ARM64 AND RACE AND CGO_ENABLED OR OS_DARWIN AND ARCH_ARM64 AND RACE AND NOT CGO_ENABLED OR OS_DARWIN AND ARCH_ARM64 AND NOT RACE AND CGO_ENABLED OR OS_DARWIN AND ARCH_ARM64 AND NOT RACE AND NOT CGO_ENABLED OR OS_LINUX AND ARCH_AARCH64 AND RACE AND CGO_ENABLED OR OS_LINUX AND ARCH_AARCH64 AND RACE AND NOT CGO_ENABLED OR OS_LINUX AND ARCH_AARCH64 AND NOT RACE AND CGO_ENABLED OR OS_LINUX AND ARCH_AARCH64 AND NOT RACE AND NOT CGO_ENABLED)
    SRCS(
        crc32.go
        crc32_arm64.go
        crc32_arm64.s
        crc32_generic.go
        gen.go
    )
ELSEIF (OS_DARWIN AND ARCH_X86_64 AND RACE AND CGO_ENABLED OR OS_DARWIN AND ARCH_X86_64 AND RACE AND NOT CGO_ENABLED OR OS_DARWIN AND ARCH_X86_64 AND NOT RACE AND CGO_ENABLED OR OS_DARWIN AND ARCH_X86_64 AND NOT RACE AND NOT CGO_ENABLED OR OS_LINUX AND ARCH_X86_64 AND RACE AND CGO_ENABLED OR OS_LINUX AND ARCH_X86_64 AND RACE AND NOT CGO_ENABLED OR OS_LINUX AND ARCH_X86_64 AND NOT RACE AND CGO_ENABLED OR OS_LINUX AND ARCH_X86_64 AND NOT RACE AND NOT CGO_ENABLED OR OS_WINDOWS AND ARCH_X86_64 AND RACE AND CGO_ENABLED OR OS_WINDOWS AND ARCH_X86_64 AND RACE AND NOT CGO_ENABLED OR OS_WINDOWS AND ARCH_X86_64 AND NOT RACE AND CGO_ENABLED OR OS_WINDOWS AND ARCH_X86_64 AND NOT RACE AND NOT CGO_ENABLED)
    SRCS(
        crc32.go
        crc32_amd64.go
        crc32_amd64.s
        crc32_generic.go
        gen.go
    )
ENDIF()
END()
