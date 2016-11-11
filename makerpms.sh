#!/usr/bin/bash
set -o errexit

pushd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

test ! -x "configure" && autoreconf -i
test ! -f "Makefile" && ./configure --enable-silent-rules "$@"
make rpms

popd