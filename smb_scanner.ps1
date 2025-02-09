# smb_scanner.ps1
param (
    [string]$InputFile = "hosts.txt",          # File containing list of IPs/hostnames
    [string]$OutputFile = "results.txt",       # Output file to save results
    [string[]]$Keywords = @("password", "config", "cert"), # Keywords to search for in files
    [string[]]$Extensions = @(".pem", ".txt", ".xlsx")     # Extensions to search for in files
)

# Import list of hosts
$hosts = Get-Content $InputFile

# Results collection
$results = @()

# Iterate through hosts
foreach ($host in $hosts) {
    Write-Host "Checking shares on $host..."
    
    # Enumerate SMB shares
    $shares = Invoke-Command -ScriptBlock {
        Get-SmbShare -CimSession $using:host
    } -ErrorAction SilentlyContinue

    if ($shares) {
        foreach ($share in $shares) {
            $shareName = $share.Name
            Write-Host "Found share: \\$host\$shareName"

            # Check for read access
            $accessCheck = Test-Path "\\$host\$shareName"

            if ($accessCheck) {
                Write-Host "Read access confirmed on \\$host\$shareName"
                $results += "\\$host\$shareName"

                # Search for sensitive files
                Get-ChildItem -Path "\\$host\$shareName" -Recurse -ErrorAction SilentlyContinue |
                    Where-Object { $Extensions -contains $_.Extension -or $Keywords -some { $_ -match $_ } } |
                    ForEach-Object {
                        $file = $_.FullName
                        Write-Host "Found file: $file"
                        $results += $file
                    }
            } else {
                Write-Host "No read access on \\$host\$shareName"
            }
        }
    } else {
        Write-Host "No shares found on $host"
    }
}

# Save results to file
$results | Set-Content $OutputFile

Write-Host "Scan complete. Results saved to $OutputFile"
