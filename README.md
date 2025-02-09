# **SMB-Scanner**

A lightweight, PowerShell-based SMB enumeration and data-gathering tool for red team engagements and penetration testing. This tool is designed to work natively on Windows without the need for external dependencies like Python or Linux-based utilities.

---

## Features

- Enumerates SMB shares on target hosts.
- Tests for read access to identified shares.
- Searches for sensitive files within accessible shares based on custom keywords.
- Operates independently of third-party tools like `smbclient`.
- Optional Nmap integration for network discovery.

---

## Why PowerShell?

PowerShell is an excellent choice for environments where traditional penetration testing tools like Python, Linux utilities, or Nmap are unavailable or restricted. This script:
- Runs natively on Windows systems.
- Requires no external libraries.
- Blends seamlessly with legitimate administrative activities.

---

## Usage

### **1. SMB Scanner Script (`smb_scanner.ps1`)**

This is the main script that handles SMB enumeration, share access testing, and file searches. 

#### Prerequisites:
- A text file containing the list of target IPs or hostnames (e.g., `hosts.txt`).

#### How to Use:
1. Clone the repository:
   ```bash
   git clone https://github.com/YourUsername/SMB-Scanner.git
   cd SMBScanner/scripts
   ```
2. Open PowerShell and run:
   ```powershell
   .\smb_scanner.ps1 -TargetList .\hosts.txt -OutputPath .\results\
   ```
   Replace:
   - `hosts.txt` with the path to your list of target IPs or hostnames.
   - `.\results\` with the desired output folder for the results.

#### Parameters:
| Parameter      | Description                                             |
|----------------|---------------------------------------------------------|
| `-TargetList`  | Path to the text file containing target IPs/hostnames.  |
| `-OutputPath`  | Path to save the results (default: current directory).  |
| `-Keywords`    | Comma-separated list of file keywords to search for.    |

---

### **2. Optional Nmap Discovery Script (`nmap_discovery.ps1`)**

This script performs an Nmap scan to identify hosts with SMB (port 445) open and generates a list of target IPs.

#### Prerequisites:
- [Nmap](https://nmap.org) installed and added to your system's PATH.

#### How to Use:
1. Run the script with administrative privileges:
   ```powershell
   .\nmap_smb_scan.ps1 -NetworkRange 192.168.1.0/24 -OutputFile .\hosts.txt
   ```
   Replace:
   - `192.168.1.0/24` with your target network range.
   - `hosts.txt` with the desired name for the output file.

#### Parameters:
| Parameter         | Description                                          |
|-------------------|------------------------------------------------------|
| `-NetworkRange`   | Target network range for Nmap (e.g., 192.168.1.0/24).|
| `-OutputFile`     | Path to save the list of discovered hosts.           |

---

## Output

The scripts generate the following output files:

- **`allowed.txt`**: List of hosts with accessible SMB shares.
- **`readable_shares.txt`**: Details of shares with confirmed read access.
- **`interesting_files.txt`**: List of sensitive files found during the scan.

---

## Example Scenario

1. Run the Nmap discovery script:
   ```powershell
   .\nmap_smb_scan.ps1 -NetworkRange 10.10.0.0/16 -OutputFile .\hosts.txt
   ```

2. Use the SMB scanner to enumerate shares and search for sensitive files:
   ```powershell
   .\smb_scanner.ps1 -TargetList .\hosts.txt -Keywords "password,credentials" -OutputPath .\results\
   ```

3. Analyze the output files for misconfigurations, credentials, and sensitive data.

---

## Screenshots

Here are some real-world examples of the script in action (redacted for privacy):

1. **SMB Shares with Read Access**  
   Shares with overly permissive configurations exposed sensitive files:
   ![Shares with Read Access](https://github.com/KomodoSec-Research/SMBScanner/blob/main/images/enum.png)

2. **Sensitive Files Discovered**  
   Files containing plaintext passwords, certificates, and SCADA data:
   ![Sensitive Files](https://github.com/KomodoSec-Research/SMBScanner/blob/main/images/passes.png)

---

## Disclaimer

This tool is intended for authorized security testing and educational purposes only. Unauthorized use is prohibited. The authors are not responsible for any misuse or damage caused by this tool.

---

## Contributing

Feel free to open issues or submit pull requests to improve the tool. Contributions are welcome!

---

## License

This project is licensed under the [MIT License](LICENSE).

---

## Contact

Have questions or feedback? Reach out to me at [KomodoGal](https://github.com/KomodoGal).

---
