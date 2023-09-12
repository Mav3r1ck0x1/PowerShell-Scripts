# Get the current date and time
$currentTime = Get-Date

# Calculate the date and time 168 hours ago
$oneSixtyEightHoursAgo = $currentTime.AddHours(-168)

# Define the output file path
$outputFilePath = "C:\updateDump.txt" # Replace with your desired file path

# Get a list of installed updates and filter them based on the installation date
$updates = Get-HotFix | Where-Object { $_.InstalledOn -gt $oneSixtyEightHoursAgo }

# Create a StringBuilder to store the output
$output = New-Object System.Text.StringBuilder

# Add the updates to the output
if ($updates.Count -gt 0) {
    $output.AppendLine("Installed Microsoft Updates within the past 168 hours:")
    $updates | ForEach-Object {
        $updateInfo = "KB$($_.HotFixID) - $($_.Description) - Installed on $($_.InstalledOn)"
        $output.AppendLine($updateInfo)
    }
} else {
    $output.AppendLine("No Microsoft Updates were installed within the past 168 hours.")
}

# Write the output to the file
$output.ToString() | Out-File -FilePath $outputFilePath

# Display a message indicating where the output file was saved
Write-Host "Script output has been saved to $outputFilePath"
