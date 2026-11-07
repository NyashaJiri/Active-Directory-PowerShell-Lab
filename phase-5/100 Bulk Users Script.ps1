# Import Active Directory module
Import-Module ActiveDirectory

# Read the CSV from the same folder as this script
$CSVFilePath = Join-Path $PSScriptRoot "users_spreadsheet.csv"

# Ensure log directory exists
$LogDirectory = "C:\temp\"
if (!(Test-Path -Path $LogDirectory)) {
    New-Item -ItemType Directory -Path $LogDirectory
}

# Define log file
$LogFile = "$LogDirectory\ADUserImportLog.txt"
Write-Output "---- Script Execution Started $(Get-Date) ----" | Out-File -Append $LogFile

# Check if CSV file exists
if (!(Test-Path -Path $CSVFilePath)) {
    Write-Warning "CSV file not found at $CSVFilePath. Please ensure it is in the correct location."
    Write-Output "Error: CSV file not found - $(Get-Date)" | Out-File -Append $LogFile
    exit
}

# Import users from CSV
$ADUsers = @(Import-Csv -Path $CSVFilePath)

# Validate the CSV before creating any OUs or accounts.
$RequiredColumns = @('DisplayName','username','email','UPN','OU','password','company','department','FirstName','LastName')
if (@($ADUsers).Count -eq 0) { throw 'CSV contains no users.' }
foreach ($Column in $RequiredColumns) {
    if ($ADUsers[0].PSObject.Properties.Name -notcontains $Column) { throw "CSV is missing column: $Column" }
    if (@($ADUsers | Where-Object { [string]::IsNullOrWhiteSpace($_.$Column) }).Count -gt 0) { throw "CSV has empty values in: $Column" }
}
if (@($ADUsers | Group-Object username | Where-Object Count -gt 1).Count -gt 0) { throw 'CSV has duplicate usernames.' }
$DomainDN = (Get-ADDomain -ErrorAction Stop).DistinguishedName
foreach ($User in $ADUsers) {
    $ParentDN = ($User.OU -split ',', 2)[1]
    if ($ParentDN -ne $DomainDN) { throw "CSV OU $($User.OU) does not match the connected domain $DomainDN." }
}

# Extract unique OUs from the CSV file
$OUs = $ADUsers | Select-Object -ExpandProperty OU -Unique

# Create OUs if they do not exist
foreach ($OU in $OUs) {
    if (-not (Get-ADOrganizationalUnit -Filter {DistinguishedName -eq $OU})) {
        Write-Host "Creating OU: $OU"
        New-ADOrganizationalUnit -Name ($OU -split ",")[0].Replace("OU=", "") -Path ($OU -split ",", 2)[1] -ProtectedFromAccidentalDeletion $false -ErrorAction Stop
        Write-Output "Created OU: $OU - $(Get-Date)" | Out-File -Append $LogFile
    }
    else {
        Write-Output "OU already exists: $OU - $(Get-Date)" | Out-File -Append $LogFile
    }
}

# Loop through each user in CSV
foreach ($User in $ADUsers) {
    # Assign variables from CSV
    $DisplayName = $User.DisplayName
    $Username = $User.username
    $Password = $User.password
    $Firstname = $User.FirstName
    $Lastname = $User.LastName
    $Email = $User.email
    $UPN = $User.UPN
    $OU = $User.OU
    $Company = $User.company
    $Department = $User.department

    # Validate that the assigned OU exists before adding users
    if (-not (Get-ADOrganizationalUnit -Filter {DistinguishedName -eq $OU})) {
        Write-Warning "Skipping user $Username because OU $OU does not exist."
        Write-Output "Error: OU $OU not found for user $Username - $(Get-Date)" | Out-File -Append $LogFile
        continue
    }

    # Check if user already exists
    if (Get-ADUser -Filter {SamAccountName -eq $Username}) {
        Write-Warning "User $Username already exists in AD."
        Write-Output "User $Username already exists - $(Get-Date)" | Out-File -Append $LogFile
    }
    else {
        try {
            # Create AD user
            New-ADUser `
                -SamAccountName $Username `
                -UserPrincipalName $UPN `
                -Name $DisplayName `
                -GivenName $Firstname `
                -Surname $Lastname `
                -Enabled $True `
                -DisplayName $DisplayName `
                -Path $OU `
                -Company $Company `
                -Department $Department `
                -EmailAddress $Email `
                -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) `
                -ChangePasswordAtLogon $False -ErrorAction Stop

            Write-Output "User $Username created successfully - $(Get-Date)" | Out-File -Append $LogFile
        }
        catch {
            Write-Warning "Failed to create user $Username. Error: $_"
            Write-Output "Error creating user $Username - $_ - $(Get-Date)" | Out-File -Append $LogFile
        }
    }
}

Write-Output "---- Script Execution Completed $(Get-Date) ----" | Out-File -Append $LogFile


