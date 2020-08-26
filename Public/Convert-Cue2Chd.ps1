function Convert-Cue2Chd {
    <#
    .SYNOPSIS
        Mass convert .bin/cue files to .chd format
    .DESCRIPTION
        Function that will recursivly convert .chd files from .bin/.cue formatted images.
        Requires that MAME DevTools installed, and that the utility chdman.exe is
        available in the current shell path.        
    .LINK
        MAME DevTools - https://www.mamedev.org/release.html
    .EXAMPLE
        > Convert-Cue2Chd
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

        # Check for .cue files in the current directory, if not break
        Write-Verbose "Check for .cue files in the current directory..."
        if ( ! ( Get-ChildItem -Recurse "*.cue" ) ) {
            Write-Error "No .cue files found in current directory!"
            Break
        } else {
            Write-Verbose "Building a list of .cue files in the current directory..."
            $CUEs = $(Get-ChildItem *.cue).BaseName
        }
    }
    
    process {
        # Convert every .bin/.cue file to a .chd, using chdman.exe
        foreach ($item in $CUEs) {
            Write-Verbose "Converting $item.cue to .chd!"
            chdman.exe createcd --force --input "$item.cue" --output "$item.chd"
        }
    }
    
    end {
        # Cleanup
        Write-Verbose "Cleaning up used Variables..."
        Clear-Variable -Name "item" -ErrorAction SilentlyContinue
        Clear-Variable -Name "CUEs" -ErrorAction SilentlyContinue
    }
}