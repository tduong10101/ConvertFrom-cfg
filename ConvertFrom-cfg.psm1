#
# Script: ConvertFrom-Cfg.psm1
# Parameter: cfg file content
# Description:  Convert cfg file content to psobject
#
# Author: Terry D
# Version 1 - Inital version
#
# Example 1
# --------------
# $cfgobj = get-content "C:\test.cfg" | ConvertFrom-Cfg
# 
# Example 2
# --------------
# $cfgtxt = get-content "C:\test.cfg"
# $cfgobj = ConvertFrom-Cfg -cfg $cfgtxt
#
#################################################################### 
function ConvertFrom-Cfg{
    param(
        [Parameter(Mandatory=$True,Position=1,ValueFromPipeline=$true)]
        [Object[]] $cfg
    )
    process { $cfg = $cfg -replace ".*#+.*"
        $cfg = $cfg -replace "^define[\w|\W]*{$", "{"
        $cfg = $cfg |? {![string]::IsNullOrEmpty($_)}
        $returnobj=@()
        foreach ($line in $cfg){
            if ($line -match "^{$"){        
                $object= New-Object psobject
            }
            elseif ($line -match "^}$"){
                $returnobj+=$object
            }else{
                $value = $line.trim() -split "\s{2,}"
                $object| Add-Member NoteProperty $value[0] $value[-1]
            }
           
        }
        return @($returnobj)
    }
}