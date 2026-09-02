# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright (c) 2026 Christopher Stewart
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

