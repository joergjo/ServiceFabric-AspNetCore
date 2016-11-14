# ServiceFabric-AspNetCore
Sample solution that demonstrates using [ASP.NET Core](https://www.asp.net/core) in 
[Azure Service Fabric](https://azure.microsoft.com/en-us/services/service-fabric/).

+ SFApp: A Service Fabric application that contains both SimpleWebApp and WebListenerWebApp. 

+ SimpleWebApp: Shows an ASP.NET MVC Core app hosted in Kestrel using either HTTP or HTTPS running in Service Fabric. 
Please make sure to specifiy your certificate's thumbprint in the SimpleWebApp's `Settings.xml` if you want to use HTTPS. 
You can use any self-signed or valid certificate, but make sure to store it in your machine's `LocalMachine\My` store. 
If you have IIS Express installed, you can use its certificate instead of creating your own. 

+ WebListenerWebApp: Shows an ASP.NET Core app hosted in WebListener using HTTPS running in Service Fabric. Note the various user
and security settings in the Application Manifest to configure [HTTP.SYS](https://www.iis.net/learn/get-started/introduction-to-iis/introduction-to-iis-architecture#Hypertext) in Windows 
and make sure Service Fabric sets the correct ACLs for `NETWORK SERVICE` to access the certificate's private key.

+ SFDevTest: An Azure Resource project for a secure Service Fabric cluster ARM template
of a three node dev/test cluster with [Service Fabric Reverse Proxy](https://azure.microsoft.com/en-us/documentation/articles/service-fabric-reverseproxy/) 
enabled for HTTP on port 80, and an non-proxied application port 8082. The project also includes PowerShell scripts to create and deploy
self-signed certificates for testing.
