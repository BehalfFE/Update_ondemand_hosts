# Update_ondemand_hosts

# setting:
In the hosts file (/etc/hosts) the ondemand enviorment line should come after a header which includes the text - "on-demand-tester" and some under-line line.<br/> 
the script will look & replace the text that comes 2 line below the header. 
# Example:
\# on-demand-tester<br/> 
\################<br/>
10.200.5.248 www.local3387.test.behalf.com app.local3387.test.behalf.com api.local3387.test.behalf.com admin.local3387.test.behalf.com dashboard.local3387.test.behalf.com be.local.behalf.com<br/>
# Usage:
sudo ./update_ondemand_hosts \<ip adress\> \<build number\>
