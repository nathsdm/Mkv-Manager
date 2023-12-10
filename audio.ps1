# Get the parent folder of the parent folder of the script
$parentFolder = Split-Path -Parent -Path (Split-Path -Parent -Path $MyInvocation.MyCommand.Definition)

# Get a list of all folders in the parent folder
$folders = Get-ChildItem -Directory -Path $parentFolder

# Check if there are any folders
if ($folders.Count -gt 0) {
    # Display folders in a grid view
    $selectedFolder = $folders | Out-GridView -Title "Select a folder" -PassThru

    # Check if the user made a selection
    if ($selectedFolder) {
        Write-Host "You selected folder: $($selectedFolder.FullName)"

        Test-Path -Path $selectedFolder.FullName
        $firstmkvfile = Get-ChildItem -Path $selectedFolder.FullName -Filter *.mkv | Select-Object -First 1

        Write-Host "First MKV file in the folder: $($firstmkvfile.FullName)"

        # Check if a file was found
        if ($firstMkvFile) {
            # Construct the command to list audio tracks
            $command = "./mkvmerge -J `"$($firstMkvFile.FullName)`""

            # Execute the command and capture the output
            $result = Invoke-Expression -Command $command

            # Print the parent folder name
            $parentFolderName = $firstMkvFile.Directory.Name

            # Parse the output to find audio tracks
            $audioTracks = $result | ConvertFrom-Json
            $audioTracks = $audioTracks.tracks
            $tracks = @()
            $id_list = @()

            # Display audio tracks and build the $id_list
            foreach ($track in $audioTracks) {
                if ($track.type -eq "audio") {
                    if ($track.properties.track_name) {
                        $tracks += $track.properties.track_name
                        $id_list += $track.id
                    } else {
                        $tracks += $track.properties.language
                        $id_list += $track.id
                    }
                }
            }

            $chosenTrack = $tracks | Out-GridView -Title "Select an audio track" -OutputMode Single
            
            $chosenTrackIndex = $tracks.IndexOf($chosenTrack)
            $chosenTrackId = $id_list[$chosenTrackIndex]

            $mkvFiles = Get-ChildItem -Filter *.mkv -Path $selectedFolder.FullName
            
            foreach ($mkvfile in $mkvFiles) {
                Write-Host "Setting audio track with ID $chosenTrackId as default"
                
                # Find the smallest element in $id_list
                $smallestID = $id_list | Measure-Object -Minimum | Select-Object -ExpandProperty Minimum
                $id = $chosenTrackId - $smallestID + 1

                foreach ($ids in $id_list) {
                    $ids = $ids - $smallestID + 1
                    if ($ids -ne $id) {
                        $defaultCommand = "./mkvpropedit `"$($mkvfile.FullName)`" --edit track:s$ids --set flag-default=0"
                        # Execute the command to set the selected track as default
                        Invoke-Expression -Command $defaultCommand
                    }
                }

                # Construct the command to set the track as default
                $defaultCommand = "./mkvpropedit `"$($mkvfile.FullName)`" --edit track:s$id --set flag-default=1"

                # Execute the command to set the selected track as default
                Invoke-Expression -Command $defaultCommand
            }

            # Success message
            Write-Host "AUdio track with ID $chosenTrackId set as default for all MKV files in the folder: $parentFolderName"
        }
        else {
            Write-Host "No MKV files found in the directory."
        }

    } else {
        Write-Host "No folder selected."
    }
} else {
    Write-Host "No folders found in the current directory."
}
