#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Italy /etc/localtime
hwclock --systohc
sed -i '190s/.//' /etc/locale.gen
locale-gen
echo "LANG=it_IT.UTF-8" >> /etc/locale.conf
echo "KEYMAP=it" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:password | chpasswd

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

pacman -S grub efibootmgr sudo pacman -S xorg wpa_supplicant wireless_tools netctl net-tools iw networkmanager alsa-utils pipewire-pulse firewalld mtools dosfstools gparted bluez bluez-utils gnome

# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

# systemctl enable NetworkManger *attenzione al case sensitive.
# systemctl enable gdm
# systemctl enable firewalld
# systemctl enable bluetooth



# exit
# reboot

  

# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB #change the directory to /boot/efi is you mounted the EFI partition at /boot/efi

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable gdm


useradd -m username
echo ermanno:password | chpasswd
usermod -aG libvirt username

echo "ermanno ALL=(ALL) ALL" >> /etc/sudoers.d/username


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"




