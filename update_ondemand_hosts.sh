#!/bin/sh


# variables
ip=$1
build_number=$2
hosts_file='/etc/hosts'
hosts_backup_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" #the dir of this bash script
hosts_backup_file='hosts.backup'
header_text='on-demand-tester'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color


# check for root user
if [ "$EUID" -ne 0 ]; then
    echo "${RED}Please! run as root${NC}"
    exit 1
fi

# check for 2 params
if [ $# -ne 2 ]; then
    echo "${RED}Missing arguments. Usage:\n${NC} sudo ./update_ondemand_hosts <ip adress> <build number>"
    exit 1
fi




# get the line number
line_number=`grep "$header_text" -n  $hosts_file | cut -f1 -d:`

# check that header exists in the hosts file
if [ -z "$line_number" ]; then
    echo "\n${RED}Header '$header_text' is not found in '$hosts_file' !!!${NC}"
    echo "${RED}Current hosts file should include something like this:${NC}"
    echo "#################################"
    echo "# $header_text "
    echo "#################################"
    echo "<--- the line that will be replaced --->\n"
    exit 1
fi
line_number=$(( $line_number + 2))



# prepare the new line
new_line="$ip www.local${build_number}.test.behalf.com app.local${build_number}.test.behalf.com api.local${build_number}.test.behalf.com admin.local${build_number}.test.behalf.com dashboard.local${build_number}.test.behalf.com be.local.behalf.com"

# back the currnet hosts file
cp $hosts_file $hosts_backup_path/$hosts_backup_file
clear
echo "Backup of the hosts file is in - ${BLUE}$hosts_backup_path/$hosts_backup_file${NC}"
# disclaimer

echo "\nSetting the $header_text hosts to:\n"
echo "${BLUE}$new_line${NC}\n"

sed -i ""  "${line_number}s/.*/${new_line}/" ${hosts_file}