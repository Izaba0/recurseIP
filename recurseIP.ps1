Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
$directoryPath = "C:\Users\" # add path to directory 
$ipPattern = '\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b'
 # '([0-9]{1,3}\.){3}[0-9]{1,3}' is a much simpler regex but does not take into account the limit of 255

Get-ChildItem -Path $directoryPath -Recurse -File | ForEach-Object {
    $file = $_.FullName
    Write-Host "Searching in file: $file"

    $content = Get-Content -Path $file -Raw -ErrorAction SilentlyContinue

    if ($null -ne $content) {
        $matches = [regex]::Matches($content, $ipPattern)
        
        foreach ($match in $matches) {
            Write-Host "Found IP: $($match.Value) in file: $file"
        }
    }
}