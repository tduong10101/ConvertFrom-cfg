# ConvertFrom-cfg

Powershell function to convert .cfg file to powershell object

Script: ConvertFrom-Cfg.psm1

Parameter: cfg file content

Description:  Convert cfg file content to psobject

Author: Terry D

Version 1 - Inital version

Example 1
--------------
$cfgobj = get-content "C:\test.cfg" | ConvertFrom-Cfg

Example 2
--------------
$cfgtxt = get-content "C:\test.cfg"
$cfgobj = ConvertFrom-Cfg -cfg $cfgtxt
