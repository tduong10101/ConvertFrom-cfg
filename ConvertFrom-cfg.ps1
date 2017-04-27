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
param(
    [Parameter(Mandatory=$True,Position=1,ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true)]
    [string] $cfg
)

process {
    $cfg = $cfg -replace ".*#+.*"
    $cfg = $cfg -replace "^define[\w|\W]*{", "{"
    $cfg = $cfg |? {![string]::IsNullOrEmpty($_)}
    $returnobj = @()
    foreach ($line in $cfg){
        if ($line -match "{"){        
            $object= New-Object psobject |
                Add-Member NoteProperty "contactgroup_name" $null -PassThru | 
                Add-Member NoteProperty "alias" $null -PassThru |
                Add-Member NoteProperty "members" $null -PassThru |
                Add-Member NoteProperty "contactgroup_members" $null -PassThru 
            continue
        }
        elseif ($line -match "}"){
            #$psobject2 = $psobject2+$object
            $returnobj+=$object
            continue
        }
        $splitvalue = $line.trim() -split "\s{2,}"
        $object."$($splitvalue[0])" = $splitvalue[-1]
    }

    return $returnobj|fl
}

