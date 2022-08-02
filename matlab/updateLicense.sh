#!/bin/bash

# Update a MATLAB license without administrator password

NEW_LICENSE="${HOME}/Downloads/license.lic"
MATLAB_VERSION="R2021a"


DEST_LIC_PATH="${HOME}/AppData/Roaming/MathWorks/MATLAB/${MATLAB_VERSION}_licenses"
LIC_NO="$(cat ${NEW_LICENSE} | grep -Po "(?<=#\sLicenseNo:\s).*" )"
mkdir -p "${DEST_LIC_PATH}"
cp "${NEW_LICENSE}" "${DEST_LIC_PATH}/license_$(hostname)_${LIC_NO}_${MATLAB_VERSION}.lic"
