# Main entry point for the app

function Show-Menu {
    param (
        [string[]]$MenuItems
    )

    $selectedItem = 0

    while ($true) {
        Clear-Host

        # Display menu items
        for ($i = 0; $i -lt $MenuItems.Count; $i++) {
            if ($i -eq $selectedItem) {
                Write-Host ("[x] " + $MenuItems[$i]) -ForegroundColor Green
            } else {
                Write-Host ("[ ] " + $MenuItems[$i]) -ForegroundColor Gray
            }
        }

        # Get user input
        $key = $Host.UI.RawUI.ReadKey("AllowCtrlC,IncludeKeyUp,NoEcho").VirtualKeyCode

        # Process user input
        switch ($key) {
            13 { # Enter key
                return $MenuItems[$selectedItem]
            }
            38 { # Up arrow
                $selectedItem = ($selectedItem - 1 + $MenuItems.Count) % $MenuItems.Count
            }
            40 { # Down arrow
                $selectedItem = ($selectedItem + 1) % $MenuItems.Count
            }
        }
    }
}

$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp")

# Define a list of choices
$choices = @(
    "Manage subtitles",
    "Manage audio tracks",
    "Merge subtitles and video"
)

# Display choices in a grid view
$userChoice = Show-Menu -MenuItems $choices

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
