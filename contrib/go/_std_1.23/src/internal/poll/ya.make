GO_LIBRARY()
IF (OS_DARWIN AND ARCH_ARM64 AND RACE AND CGO_ENABLED OR OS_DARWIN AND ARCH_ARM64 AND RACE AND NOT CGO_ENABLED OR OS_DARWIN AND ARCH_ARM64 AND NOT RACE AND CGO_ENABLED OR OS_DARWIN AND ARCH_ARM64 AND NOT RACE AND NOT CGO_ENABLED OR OS_DARWIN AND ARCH_X86_64 AND RACE AND CGO_ENABLED OR OS_DARWIN AND ARCH_X86_64 AND RACE AND NOT CGO_ENABLED OR OS_DARWIN AND ARCH_X86_64 AND NOT RACE AND CGO_ENABLED OR OS_DARWIN AND ARCH_X86_64 AND NOT RACE AND NOT CGO_ENABLED)
    SRCS(
        errno_unix.go
        fd.go
        fd_fsync_darwin.go
        fd_mutex.go
        fd_opendir_darwin.go
        fd_poll_runtime.go
        fd_posix.go
        fd_unix.go
        fd_unixjs.go
        fd_writev_libc.go
        hook_unix.go
        iovec_unix.go
        sendfile.go
        sendfile_bsd.go
        sockopt.go
        sockopt_unix.go
        sockoptip.go
        sys_cloexec.go
        writev.go
    )
ELSEIF (OS_LINUX AND ARCH_AARCH64 AND RACE AND CGO_ENABLED OR OS_LINUX AND ARCH_AARCH64 AND RACE AND NOT CGO_ENABLED OR OS_LINUX AND ARCH_AARCH64 AND NOT RACE AND CGO_ENABLED OR OS_LINUX AND ARCH_AARCH64 AND NOT RACE AND NOT CGO_ENABLED OR OS_LINUX AND ARCH_X86_64 AND RACE AND CGO_ENABLED OR OS_LINUX AND ARCH_X86_64 AND RACE AND NOT CGO_ENABLED OR OS_LINUX AND ARCH_X86_64 AND NOT RACE AND CGO_ENABLED OR OS_LINUX AND ARCH_X86_64 AND NOT RACE AND NOT CGO_ENABLED)
    SRCS(
        copy_file_range_linux.go
        errno_unix.go
        fd.go
        fd_fsync_posix.go
        fd_mutex.go
        fd_poll_runtime.go
        fd_posix.go
        fd_unix.go
        fd_unixjs.go
        fd_writev_unix.go
        hook_cloexec.go
        hook_unix.go
        iovec_unix.go
        sendfile.go
        sendfile_linux.go
        sock_cloexec.go
        sockopt.go
        sockopt_linux.go
        sockopt_unix.go
        sockoptip.go
        splice_linux.go
        writev.go
    )
ELSEIF (OS_WINDOWS AND ARCH_X86_64 AND RACE AND CGO_ENABLED OR OS_WINDOWS AND ARCH_X86_64 AND RACE AND NOT CGO_ENABLED OR OS_WINDOWS AND ARCH_X86_64 AND NOT RACE AND CGO_ENABLED OR OS_WINDOWS AND ARCH_X86_64 AND NOT RACE AND NOT CGO_ENABLED)
    SRCS(
        errno_windows.go
        fd.go
        fd_fsync_windows.go
        fd_mutex.go
        fd_poll_runtime.go
        fd_posix.go
        fd_windows.go
        hook_windows.go
        sendfile.go
        sendfile_windows.go
        sockopt.go
        sockopt_windows.go
        sockoptip.go
    )
ENDIF()
END()
