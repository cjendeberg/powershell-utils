<#
 .Description
  Uses .NET function to convert string to base64 encoding

 .Example
   #Convert string to base64 encoded string
   "My name is John" | ConvertTo-Base64
#>
function ConvertTo-Base64 {
param(
  [parameter(
    Mandatory         = $true,
    ValueFromPipeline = $true)]
  [string]$InputString
)
[System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($InputString))
}


<#
 .Description
  Uses .NET function to convert from base64 encoded string to original string

 .Example   
   "WQBvAHUAIABzAHUAYwBjAGUAZQBkAGUAZAAhAA==" | ConvertFrom-Base64

#>
function ConvertFrom-Base64 {
param(
  [parameter(
    Mandatory         = $true,
    ValueFromPipeline = $true)]  
  [string]$InputString
)

$numChars = $InputString.length
while($numChars++ % 4) {
  $InputString += '='
}
[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($InputString))
}


<#
 .Description
  Convert Java Web Token to object

 .Example   
   ConvertFrom-Jwt -FilePath .\idtoken.jwt

   Get-Content .\idtoken.jwt | ConvertFrom-Jvt

#>

function ConvertFrom-Jwt {
param(
  [parameter(
    ValueFromPipeline = $true)]  
  [string]$jwt,
  [string]$FilePath
)

function getPartAsObject($inputString) {
  $paddedInputString = $inputString
  $numChars = $inputString.length
  while($numChars++ % 4) {
    $paddedInputString += '='
  }
  [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($paddedInputString)) | ConvertFrom-Json
}

function addPadding($inputString) {
  $paddedInputString = $inputString
  $numChars = $inputString.length
  while($numChars++ % 4) {
    $paddedInputString += '='
  }
  $paddedInputString
}


if($FilePath.Length -gt 0){
  $jwt = Get-Content $FilePath
}

$paddedBase64Header = addPadding($jwt.Split('.')[0].Trim())
$headerObject = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($paddedBase64Header)) | ConvertFrom-Json
"---"
$paddedBase64Payload = addPadding($jwt.Split('.')[1].Trim())
$payloadJson = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($paddedBase64Payload))
$payloadObject = $payloadJson | ConvertFrom-Json

@{Header = $headerObject; Payload = $payloadObject}
}

<#
 .Description
  Remove Github credentials from Windows Credential Manager store

 .Example   
  Remove-GithubCredentials

#>
function Remove-GithubCredentials {
$creds = Get-StoredCredential -AsCredentialObject
foreach($cred in $creds) {
  if($cred.TargetName.contains('github.com')) {
    Remove-StoredCredential -Target $cred.TargetName
  }
}
}
