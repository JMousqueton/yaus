# Yey Another Upgrade Script 

This Bash script automates essential system maintenance tasks on Debian and Ubuntu-based Linux systems. It handles package updates, upgrades, and system clean-up processes to ensure the system is up-to-date and running efficiently.

## Features

- **Package Updates**: Automatically updates the list of packages and their versions.
- **Package Upgrades**: Upgrades all out-of-date packages to the latest versions.
- **System Clean-Up**: Removes unused packages and cleans up old package versions.
- **Reboot Handling**: Checks if a reboot is required after updates and initiates it if necessary.
- **Logging**: Maintains a comprehensive log of all maintenance activities, including a timestamp for each entry.
- **Debug Mode**: Offers an optional verbose output mode for debugging purposes.
- **Quiet Mode**: Provides an option to suppress console output, logging messages only.

## Requirements

- **Root Access**: The script must be run with root privileges to perform system maintenance tasks.
- **Debian or Ubuntu-based System**: Designed specifically for Debian and Ubuntu distributions.

## Installation

1. Download the script to your system.
2. Ensure the script is executable:
   ```bash
   chmod +x upgrade.sh
   ```

3. Move the script to a location that's included in your system's `PATH` to allow easy execution from anywhere. A common location for custom scripts is `/usr/local/bin`:

  ```bash
  sudo mv upgrade.sh /usr/local/bin/
  ```

## Usage

Execute the script from the terminal with root privileges:

```bash
sudo upgrade.sh
```

### Configuration Options

Customize the behavior of the script by modifying the following variables within the script file:

- **`LOG_FILE`**: Set the path where you want the log messages to be saved. The default path is `/var/log/system_maintenance.log`.
  
  Example: `LOG_FILE="/path/to/your/logfile.log"`

- **`DEBUG`**: Enable verbose output for debugging purposes by setting this variable to `true`. By default, it is set to `false`.

  Example: `DEBUG=true`

- **`QUIET`**: Suppress all output to the console, making all log entries go directly to the log file, by setting this variable to `true`. By default, it is set to `false`.

  Example: `QUIET=true`

To apply these configurations, edit the script with your preferred text editor and modify the values of these variables as needed.

## Troubleshooting

If you encounter issues while using the script, consider the following solutions:

- **Execution Permission**: Ensure the script has the necessary execution permissions by running:

  ```bash
  sudo chmod +x /usr/local/bin/upgrade.sh
  ```
  
- **Update or Upgrade Problems**: If you're experiencing issues with updating or upgrading packages, first ensure you have a stable internet connection. Additionally, check your system's package repository settings to ensure they are correct and accessible. Common issues include network problems, incorrect repository URLs in the `/etc/apt/sources.list` file, or repository servers being temporarily unavailable.

  If problems persist, you can manually run `sudo apt-get update` and `sudo apt-get upgrade` in the terminal to see if any specific errors are reported, which can help in diagnosing and resolving the issue.

## Contributing

We welcome contributions from the community! If you have improvements or fixes, please fork the repository, make your changes, and submit a pull request. For bug reports or feature requests, don't hesitate to open an issue on the GitHub project page. Your insights and contributions are valuable to the continuous improvement of this script.

## License

This script is made available under the MIT License. This license permits free use, modification, and distribution, provided that the original authorship is credited. Please refer to the [`LICENSE`](LICENSE) file in the repository for the full legal text.



