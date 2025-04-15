#!/bin/bash
set -e

echo "Copying repo files into container"
cp -R /github/workspace/ /app/.blueprint/dev/

echo "Running blueprint build"
blueprint -build

identifier=$(grep -m 1 "identifier:" /app/.blueprint/dev/conf.yml | cut -d ":" -f2 | xargs)

echo "Copying output back to workspace"
cp "/app/${identifier}.blueprint" "/github/workspace/${identifier}.blueprint"

# Set output if needed
echo "blueprint_file=${identifier}.blueprint" >> $GITHUB_OUTPUT
