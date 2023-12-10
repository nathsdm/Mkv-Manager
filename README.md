# MKV Manager

MKV Manager is a PowerShell script that allows you to manage MKV files by setting default tracks for subtitles and audio, as well as merging MKV/MP4 files with subtitle files. It utilizes the `mkvpropedit` and `mkvmerge` tools.

## Prerequisites

Before using MKV Manager, ensure that you have power shell installed on your system:

- [PowerShell](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.1)

## Usage

1. Clone the repository to your local machine.
2. Open a PowerShell terminal and navigate to the directory where the script is located.
3. Run the script using the following command:

   ```powershell
   ./main.ps1
   ```

4. Follow the on-screen prompts to manage your MKV files.
:warning: **Note:** The script will manage all MKV files in the directory where the parent folder is located.

## Features

### Set Default Tracks

The script allows you to set default tracks for subtitles and audio in MKV files. Simply select the MKV file and choose the desired default tracks.

### Merge MKV/MP4 with Subtitle

You can also merge MKV/MP4 files with subtitle files using the script. Select the main video file and the subtitle file, and the script will merge them into a single MKV file.
