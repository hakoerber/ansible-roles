# Required parameters:
#
# rootpw: SHA512-hashed root password
# me: admin user with SSH access and passwordless sudo
# sshkey: SSH public key to add to admin user

auth --enableshadow --passalgo=sha512
rootpw --iscrypted $rootpw

firewall --disabled

keyboard --vckeymap=de-nodeadkeys
lang en_US.UTF-8
timezone --nontp --utc Etc/UTC --nontp

selinux --enforcing

services --disabled=firewalld,NetworkManager

install
skipx
text
poweroff
url --url=$tree

%addon com_redhat_kdump --disable
%end

$SNIPPET('network-' + $name)
$SNIPPET('storage-' + $name)

%packages --excludedocs
@Core
-firewalld
-NetworkManager
%end

%post --erroronfail
$SNIPPET('usersetup')
%end
