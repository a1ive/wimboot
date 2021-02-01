rd /s /q build
md build
cd build

set guid={19260817-6666-8888-abcd-000000000000}
set winload=\WINLOAD0000000000000000000000000000000000000000000000000000000
set windir=\WINDIR000000000000000000000000
set wincmd=DDISABLE_INTEGRITY_CHECKS000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

set bcdfile=/store bcdwim
set wimfile=\000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000.wim

bcdedit /createstore bcdwim
bcdedit %bcdfile% /create {bootmgr} /d "GNU GRUB NTBOOT"
bcdedit %bcdfile% /set {bootmgr} timeout 1
bcdedit %bcdfile% /set {bootmgr} locale en-us
bcdedit %bcdfile% /set {bootmgr} displaybootmenu true
bcdedit %bcdfile% /create {ramdiskoptions}
bcdedit %bcdfile% /set {ramdiskoptions} ramdisksdidevice "boot"
bcdedit %bcdfile% /set {ramdiskoptions} ramdisksdipath \boot\boot.sdi
bcdedit %bcdfile% /create %guid% /d "GNU GRUB NTBOOT NT6+ WIM" /application OSLOADER
bcdedit %bcdfile% /set %guid% device ramdisk=[C:]%wimfile%,{ramdiskoptions}
bcdedit %bcdfile% /set %guid% path %winload%
bcdedit %bcdfile% /set %guid% osdevice ramdisk=[C:]%wimfile%,{ramdiskoptions}
bcdedit %bcdfile% /set %guid% locale en-us
bcdedit %bcdfile% /set %guid% systemroot %windir%
bcdedit %bcdfile% /set %guid% detecthal true
bcdedit %bcdfile% /set %guid% winpe true
bcdedit %bcdfile% /set %guid% testsigning true
bcdedit %bcdfile% /set %guid% pae default
bcdedit %bcdfile% /set %guid% nx OptIn
bcdedit %bcdfile% /set %guid% highestmode true
bcdedit %bcdfile% /set %guid% nointegritychecks true
bcdedit %bcdfile% /set %guid% loadoptions %wincmd%
bcdedit %bcdfile% /displayorder %guid% /addlast

set bcdfile=/store bcdvhd
set vhdfile=\000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000.vhd

bcdedit /createstore bcdvhd
bcdedit %bcdfile% /create {bootmgr} /d "GNU GRUB NTBOOT"
bcdedit %bcdfile% /set {bootmgr} timeout 1
bcdedit %bcdfile% /set {bootmgr} locale en-us
bcdedit %bcdfile% /set {bootmgr} displaybootmenu true
bcdedit %bcdfile% /create {globalsettings}
bcdedit %bcdfile% /set {globalsettings} optionsedit true
bcdedit %bcdfile% /set {globalsettings} advancedoptions true
bcdedit %bcdfile% /create %guid% /d "GNU GRUB NTBOOT NT6+ VHD" /application OSLOADER
bcdedit %bcdfile% /set %guid% device vhd=[C:]%vhdfile%
bcdedit %bcdfile% /set %guid% path %winload%
bcdedit %bcdfile% /set %guid% osdevice vhd=[C:]%vhdfile%
bcdedit %bcdfile% /set %guid% locale en-us
bcdedit %bcdfile% /set %guid% systemroot %windir%
bcdedit %bcdfile% /set %guid% detecthal true
bcdedit %bcdfile% /set %guid% winpe false
bcdedit %bcdfile% /set %guid% testsigning true
bcdedit %bcdfile% /set %guid% pae default
bcdedit %bcdfile% /set %guid% nx OptIn
bcdedit %bcdfile% /set %guid% highestmode true
bcdedit %bcdfile% /set %guid% nointegritychecks true
bcdedit %bcdfile% /set %guid% loadoptions %wincmd%
bcdedit %bcdfile% /displayorder %guid% /addlast

set bcdfile=/store bcdwin

bcdedit /createstore bcdwin
bcdedit %bcdfile% /create {bootmgr} /d "GNU GRUB NTBOOT"
bcdedit %bcdfile% /set {bootmgr} timeout 1
bcdedit %bcdfile% /set {bootmgr} locale en-us
bcdedit %bcdfile% /set {bootmgr} displaybootmenu true
bcdedit %bcdfile% /create {globalsettings}
bcdedit %bcdfile% /set {globalsettings} optionsedit true
bcdedit %bcdfile% /set {globalsettings} advancedoptions true
bcdedit %bcdfile% /create %guid% /d "GNU GRUB NTBOOT NT6+ OS" /application OSLOADER
bcdedit %bcdfile% /set %guid% device partition=C:
bcdedit %bcdfile% /set %guid% path %winload%
bcdedit %bcdfile% /set %guid% osdevice partition=C:
bcdedit %bcdfile% /set %guid% inherit {bootloadersettings}
bcdedit %bcdfile% /set %guid% locale en-us
bcdedit %bcdfile% /set %guid% systemroot %windir%
bcdedit %bcdfile% /set %guid% detecthal true
bcdedit %bcdfile% /set %guid% winpe true
bcdedit %bcdfile% /set %guid% testsigning true
bcdedit %bcdfile% /set %guid% pae default
bcdedit %bcdfile% /set %guid% nx OptIn
bcdedit %bcdfile% /set %guid% highestmode true
bcdedit %bcdfile% /set %guid% nointegritychecks true
bcdedit %bcdfile% /set %guid% loadoptions %wincmd%
bcdedit %bcdfile% /displayorder %guid% /addlast

cd ..
