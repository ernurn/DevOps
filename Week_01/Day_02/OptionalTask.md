# Optional Task Day 2

## Exploración básica
### Abrí la terminal y ejecuta estos comandos. Luego anota que hace cada uno:

- whoami -> ernesto 
(Muestra el usuario que estoy utilizando  actualmente)

- pwd -> /home/ernesto/DevOps/Week_01/Day_02
(Muestra el path o ruta donde estoy situado actualmente)

- ls -lah ->
total 20K
drwxrwxr-x 2 ernesto ernesto 4.0K Jun 16 09:21 .
drwxrwxr-x 4 ernesto ernesto 4.0K Jun 15 11:14 ..
-rw------- 1 ernesto ernesto  12K Jun 16 09:26 .OptionalTask.md.swp
(Lista los archivos y directorios, mostrando los detalles -l, incluido los ocultos -a, en formato humano -h)

- df -hT -> 
Filesystem     Type      Size  Used Avail Use% Mounted on
tmpfs          tmpfs     791M  1.8M  790M   1% /run
/dev/sda2      ext4      915G  792G   78G  92% /
tmpfs          tmpfs     3.9G     0  3.9G   0% /dev/shm
tmpfs          tmpfs     5.0M   12K  5.0M   1% /run/lock
efivarfs       efivarfs  128K  110K   14K  89% /sys/firmware/efi/efivars
/dev/sda1      vfat      1.1G  6.2M  1.1G   1% /boot/efi
tmpfs          tmpfs     791M   96K  791M   1% /run/user/120
tmpfs          tmpfs     791M   84K  791M   1% /run/user/1000
(Muestra el espacio de los discos y su utilización, en formato humano -h, mostrando el tipo de sistema de archivos -T)

- uptime ->
09:31:16 up 3 days, 23:46,  3 users,  load average: 0.19, 0.22, 0.20
(Muestra el tiempo de utilización del equipo, usuarios conectados y la carga de trabajo)


### Navegá por los directorios clave del sistema

- cd /
ls -> 
bin                home               mnt   sbin.usr-is-merged  usr
bin.usr-is-merged  lib                opt   snap                var
boot               lib64              proc  srv
cdrom              lib.usr-is-merged  root  swap.img
dev                lost+found         run   sys
etc                media              sbin  tmp

- cd /etc && ls ->
adduser.conf            gtk-3.0              polkit-1
alsa                    hdparm.conf          ppp
alternatives            host.conf            printcap
anacrontab              hostname             profile
apache2                 hosts                profile.d
apg.conf                hosts.allow          protocols
apm                     hosts.deny           pulse
apparmor                hp                   python3
apparmor.d              ifplugd              python3.12
apport                  init                 rc0.d
apt                     init.d               rc1.d
avahi                   initramfs-tools      rc2.d
bash.bashrc             inputrc              rc3.d
bash_completion         insserv.conf.d       rc4.d
bash_completion.d       ipp-usb              rc5.d
bindresvport.blacklist  iproute2             rc6.d
binfmt.d                issue                rcS.d
bitcoin                 issue.net            resolv.conf
bluetooth               kernel               rmt
brlapi.key              kerneloops.conf      rpc
brltty                  krb5.conf.d          rsyslog.conf
brltty.conf             ldap                 rsyslog.d
ca-certificates         ld.so.cache          rygel.conf
ca-certificates.conf    ld.so.conf           sane.d
chatscripts             ld.so.conf.d         security
cloud                   legal                selinux
colord                  libao.conf           sensors3.conf
console-setup           libaudit.conf        sensors.d
cracklib                libblockdev          services
credstore               libibverbs.d         sgml
credstore.encrypted     libnl-3              shadow
cron.d                  libpaper.d           shadow-
cron.daily              libreoffice          shells
cron.hourly             lighttpd             skel
cron.monthly            locale.alias         snmp
crontab                 locale.conf          speech-dispatcher
cron.weekly             locale.gen           ssh
cron.yearly             localtime            ssl
cups                    logcheck             sssd
cupshelpers             login.defs           subgid
dbus-1                  logrotate.conf       subgid-
dconf                   logrotate.d          subuid
debconf.conf            lsb-release          subuid-
debian_version          machine-id           sudo.conf
debuginfod              magic                sudoers
default                 magic.mime           sudoers.d
deluser.conf            manpath.config       sudo_logsrvd.conf
depmod.d                mime.types           supercat
dhcp                    mke2fs.conf          sysctl.conf
dhcpcd.conf             ModemManager         sysctl.d
dictionaries-common     modprobe.d           sysstat
dpkg                    modules              systemd
e2scrub.conf            modules-load.d       terminfo
emacs                   mtab                 thermald
environment             nanorc               timezone
environment.d           netconfig            tmpfiles.d
ethertypes              netplan              ubuntu-advantage
fonts                   network              ucf.conf
fprintd.conf            networkd-dispatcher  udev
fstab                   NetworkManager       udisks2
fuse.conf               networks             ufw
fwupd                   newt                 update-manager
gai.conf                nftables.conf        update-motd.d
gdb                     nginx                update-notifier
gdm3                    nsswitch.conf        UPower
geoclue                 openvpn              usb_modeswitch.conf
ghostscript             opt                  usb_modeswitch.d
glvnd                   os-release           vconsole.conf
gnome                   PackageKit           vim
gnome-remote-desktop    pam.conf             vtrgb
gnutls                  pam.d                vulkan
gprofng.rc              papersize            wgetrc
groff                   passwd               wpa_supplicant
group                   passwd-              X11
group-                  pcmcia               xattr.conf
grub.d                  perl                 xdg
gshadow                 pki                  xml
gshadow-                plymouth             zsh_command_not_found
gss                     pm
gtk-2.0                 pnm2ppa.conf

- cd /home/ && ls ->
ernesto

## Creá y manimpulá archivos
### Crea una carpeta llamada devops-d2:

ernesto@Linux:~/DevOps/Week_01/Day_02/devops-d2$

### Crea un archivo de prueba y escribe contenido en el:

Day_02/devops-d2$echo "Hola Roxs DevOps!" > saludos.txt

ernesto@Linux:~/DevOps/Week_01/Day_02/devops-d2$ ls
saludos.txt

### Copialo, renombralo y eliminá uno:

cp saludos.txt copia.txt (copiar)

ernesto@Linux:~/DevOps/Week_01/Day_02/devops-d2$ ls
copia.txt  saludos.txt

mv copia.txt hola.txt (renombrar / mover)

ernesto@Linux:~/DevOps/Week_01/Day_02/devops-d2$ ls
hola.txt  saludos.txt

rm saludos.txt (eliminar)
ernesto@Linux:~/DevOps/Week_01/Day_02/devops-d2$ ls
hola.txt

## Usuarios  y permisos
### Crea un nuevo usuario en el sistema:

ernesto@Linux:~/DevOps/Week_01/Day_02/devops-d2$ sudo adduser invitado
[sudo] password for ernesto:
info: Adding user `invitado' ...
info: Selecting UID/GID from range 1000 to 59999 ...
info: Adding new group `invitado' (1001) ...
info: Adding new user `invitado' (1001) with group `invitado (1001)' ...
info: Creating home directory `/home/invitado' ...
info: Copying files from `/etc/skel' ...
New password:
BAD PASSWORD: The password is shorter than 8 characters
Retype new password:
passwd: password updated successfully
Changing the user information for invitado
Enter the new value, or press ENTER for the default
        Full Name []: Invitado
        Room Number []:
        Work Phone []:
        Home Phone []:
        Other []:
Is the information correct? [Y/n] Y
info: Adding new user `invitado' to supplemental / extra groups `users' ...
info: Adding user `invitado' to group `users' ...

### Crea un grupo y asigná ese usuario:

sudo groupadd roxsdevs
sudo usermod -aG roxsdevs invitado

invitado:x:1001:
roxsdevs:x:1005:invitado

### Cambiá los permisos de un archivo para que:

- El dueño pueda leer/escribir/ejecutar (7)
- El grupo solo leer (4)
- Otros, nada (0)

** Regla RWX 4 + 2 + 1 = 7**

chmod 740 hola.txt
ls -l

-rwxr----- 1 ernesto ernesto 18 Jun 16 09:56 hola.txt


## Buscar archivos con permisos peligrosos (777)
### Comandondo muy utilizado en producción

- find / -type f -perm 0777 2>/dev/null

No se encontraron archivos inseguros


## Reto de comprensión
### ¿Qué hace este comando?

- chmod u=rwx,g=rx,o= hola.txt

chmod en un comando para cambiar los permisos sobre un archivo o directorio, en este caso, sobre el archivo hola.txt
Al usuario (u=) le asigna todos los permisos lectura(r), escritura(w) y ejecución(x), al grupo (g=) le asigna los permisos de lectura y ejecución. Y a otros no le otorga ningún permiso.

## Compartí tu terminal
- ernesto@Linux:~/DevOps/Week_01/Day_02$ tree
![Captura de pantalla](https://drive.google.com/file/d/1jJHYTEnGOqRELxJfy9STvClVYxaJ2eJt/view?usp=drive_link)
#DevOpsConRoxs


