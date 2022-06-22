$vmname = "Ubuntu"
New-VMSwitch -Name "NAT" -SwitchType Internal
New-NetIPAddress -IPAddress 192.168.200.1 -PrefixLenght 24 -InterfaceAlias "vEthernet (NAT)"
New-NetNat -Name NAT -InternalIPInterfaceAddressPrefix 192.168.200.0/24
Get-VMNetworkAdapter -VMName $VMName | Connect-VMNetworkAdapter -SwitchName "NAT"
