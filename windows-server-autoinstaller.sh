#!/bin/bash

# Function to display menu and get user choice
display_menu() {
    echo "Please select the Windows Server or Windows version:"
    echo "1. Windows Server 2016 Original"
    echo "2. Windows Server 2019 Original"
    echo "3. Windows Server 2022 Original"
    echo "4. Windows 10 Original Original"
    echo "5. Windows 11 Original Original"
    echo "6. Windows 10 Tiny10"
    echo "7. Windows 10 Atom OS Lite"
    echo "8. Windows 11 Atom OS Ultimate Pro"
    echo "8. Windows 11 Atom OS Lite"
    read -p "Enter your choice: " choice
}

# Update package repositories and upgrade existing packages
apt-get update && apt-get upgrade -y

# Install QEMU and its utilities
apt-get install qemu -y
apt install qemu-utils -y
apt install qemu-system-x86-xen -y
apt install qemu-system-x86 -y
apt install qemu-kvm -y

echo "QEMU installation completed successfully."

# Get user choice
display_menu

case $choice in
    1)
        # Windows Server 2016 Original
        img_file="windows2016.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195174&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2016.iso"
        ;;
    2)
        # Windows Server 2019 Original
        img_file="windows2019.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195167&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2019.iso"
        ;;
    3)
        # Windows Server 2022 Original
        img_file="windows2022.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195280&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2022.iso"
        ;;
    4)
        # Windows 10 Original
        img_file="windows10.img"
        iso_link="http://download.apidot.site/iso/Win10_22H2_English_x64v1.iso"
        iso_file="windows10.iso"
        ;;
    5)
        # Windows 11 Original
        img_file="windows11.img"
        iso_link="http://download.apidot.site/iso/Win11_24H2_English_x64.iso"
        iso_file="windows11.iso"
        ;;
    6)
        # Windows 10 Tiny10
        img_file="windows10tiny10.img"
        iso_link="http://download.apidot.site/iso/tiny10_23h1_x64.iso"
        iso_file="windows10tiny10.iso"
        ;;
    7)
        # Windows 10 Atom OS Lite
        img_file="windows10atomoslite.img"
        iso_link="http://download.apidot.site/iso/AtomOS10_22h2_Lite_003.iso"
        iso_file="windows10atomoslite.iso"
        ;;
    8)
        # Windows 11 Atom OS Ultimate Pro
        img_file="windows11atomosulti.img"
        iso_link="http://download.apidot.site/iso/AtomOS11_242_Ultimate_004.iso"
        iso_file="windows11atomosulti.iso"
        ;;
    9)
        # Windows 11 Atom OS Lite
        img_file="windows11atomoslite.img"
        iso_link="http://download.apidot.site/iso/AtomOS11_23h2_Lite_004.iso"
        iso_file="windows11atomoslite.iso"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Selected version: $img_file"

# Create a raw image file with the chosen name
qemu-img create -f raw "$img_file" 40G

echo "Image file $img_file created successfully."

# Download Virtio driver ISO
wget -O virtio-win.iso 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.215-1/virtio-win-0.1.215.iso'

echo "Virtio driver ISO downloaded successfully."

# Download Windows ISO with the chosen name
wget -O "$iso_file" "$iso_link"

echo "Windows ISO downloaded successfully."
