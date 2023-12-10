# Select the mkv and mp4 files in the folder
$mkvFiles = Get-ChildItem -Filter *.mkv
$mp4Files = Get-ChildItem -Filter *.mp4
$videoFiles = $mkvFiles + $mp4Files
$selectedMkvFile = $videoFiles | Out-GridView -Title "Select an MKV file" -OutputMode Single

if ($selectedMkvFile) {
    # Select the srt file among the list of srt files in the folder
    $srtFiles = Get-ChildItem -Filter *.srt
    $selectedSrtFile = $srtFiles | Out-GridView -Title "Select an SRT file" -OutputMode Single
}

# Construct the command to merge the selected files
$command = "./mkvmerge `"$($selectedMkvFile.FullName)`" `"$($selectedSrtFile.FullName)`" -o `"$($selectedMkvFile.DirectoryName)\output\$($selectedMkvFile.BaseName).mkv`""

# Execute the command to merge the selected files
Invoke-Expression -Command $command

# Success message
Write-Host "Merged the SRT file with the MKV file successfully."