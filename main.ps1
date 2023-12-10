# Main entry point for the app

# Define a list of choices
$choices = @(
    "Manage subtitles",
    "Manage audio tracks",
    "Merge subtitles and video"
)

# Display choices in a grid view
$userChoice = $choices | Out-GridView -Title "Select an Option" -OutputMode Single

# Check if the user made a selection
if ($userChoice) {
    switch ($userChoice) {
        "Manage subtitles" {
            Write-Host "Launching PowerShell program for managing subtitles..."
            
            $externalProgram = "./subtitles.ps1"

            Start-Process powershell -ArgumentList "-NoExit", "-File", $externalProgram
        }
        "Manage audio tracks" {
            Write-Host "Launching PowerShell program for managing audio tracks..."
            
            $externalProgram = "./audio.ps1"

            Start-Process powershell -ArgumentList "-NoExit", "-File", $externalProgram
        }
        "Merge subtitles and video" {
            Write-Host "Launching PowerShell program for merging subtitles and video..."
            
            $externalProgram = "./merge.ps1"

            Start-Process powershell -ArgumentList "-NoExit", "-File", $externalProgram
        }
        Default {
            Write-Host "Invalid option selected."
        }
    }
} else {
    Write-Host "No option selected."
}
