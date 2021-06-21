#!/bin/bash

# force 'sudo' when running this script
[ "$(id --user)" -ne 0 ] && echo 'please, run this script as superuser' && exit 1

packages='krb5-user libpam-krb5 libpam-ccreds'
if ! dpkg -s ${packages} > /dev/null 2>&1 ; then
	echo '--> Install Kerberos dependencies... '
	apt-get install ${packages} --yes
fi

echo '--> Creation of the LDAP user'
read -rp 'Enter your LDAP user: ' id_user
[ -z "${id_user}" ] && echo 'please, fill your LDAP user' && exit 1

# UID of the LDAP user
uid=5000
grep --quiet "^${id_user}" /etc/passwd || adduser --no-create-home --system --uid ${uid} "${id_user}" > /dev/null
# These modifications with `minimum_uid` avoid to impact current machine user (which usually have UID=1000) with kerberos
# The impact introduce latencies on every login (machine login or any `sudo` at runtime)
for krb5_common in $(ls /etc/pam.d/common-*) ; do
	sed -i -r -e "s/pam_krb5.so minimum_uid=[0-9]*/pam_krb5.so minimum_uid=${uid}/" ${krb5_common}
done

echo -n '--> Setting up the machine for Kerberos... '
activeDirectoryIP='10.50.83.15 par-ad-05.canaltp.local par-ad-05'
grep --quiet "^${activeDirectoryIP}" /etc/hosts || echo "${activeDirectoryIP}" >> /etc/hosts

cat << EOF > /etc/krb5.conf
[libdefaults]
	default_realm = CANALTP.LOCAL
	kdc_timesync = 1
	ccache_type = 4
	forwardable = true
	proxiable = true
	fcc-mit-ticketflags = true

[realms]
	CANALTP.LOCAL = {
		kdc = par-ad-05:88
		admin_server = par-ad-05:749
	}

[domain_realm]
	.canaltp.local = CANALTP.LOCAL
	canaltp.local = CANALTP.LOCAL
EOF
echo 'OK'

echo '--> Initialize Kerberos token'
kinit "${id_user}"@CANALTP.LOCAL

echo
echo 'Congratulations! Your machine is now Kerberos awared.'
echo 'You can now change your LDAP password with'
echo "$> sudo kpasswd ${id_user}"
