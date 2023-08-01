# powershell-utils
Utility powershell scripts

## Installation
Check the current Powershell module paths
```
$env:PSModulePath.split(';')
```
There should be a module path that points to your home directory, something like
```
C:\Users\<USERNAME>\Documents\WindowsPowerShell\Modules
````
Checkout this repository in that Modules directory so that the file path
```
C:\Users\<USERNAME>\Documents\WindowsPowerShell\Modules\powershell-utils\powershell-utils.psm1
````
will exist.
Test correct installation by running the command
```
help convertfrom-base64
```

## ConvertFrom-Base64
Decode a base64 encoded string

## ConvertTo-Base64
Encode a string to base64

## ConvertFrom-Jwt
Decode a Jwt token

## Remove-GithubCredentials
If having multiple clashing Github accounts on Windows, this is a way to remove existing local Github credentials and to force the user to renew the credentials for a specific Github account.
