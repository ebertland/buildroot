#!/bin/bash -p

SYNCCMD="rsync -avz --delete"
# BUILD_HOST=server3.cerebras.aws
BUILD_HOST=${BUILD_HOST:-builder}

LOCAL_BR_TOOLCHAIN_DIR=output/host/opt/ext-toolchain
LOCAL_BR_SYSROOT_DIR=output/host/usr/aarch64-buildroot-linux-gnu/sysroot

REMOTE_BUILD_HOST_HOME=/cb/platform/buildtools/x86_64-tools/aarch64
LINARO_VER=

fail() { echo $* >&2; exit 1; }
warn() { echo $* >&2; return 1; }

find_linaro_ver()
{
    # gcc-linaro-6.4.1-2017.08-linux-manifest.txt
    local manifest=$(ls $LOCAL_BR_TOOLCHAIN_DIR/gcc-*-linux-manifest.txt 2>/dev/null)

    [ -z "$mainfest" ] || fail "linaro toolchain mainfest file doesn't exists"

    LINARO_VER=$(echo $manifest | sed 's/^.*gcc-\(.*\)-linux-manifest.txt$/\1/')
    [ -z "$LINARO_VER" ] && \
        fail "failed to extract linaro version from $manifest"

    echo "*** Linaro Version: $LINARO_VER ***"
}

sync_with_remote()
{
    find_linaro_ver || fail

    REMOTE_BUILD_HOST_TOOLCHAIN_DIR=$REMOTE_BUILD_HOST_HOME/$LINARO_VER/gcc
    REMOTE_BUILD_HOST_SYSROOT_DIR=$REMOTE_BUILD_HOST_HOME/$LINARO_VER/

    # copy gcc to remote directory
    echo "Copying gcc to $BUILD_HOST:$REMOTE_BUILD_HOST_TOOLCHAIN_DIR/." && \
    $SYNCCMD $LOCAL_BR_TOOLCHAIN_DIR/* tejas@$BUILD_HOST:$REMOTE_BUILD_HOST_TOOLCHAIN_DIR/. && \
    # copy sysroot to remote directory
    echo "Copying sysroot to $BUILD_HOST:$REMOTE_BUILD_HOST_SYSROOT_DIR" && \
    $SYNCCMD $LOCAL_BR_SYSROOT_DIR tejas@$BUILD_HOST:$REMOTE_BUILD_HOST_SYSROOT_DIR/. || fail
}

sync_with_remote
