
#!/bin/bash

# Install LDAP packages
sudo apt install slapd ldap-utils -y

# Reconfigure slapd
sudo dpkg-reconfigure slapd

# Install tree for directory structure visualization
sudo apt install tree

# Create LDIF file for adding entries
cat <<EOF > add_entries.ldif
dn: ou=Employee,dc=testdomain,dc=local
objectClass: organizationalUnit
ou: Employee

dn: ou=Groups,dc=testdomain,dc=local
objectClass: organizationalUnit
ou: Groups  

dn: cn=IT,ou=Groups,dc=testdomain,dc=local
objectClass: posixGroup        
cn: IT
gidNumber: 5000


dn: uid=testuser1,ou=Employee,dc=testdomain,dc=local
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: testuser1
sn: test
givenName: User1
cn: Test User1
displayName: Test User1
uidNumber: 10000
gidNumber: 5000
userPassword: cisco!123
loginShell: /bin/bash
homeDirectory: /home/testuser1/
EOF

# Add entries to LDAP database
ldapadd -x -D cn=admin,dc=testdomain,dc=local -W -f add_entries.ldif

# # Verify entries using ldapsearch
# ldapsearch -x -LLL -b dc=testdomain,dc=local "uid=testuser1" cn sn gidNumber uidNumber givenName



