# Basic Framework Overview

This project is a simple framework that provides some common utilities to facilitate shell script development. It includes a main execution script along with utility functions for tasks such as logging and file operations.

## File Structure

- **fire.sh**:  
  The main script that:
  - Validates that it is running under Bash and has the necessary execute permissions.
  - Changes the working directory to the script’s location.
  - Creates a `logs` directory if it doesn’t exist.
  - Executes within a subshell to ensure environment isolation.
  - Sources `scripts/utils.sh`, which offers a set of common utility functions.
  - Sources `scripts/run.sh` for additional runtime logic (customize as needed).
  - Logs all output to a dated log file in the `logs` directory.
  - Automatically cleans up log files older than 30 days.

- **scripts/utils.sh**:  
  Provides a collection of common utility functions, including:
  - Logging functions: `info()`, `warn()`, and `error()` for different log levels.
  - A helper function `cp_if_diff()` that copies a file only if its SHA256 checksum differs from the destination file.
  
  *Note*: These utilities are meant as a basic toolkit for common operations and can be extended or modified to suit your needs.

- **scripts/run.sh**:  
  Intended for executing additional commands or custom logic. It is currently empty and ready to be customized.

## Prerequisites

- **Bash**: Ensure you are using Bash to run these scripts.
- **Execute Permission**: The scripts, especially `fire.sh`, must have execute permissions. You can set this with:
  ```bash
  chmod +x fire.sh
  ```
- **Log Directory**: The script will automatically create a `logs` directory in its directory if it does not exist.

## Usage

1. **Navigate** to the project directory where `fire.sh` is located.
2. **Run the script**:
   ```bash
   ./fire.sh
   ```
3. **Review Logs**: All output is recorded in the `logs/` directory with filenames in the format `YYYY-MM-DD.log`.

## Customization

- **Extending the Framework**:  
  This framework provides a basic structure and a set of common utilities. You can extend it by:
  - Adding new utility functions in `scripts/utils.sh`.
  - Implementing additional logic in `scripts/run.sh`.
- **Utility Functions**:  
  The functions provided in `scripts/utils.sh` serve as a starting point for common operations. Customize them as needed.

## Log Maintenance

The `fire.sh` script automatically cleans up log files older than 30 days to manage disk space.