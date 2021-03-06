#!/bin/sh

function check_feature()
{
    FEATURE="$1"
    SRC="$2"
    OPTS="$3"

    if gcc ${OPTS} -c ${SRC}; then
        echo "#define ${FEATURE}"
    else
        echo "/* ${FEATURE} config not set */"
    fi
}

NEW_CAPI_APPFW=$(check_feature PRIVATE_CAPI_APPFW \
                               ./feature_tests/new_capi_appfw.cpp \
                               -I/usr/include/appfw)

API_CONFIG_DEFINES="
${NEW_CAPI_APPFW}
"

cat << EOF
/*
 * Autogenerated header
 */

#ifndef __API_CONFIG__
#define __API_CONFIG__
${API_CONFIG_DEFINES}
#endif /* __API_CONFIG__ */
EOF
