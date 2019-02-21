#  Use with MATLAB Production Server and MATLAB Compiler

When using the package with MATLAB Production Server™ or MATLAB Compiler™ one normally uses the respective and superficially similar Compiler GUIs. There are three points to notes when deploying applications in this way:    
1. Paths are normally configured using the *startup.m* script in the */Software/MATLAB/* directory. When deploying an application that calls this package the paths are not configured in that way and the startup script will have no effect. No end user action is required in this regard.    
2. A .jar file can be found in */Software/MATLAB/lib/jar/*, this file includes the required functionality from the AWS™ Java SDK. The automatic dependency analysis will not pick this up and it must be added manually.
3. For testing purposes adding a credentials JSON file manually as per the jar is a simple way to include credentials in a way that will be easily by the deployed code. While the JSON file will be encrypted it will be included in the Compiler output which may be shared. This may well violate local security polices and best practices. One should consider other approaches to providing credentials to deployed applications. One should also consider the compiling and deployment process and avoid a scenario which involves credentials being included in source code repositories where they may be exposed.


## Altering a Runtime

The following installation procedure is not recommended but in certain circumstances may be preferable to the above approach of integrating the code into the .ctf file. MATLAB Production Server (MPS) has the capability to work with a variety of MATLAB® Runtime installations at the same time. Thus when installing this package one does not install it against the central MPS files but rather against the Runtime or Runtimes that will be called by the functions using the package.

When installing interactively select *MATLAB Production Server (Runtime)* as indicated. When using the non-interactive mode e.g.
```
$ sudo install.sh -s agreeToLicense -a ./AWS-release-0.2.1.zip -m /usr/local/MATLAB/MATLAB_Runtime/v92 -p mps-mcr -c /home/username/Downloads/UnlimitedJCEPolicyJDK7.zip
```
use *mps-mcr* as the product *-p* argument.


--------------

[//]: #  (Copyright 2018 The MathWorks, Inc.)