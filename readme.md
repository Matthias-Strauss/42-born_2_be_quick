REQUIREMENTS
-- SELinux must be running at startup and its configuration has to be adapted for the project’s needs
-- create at least 2 encrypted partitions using LVM
-- a SSH service will be running on port 4242 onlys, it must not be possible to connect using SSH as root
-- configure UFW firewall and leave ONLY port 4242 open
-- firewall needs to be active at launch
-- hostname = login name + 42 --> mstrauss42
-- implement a strong password policy
-- install and configure sudo following strict rules
-- additionally to the root user, a user with your login as username has to be present --> groups: user42 and sudo

BE ABLE TO EXPLAIN
-- differences between aptitude and apt
-- SELinux
-- AppArmor

BE ABLE TO
-- create a new account / user
-- add user to group

#### PASSWORD REQUIREMENTS

• Your password has to expire every 30 days.
• The minimum number of days allowed before the modification of a password will
be set to 2.
• The user has to receive a warning message 7 days before their password expires.
• Your password must be at least 10 characters long. It must contain an uppercase
letter, a lowercase letter, and a number. Also, it must not contain more than 3
consecutive identical characters.
• The password must not include the name of the user.
• The following rule does not apply to the root password: The password must have
at least 7 characters that are not part of the former password.
• Of course, your root password has to comply with this policy

######

NOTE:After setting up your configuration files, you will have to change
all the passwords of the accounts present on the virtual machine,
including the root account.

######

#### SUDO GROUP

• Authentication using sudo has to be limited to 3 attempts in the event of an incorrect password.
• A custom message of your choice has to be displayed if an error due to a wrong
password occurs when using sudo.
• Each action using sudo has to be archived, both inputs and outputs. The log file
has to be saved in the /var/log/sudo/ folder.
• The TTY mode has to be enabled for security reasons.
• For security reasons too, the paths that can be used by sudo must be restricted.
Example:
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin

#### SCRIPT

At server startup, the script will display some information (listed below) on all terminals every
10 minutes (take a look at wall). The banner is optional. No error must be visible.

• The architecture of your operating system and its kernel version.
• The number of physical processors.
• The number of virtual processors.
• The current available RAM on your server and its utilization rate as a percentage.
• The current available memory on your server and its utilization rate as a percentage.
• The current utilization rate of your processors as a percentage.
• The date and time of the last reboot.
• Whether LVM is active or not.
• The number of active connections.
• The number of users using the server.
• The IPv4 address of your server and its MAC (Media Access Control) address.
• The number of commands executed with the sudo program

TIPS: wall, cron

### BONUS

1. PARTITIONS --> check pdf
2. WordPress website with the following services: lighttpd, MariaDB, and PHP.
3. Service of your choice you believe is useful (NO NGINX / Apache 2)
4.
# Born2beQuick
