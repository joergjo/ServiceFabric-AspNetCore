# servicefabric-aspnetcore
Sample solution that demonstrates using [ASP.NET Core](https://www.asp.net/core) in 
[Azure Service Fabric](https://azure.microsoft.com/en-us/services/service-fabric/).

+ SimpleWebApp: Shows an ASP.NET MVC Core app hosted in Kestrel using HTTPS running in Service Fabric. 
Please make sure to specifiy your certificate's thumbprint in the SimpleWebApp's `Settings.xml`. You can use any 
self-signed or valid certificate, but make sure to store it in your machine's `LocalMachine\My` store. 
If you have IIS Express installed, you can use its certificate instead of creating your own.

+ WebListenerWebApp: Shows an ASP.NET Core app hosted in WebListener using HTTPS running in Service Fabric. Unlike
the Kestrel sample, WebListener requires an `<EndpointPolicy />` and an `<EndpointCertificate />` in the Application Manifest 
to configure [HTTP.SYS](https://www.iis.net/learn/get-started/introduction-to-iis/introduction-to-iis-architecture#Hypertext) in Windows.

***

In order to create your own self-signed certificate(s), follow these steps (this applies to both Kestrel and WebListener):

1. Launch PowerShell as local administrator, and execute  
 `New-SelfSignedCertificate -DnsName localhost -FriendlyName "Service Fabric Development Certificate" -CertStoreLocation "Cert:\LocalMachine\My\"`

2. Grant `NETWORK SERVICE` (the system account that Service Fabric uses for its "OneBox" dev cluster) access to your certificate's
 private key. On Windows 8/Windows Server 2012 or newer, you can run `certlm.msc` to get access to the machine's certificate store.
