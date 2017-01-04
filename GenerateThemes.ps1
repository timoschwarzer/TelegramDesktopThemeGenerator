$ThemeBaseName="MyThemeName-"
$Configs = @{
    blue = @{
        accent_color = "#abc123"
        accent_color2 = "#456788"
        # additional_variable = "#abc"
    }
    red = @{
        accent_color = "#def456"
        accent_color2 = "#ffffff"
        # additional_variable = "#abc"
    }
}

# Do the stuff
New-Item -ItemType Directory -Force -Path Theme
Copy-Item tiled.png Theme\tiled.png

$Configs.Keys | % {
    $Config = $Configs.Item($_)
    $BaseContent = Get-Content base.tdesktop-theme
    $Config.Keys | % {
        $Value = $Config.Item($_)
        $BaseContent = $BaseContent -replace "%${_}%", $Value
    }
    $BaseContent | Set-Content Theme\colors.tdesktop-theme
    Compress-Archive -Path ./Theme/* -DestinationPath ${ThemeBaseName}$_.tdesktop-theme
}

# Cleanup...
Remove-Item -Recurse -Force Theme
pause
