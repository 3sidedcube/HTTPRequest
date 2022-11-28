#!/usr/bin/env bash

#
# Script: swagger.sh
# Usage: ./swagger.sh <remote-url> <local-url>
#
# Use swagger-codegen to generate Swift API code.
# https://github.com/swagger-api/swagger-codegen
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# ============================== Variables ==============================

# Red color
RED='\033[0;31m'

# No color
NC='\033[0m'

# Command of swagger-codegen
SWAGGER_CODEGEN_COMMAND="swagger-codegen"

# ============================== Functions ==============================

# Print with red
function printRed {
    printf "${RED}$@${NC}\n"
}

# Print error message and exit with failure
function fatalError {
    printRed "$1" 1>&2
    exit 1
}

# ============================== Main ==============================

# Check swagger-codegen is installed
if ! [ -x "$(command -v ${SWAGGER_CODEGEN_COMMAND})" ]; then
    fatalError "Please install ${SWAGGER_CODEGEN_COMMAND}"
fi

# Check a remote spec url and local url are provided as argument
if [ "$#" -ne 2 ]; then
    fatalError "Usage: $0 <remote-url> <local-url>"
fi

# Execute swagger-codegen
${SWAGGER_CODEGEN_COMMAND} generate -i $1 -l swift5 -o $2

