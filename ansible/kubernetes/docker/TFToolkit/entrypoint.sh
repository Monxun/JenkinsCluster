#!/bin/bash

# HOMEBREW
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# TF SWITCHER
curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash

# TF LINT
url -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

# TF DOCS
curl -Lo ./terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v0.16.0/terraform-docs-v0.16.0-$(uname)-amd64.tar.gz
tar -xzf terraform-docs.tar.gz
chmod +x terraform-docs
mv terraform-docs /usr/local/terraform-docs

# CHECKOV
pip install checkov

# INFRA COST
/usr/local/bin
curl -fsSL https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh | sh

# BLAST RADIUS
pip install blastradius

# YOR
brew tap bridgecrewio/tap
brew install bridgecrewio/tap/yor