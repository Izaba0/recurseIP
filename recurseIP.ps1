Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
$directoryPath = "C:\Users\" # add path to directory 
$ipPattern = '([0-9]{1,3}\.){3}[0-9]{1,3}'

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