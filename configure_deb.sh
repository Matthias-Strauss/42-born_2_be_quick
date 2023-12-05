#!/bin/bash

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root or with sudo privileges."
   exit 1
fi

read -t 10 -p "Please enter your personal intra name: \n" INTRA_NAME
echo -e "Hello ${INTRA_NAME},\nlet's get your b2br setup ;)"

echo -e "Updating System..."
apt-get update -y
apt-get install -y git
git clone https://github.com/gemartin99/Born2beroot-Tester.git b2br_tester
apt-get upgrade -y
echo -e "✓ System successfully updated"



###########################################################################################################################
######################################### PASSWORD RULES ##################################################################
###########################################################################################################################

echo " \n###########################################\n# Configuring Password Rules... \n#################################"
sleep 1

sed -i 's/PASS_MAX_DAYS\t99999/PASS_MAX_DAYS\t30/' /etc/login.defs
echo "✓ Set password expiration to:\t 30 days"
sleep 1

sed -i 's/PASS_MIN_DAYS\t0/PASS_MIN_DAYS\t2/' /etc/login.defs
echo "✓ Set minimum days before password change to:\t  2"
sleep 1

sed -i 's/PASS_WARN_AGE\t7/PASS_WARN_AGE\t7/' /etc/login.defs
echo "✓ Set warning days before password expiration to:\t  7\n\n"
sleep 3

echo "Configure password complexity rules using pam_pwquality..."
sleep 1

apt-get --yes --force-yes install libpam-pwquality -y
echo "✓ Installed pam_pwquality if not already installed"
sleep 3

echo "Setting following rules to enforce password complexity:\n"
cat <<EOF >> /etc/security/pwquality.conf
minlen = 10
minclass = 3
maxrepeat = 3
maxsequence = 0
reject_username
enforce_for_root
difok = 7
EOF
echo "✓ minlen\t=\t10\n"
sleep 1
echo "✓ minclass\t=\t3\n"
sleep 1
echo "✓ maxrepeat\t=\t3\n"
sleep 1
echo "✓ maxsequence\t=\t0\n"
sleep 1
echo "✓ reject_username\t\ttrue\n"
sleep 1
echo "✓ enforce_for_root\t\ttrue\n"
sleep 1
echo "✓ difok\t=\t7\n\n"
sleep 5

echo "Editing common-password file to apply the password complexity rules..."
sed -i '/password.*requisite.*pam_pwquality.so/s/$/ retry=3/' /etc/pam.d/common-password
sleep 1

# Exclude root from the 7 new characters for new password rule
sed -i '/password.*requisite.*pam_unix.so.*remember=/ s/$/6/' /etc/pam.d/common-password
sleep 1

echo "############################################\n# Password policy configured successfully. \#\n############################################\n"
sleep 5



###########################################################################################################################
########################################### SUDO RULES ####################################################################
###########################################################################################################################

# Limit sudo authentication to 3 attempts with a custom error message
echo -e "Defaults        authenticate\nDefaults        authenticate_tries=3\nDefaults        badpass_message=\"Do you 'member? I 'member.\"" | sudo tee -a /etc/sudoers.d/custom_sudo
echo "✓ Set login attempts to a max of 3"
sleep 1

# Enable sudo command logging with input and output to /var/log/sudo/
echo -e "Defaults        log_input,log_output\nDefaults        logfile=/var/log/sudo/sudo.log" | sudo tee -a /etc/sudoers.d/custom_sudo_logging
echo "✓ Sudo command logging: TRUE"
sleep 1

# Enable TTY mode for sudo
echo -e "Defaults        requiretty" | sudo tee -a /etc/sudoers.d/custom_sudo_tty
echo "✓ TTY mode for sudo: TRUE"
sleep 1

# Restrict paths for sudo
echo -e "Defaults        secure_path=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin\"" | sudo tee -a /etc/sudoers.d/custom_sudo_paths
echo "✓ Restrict sudo Paths"
sleep 1

# Prevent SSH login as root
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
service ssh restart
echo "✓ Prevent SSH login as root"
sleep 1

# # Create a new group if needed
# sudo groupadd customgroup

# # Create a new user with sudo privileges and add to the custom group
# sudo useradd -m -s /bin/bash -G sudo,customgroup newuser

# # Change the password for the new user
# sudo passwd newuser


echo "Sudo Configuration completed."

################################################ SSH setup ################################################################
echo -e "Setting up SSH..."
sleep 1
echo -e "installing SSH package..."
apt-get --yes install openssh-server
sleep 1
echo -e "✓ OpenSSH successfully installed"

 
###########################################################################################################################
################################################ BONUS ####################################################################
###########################################################################################################################

echo -e "\n###########################################\n#            BONUS             #\n#################################"



################################################ OpenVPN setup ############################################################


# Install OpenVPN
#apt-get update
echo "Installing OpenVPN..."
apt-get --yes --force-yes install openvpn
echo "OenVPN successfully installed"

# Copy example OpenVPN configuration files
cp -r /usr/share/doc/openvpn/examples/easy-rsa/ /etc/openvpn/

# Navigate to the easy-rsa directory
cd /etc/openvpn/easy-rsa || exit

# Set up the necessary files
source vars
./clean-all
./build-ca
./build-key-server server
./build-dh
echo "✓ Setting up neccessary files"
sleep 1

# Generate the client key and certificate
./build-key client1
echo "✓ Client Key generated"
sleep 1


# Create server configuration file
cat << EOF > /etc/openvpn/server.conf
port 4242
proto udp
dev tun
ca easy-rsa/keys/ca.crt
cert easy-rsa/keys/server.crt
key easy-rsa/keys/server.key
dh easy-rsa/keys/dh2048.pem
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
keepalive 10 120
comp-lzo
persist-key
persist-tun
status openvpn-status.log
verb 3
EOF
echo "✓ Config files generated"
sleep 1


# Enable IP forwarding
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p
echo "✓ IP forwarding enabled"
sleep 1

# Start OpenVPN service
systemctl start openvpn@server
systemctl enable openvpn@server
echo "✓ run OpenVPN at boot: TRUE"

echo -e "OpenVPN has been installed and configured. \nClient configuration files are available in /etc/openvpn/easy-rsa/keys/"



###########################################################################################################################
################################################ B2BR_Tester ##############################################################
###########################################################################################################################
cd Born2beroot-Tester/
bash Test.sh




######################
# ADDITIONAL PROMPTS #
######################

hostname of the machine must be "mstrauss42"

