# nmap_smb_scan.ps1
param (
    [string]$TargetRange = "192.168.1.0/24",  # Target range for the Nmap scan
    [string]$OutputFile = "hosts.txt"        # Output file to save the list of IPs
)

Write-Host "Scanning $TargetRange for open SMB ports (port 445)..."

# Run Nmap to find hosts with SMB (port 445) open
$nmapOutput = nmap -p 445 --open -oG - $TargetRange

# Parse Nmap output to extract IPs with port 445 open
$hosts = $nmapOutput -split "`n" | ForEach-Object {
    if ($_ -match "Host: (\S+)\s") {
        $matches[1]
    }
}

# Save the discovered hosts to the output file
$hosts | Set-Content $OutputFile

Write-Host "Discovered hosts with SMB enabled saved to $OutputFile"
