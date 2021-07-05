function check_folder {
        
$Path = 'C:\temp\hive\FolderA\SubFolder1'
#$Path = 'C:\Windows\System32\test'
$message = (Test-Path $path) #? "Path exists" : "Path not found"


if (!$message) {
        Try {
        New-Item -path $Path -ItemType Directory -ErrorAction Stop
        }
        Catch {
                "An error occurred."
                #$log_path = C:\Check_path_script\Check_path_log.log
                $_.Exception.Message #| Out-File $log_path -Append
                #Break
        }
        (Test-Path $Path) ? $true : $false
}
elseif ($message) {
        $acl = ((Get-Acl $Path).Access)
        foreach ($rule in $acl){
        if ($rule.IdentityReference -match $env:UserName){
        if ($rule.FileSystemRights.ToString() -eq "ReadAndExecute, Synchronize") {$AccessType = "Только Чтение"}
                elseif ($rule.FileSystemRights.ToString() -eq "Modify, Synchronize") {$AccessType = "Чтение и Запись"}
                        elseif ($rule.FileSystemRights.ToString() -eq "FullControl") {$AccessType = "Полный доступ"}
                                else {$AccessType = "Custom"}
}
}
        $access_list = $env:UserName + " "+ $AccessType
        $access_list

        return $true
        
}
else {
        return $false
}
}

check_folder