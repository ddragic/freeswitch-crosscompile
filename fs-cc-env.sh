#!/bin/sh

#
# Very simple freeswitch cross-compile enviroment setup script.
#

TOOLCHAIN_BIN=$1
SYSROOT=$2
BUILD_TC_ARCH=$3
HOST_TC_ARCH=$4

if [ -z "${TOOLCHAIN_BIN}" ] || [ -z "${SYSROOT}" ] || [ -z "${BUILD_TC_ARCH}" ] || [ -z "${HOST_TC_ARCH}" ] ; then
	echo "Usage: "`basename ${0}`" <toolchain-bin-dir> <sysroot> <build-arch> <host-arch>"
fi

if ! echo "${PATH}" | grep "${TOOLCHAIN_BIN}" &>/dev/null ; then
	export PATH="${PATH}:${TOOLCHAIN_BIN}"
fi

# can't check for these when cross compiling
export ac_cv_file__dev_ptmx=yes
export ac_cv_file__dev_zero=yes
export ac_cv_file__dev_urandom=yes
export ac_cv_func_setpgrp_void=yes
export ac_cv_va_copy=yes

# rpl_malloc
export ac_cv_func_realloc_0_nonnull=yes
export ac_cv_func_malloc_0_nonnull=yes

# apr
export apr_cv_tcp_nodelay_with_cork=yes
export ac_cv_file_dbd_apr_dbd_mysql_c=no
export ac_cv_sizeof_ssize_t=4
export apr_cv_mutex_recursive=yes
export ac_cv_func_pthread_rwlock_init=yes
export apr_cv_type_rwlock_t=yes

# compiler/linker flags
export CFLAGS="--sysroot=${SYSROOT}"
export CXXFLAGS="${CFLAGS}"
export LDFLAGS="--sysroot=${SYSROOT}"

# sqlite
export config_BUILD_CC="${BUILD_TC_ARCH}-gcc"
export config_TARGET_CC="${HOST_TC_ARCH}-gcc"
export config_TARGET_CFLAGS="${CFLAGS}"

# needed for static makefiles (libs/ESL)
export CC="${HOST_TC_ARCH}-gcc"
export CXX="${HOST_TC_ARCH}-g++"
