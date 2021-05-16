import requests
import json
import subprocess
import sys

# gets result as a string
ip = subprocess.run("grep connected central.log | cut -d \",\" -f2 | sort | uniq", shell = True, capture_output=True, text=True)
#print(ip.stdout)

for letter in ip.stdout:
    pass
    #print(letter)
################################

# https://www.abstractapi.com/guides/how-to-geolocate-an-ip-address-in-python
# so for now lets just read a file List
with open("visitors.txt","r") as visitors:
    ips=visitors.readlines()
    #print (ips)
for ip_address in ips:
    clean_ip=ip_address.replace("\n","")
    #ip.replace("\n","")
    #print (clean_ip)
    print("-------------------------")
    clean_ip=ip_address.replace("\n","")
    request_url = 'https://geolocation-db.com/jsonp/' + clean_ip
    #print(request_url)
    # Send request and decode the result
    response = requests.get(request_url)
    result = response.content.decode()
    # Clean the returned string so it just contains the dictionary data for the IP address
    result = result.split("(")[1].strip(")")
    print(result)
    # Convert this data into a dictionary
    result  = json.loads(result)
    print(result)
