# servicefabric-aspnetcore
Sample solution that demonstrates using [ASP.NET Core](https://www.asp.net/core) in 
[Azure Service Fabric](https://azure.microsoft.com/en-us/services/service-fabric/).

+ SimpleWebApp: Shows a basic ASP.NET MVC Core app hosted in Kestrel using HTTPS instead of HTTP running in Service Fabric. 
Please make sure to specifiy your certificate's thumbprint in the SimpleWebApp's `Settings.xml`. You can use any 
self-signed or valid certificate, but make sure to store it in your machine's `LocalMachine\My` store. 
If you have IIS Express installed, you can use its certificate instead of creating your own.
