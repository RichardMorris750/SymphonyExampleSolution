Set up and configuration of Symphony Bridge.

From the Symphony Framework web site download and install the Symphony Bridge product (on the Downloads tab).

Once the installation completes:

Copy the SymphonyBridgeServerService.exe.config file (from this solution) into the C:\Program Files (x86)\Synergex\SymphonyFramework\SymphonyBridge folder.  You will need elevated privileges to perform this action.

Copy the SymphonyExampleSolution\AppData_Server\bin\Debug\AppData.dll assembly file to the C:\Program Files (x86)\Synergex\SymphonyFramework\SymphonyBridge folder.  You will need elevated privileges to perform this action.

By default the server uses port 8083 which you may need to open up as an inbound port through your firewall.

Open a command prompt with elevated privileges and navigate to the C:\Program Files (x86)\Synergex\SymphonyFramework\SymphonyBridge folder.  Once here type in the command:

SBServiceCreate 1

This will create the Symphony Bridge Windows Service and start it running.

Using a browser you should be able to connect through to the server and check it is running.  Use the URL http://localhost:8083/api/sysinfo.  This request should return information about the server, similar to:

[
    {
        "Api_verion": "1",
        "Framework_verison": "3.2.31.0",
        "Synergy_version": "10.3.3",
        "Catalogue_exposed": true,
        "Authentication_enabled": false,
        "Current_domain_count": 0
    }
]

You can then perform a query, for example:

http://localhost:8083/api/v1/products

will return all the product items.  You can select an individual product:

http://localhost:8083/api/v1/products/COK002

You can search for a product by words in it description, and reduce the fields being returned:

http://localhost:8083/api/v1/products?fields=prod_code,prod_description,cost_price&filter=prod_description like 'coke'&casing=false

You can limit the records returned:

http://localhost:8083/api/v1/products?fields=prod_code,prod_description,cost_price&limit=5

Once the server is running you can then run the SFE_Web project (set as default).

After selecting one of the maintenance options you receive a message saying CORS no configured, perform the following steps:
-	Looking in the browser bar, note the URI of the request, it will be similar to “localhost:51168”
-	Edit the C:\Program Files (x86)\Synergex\SymphonyFramework\SymphonyBridge\ SymphonyBridgeServerService.exe.config file (you will need elevated priviliges).
-	Change the SYMPHONY_BRIDGE_CORS_DOMAINS value to the URI from your browser.
-	Restart the SymphonyBridge_1 service.

To view the standard maintenance web site make the SFE_Web project “Set as StartUp Project”.  Ensure 
that the “default.html” page is “Set as Start Page”.  Running the project will show the maintenance options.

To view the data browser, again ensure the SFE_Web project “Set as StartUp Project”.  Ensure 
that the “browser.html” page is “Set as Start Page”.  
 
