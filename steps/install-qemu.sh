#!/bin/sh

print_step "QEMU/KVM" "Installs virtualization tools (QEMU, Libvirt, Virt-manager)"

yay -S --noconfirm --needed qemu-full libvirt dnsmasq virt-manager bridge-utils flex bison edk2-ovmf

sudo systemctl enable --now libvirtd
sudo systemctl enable --now virtlogd

echo 1 | sudo tee /sys/module/kvm/parameters/ignore_msrs

sudo modprobe kvm
