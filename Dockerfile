#    Copyright (C) 2026 Christopher Stewart
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://gnu.org>.
#
###
###
# Setup docker image with latest Fedora and install latest OpenSSH,
# HashiCorp repo to install latest Terraform then install latest Ansible
#

FROM fedora:latest

# Update system and install basic utilities and OpenSSH clients
RUN dnf update -y && \
    dnf install -y dnf-plugins-core openssh-clients git procps-ng iproute iputils && \
    dnf clean all

# Add HashiCorp official repository and install Terraform
#RUN dnf config-manager --add-repo https://hashicorp.com && \
RUN dnf config-manager addrepo --from-repofile=https://rpm.releases.hashicorp.com/fedora/hashicorp.repo && \
    dnf install -y terraform && \
    dnf clean all

# Install Ansible
RUN dnf install -y ansible && \
    dnf clean all

# Verify installations
RUN terraform --version && \
    ansible --version && \
    ssh -V

