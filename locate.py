import requests
import json
import subprocess
import sys
import time

# print either city/state or lat/long for map
# start with locate.py l for numbers, nothing or anything else for names

output_list = []
output_style = sys.argv[1:] or ['c']

# pull ip addresses from log .. make sure to have correct log file path
ip = subprocess.run("grep connected /var/log/klezmer.log | cut -d \",\" -f2 | sort | uniq > ip.txt", shell = True )
################################
with open("ip.txt","r") as visitors:
    ips=visitors.readlines()

for ip_address in ips:
    #print (".", end=" ")
    clean_ip=ip_address.replace("\n","")
    request_url = 'https://geolocation-db.com/jsonp/' + clean_ip.lstrip()
    # Send request and decode the result
    response = requests.get(request_url)
    result = response.content.decode()
    # Clean the returned string so it just contains the dictionary data for the IP address
    result = result.split("(")[1].strip(")")
    # Convert this data into a dictionary
    result  = json.loads(result)
    # output the items we want for the map
    if output_style[0] == "l":
        print ("{},{}".format(result["latitude"],result["longitude"]) )
    else:
        res = ("{},{}".format(result["city"],result["state"]) )
        output_list.append (res)
        
    time.sleep(.5)
    
if output_style[0] == "c":    
	output_list.sort()
	for place in output_list:
		print (place)

'''
# https://www.abstractapi.com/guides/how-to-geolocate-an-ip-address-in-python
# gets result as a string
ip = subprocess.run("grep connected central.log | cut -d \",\" -f2 | sort | uniq", shell = True, capture_output=True, text=True)

Redirect the output of this script to a .cvs file which can be imported into maps

Getting data into google maps
menu/Your Places/Maps
create map on bottom
'''
