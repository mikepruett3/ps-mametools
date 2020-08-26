function Convert-Chd2Cue {
    <#
    .SYNOPSIS
        Mass convert/extract .chd files to .bin/cue format
    .DESCRIPTION
        Function that will recursivly extract .bin/.cue files from .chd formatted images.
        Requires that MAME DevTools installed, and that the utility chdman.exe is
        available in the current shell path.        
    .LINK
        MAME DevTools - https://www.mamedev.org/release.html
    .EXAMPLE
        > Convert-Chd2Cue
    .NOTES
        Author: Mike Pruett
        Date: August 26th, 2020
    #>
    [CmdletBinding()]
    param ()
    
    begin {
        # Check if chdman.exe is in the path, if not break
        Write-Verbose "Check if chdman.exe is in the path..."
        if ( ! (Get-Command "chdman.exe" -ErrorAction SilentlyContinue ) ) {
            Write-Error "chdman.exe not found in path!`nDownload from https://www.mamedev.org/release.html, and place in path!"
            Break
        }

        # Check for .chd files in the current directory, if not break
        Write-Verbose "Check for .chd files in the current directory..."
        if ( ! ( Get-ChildItem -Recurse "*.chd" ) ) {
            Write-Error "No .chd files found in current directory!"
            Break
        } else {
            Write-Verbose "Building a list of .chd files in the current directory..."
            $CHDs = $(Get-ChildItem *.chd).BaseName
        }
    }
    
    process {
        # Convert every .chd file to a .bin/.cue, using chdman.exe
        foreach ($item in $CHDs) {
            Write-Verbose "Converting $item.chd to .bin/.cue!"
            chdman.exe extractcd --force --input "$item.chd" --output "$item.cue" --outputbin "$item.bin"
        }
    }
    
    end {
        # Cleanup
        Write-Verbose "Cleaning up used Variables..."
        Clear-Variable -Name "item" -ErrorAction SilentlyContinue
        Clear-Variable -Name "CHDs" -ErrorAction SilentlyContinue
    }
}