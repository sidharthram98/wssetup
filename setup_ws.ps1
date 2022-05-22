#Requirements
# Windows Server Installed
# Nvidia Drivers Installed

#Import Modules
Import-Module Hyper-V
$VMName = "Ubuntu"

#Enable HyperV
Write-Output "Validating if Hyper-V is installed on host..."
if(((Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V).State).Equals("Disable")) {
    Write-Output "Enabling Hyper-V..."
    Write-Output "This will restart your host."
    Install-WindowsFeature -Name Hyper-V -IncludeManagementTools
}
else
{
    Write-Output "Hyper-V role detected."
}

#Check vSwitch
$netadapter = Get-NetAdapter -physical | where status -eq "up"
Write-Host "Creating Virtual Switch using" $netadapter.Name "Adapter"
New-VMSwitch -Name "External Network" -NetAdapterName $netadapter.Name -AllowManagementOS:$true

#Download VHD
New-Item -Path "C:\VMs" -ItemType Directory
Write-Output "C:\VMs Folder created."
Write-Output "Downloading Ubuntu VHD..."
Invoke-WebRequest -uri "https://aniccaautomation.blob.core.windows.net/vhd/UbuntuTemplate.vhdx" -OutFile "Ubuntu.vhdx"


#Create VM
New-VM -Name Ubuntu -MemoryStartupBytes 16GB -VHDPath "C:\VHD\Ubuntu.vhdx"
Add-VMHardDiskDrive -VMName $VMName -Path "C:\VMs\Ubuntu.vhdx"


#Query Device Location
$pnpdevs = Get-PnpDevice -PresentOnly
$pcidevs = $pnpdevs | Where-Object {$_.InstanceId -like "PCI*"}

foreach ($pcidev in $pcidevs) {
    if($pcidev.FriendlyName.equals("NVIDIA Tesla T4")) {
        Write-Host -ForegroundColor White -BackgroundColor Black $pcidev.FriendlyName
        $locationpath = ($pcidev | get-pnpdeviceproperty DEVPKEY_Device_LocationPaths).data[0]
        Write-Host "Disabling GPU from Host..."
        Get-PnpDevice -FriendlyName $pcidev.FriendlyName | Disable-PnpDevice
    }
    else
    {
        continue
    }
}


#Plan for DDA Attachment Disable GPU
Set-VM -Name $VMName -AutomaticStopAction TurnOff
Set-VM -GuestControlledCacheTypes $true -VMName $VMName
Set-VM -LowMemoryMappedIoSpace 3Gb -VMName $VMName
Set-VM -HighMemoryMappedIoSpace 16280Mb -VMName $VMName
Write-Host "Dismounting GPU from Host..."
Dismount-VMHostAssignableDevice -force -LocationPath $locationpath

#Mount GPU to VM
Write-Host "Mountin GPU to VM"
Add-VMAssignableDevice -LocationPath $locationPath -VMName $VMName

#Start VM
