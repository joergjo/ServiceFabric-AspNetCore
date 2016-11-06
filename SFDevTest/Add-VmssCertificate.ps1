# Based on https://gist.github.com/andersosthus/c483eaf8630219c789de
#
# Use this script to add a certificate stored in KeyVault to a Service Fabric Cluster's
# Virtual Machine Scale Set (or any stand-alone VMSS).  
# This script requires an existing KeyVault that is EnabledForDeployment.  
# The vault must be in the same region as the cluster.
# 
# To create a new vault and set the EnabledForDeployment property run:
#
# New-AzureRmResourceGroup -Name KeyVaults -Location WestUS
# New-AzureRmKeyVault -VaultName $KeyVaultName -ResourceGroupName KeyVaults -Location WestUS -EnabledForDeployment
#

# Add a certificate to a Virtual Machine Scale Set.
#
# Note that the code in line 36 assumes the VMSS is using exactly one Key Vault
# to store secrets (hence $Vmss.VirtualMachineProfile.OsProfile.Secrets[0]).

Param
(
    [Parameter(Mandatory = $true)]
    [string]
    $SourceVault,

    [Parameter(Mandatory = $true)]
    [string]
    $ResourceGroup,

    [Parameter(Mandatory = $true)]
    [string]
    $CertificateUrl,

    [Parameter(Mandatory = $true)]
    [string]
    $VmssName
)

$CertStore = "My"

Write-Information "Getting Key Vault info for vault $SourceVault"
$Vault = Get-AzureRmKeyVault -VaultName $SourceVault

Write-Information "Getting VMSS info for VMSS $VmssName"
$Vmss = Get-AzureRmVmss -ResourceGroupName $ResourceGroup -VMScaleSetName $VmssName

Write-Information "Updating VMSS $VmssName"

try
{
    $CertConfig = New-AzureRmVmssVaultCertificateConfig -CertificateUrl $CertificateUrl -CertificateStore $CertStore
    $Vmss.VirtualMachineProfile.OsProfile.Secrets[0].VaultCertificates.Add($CertConfig) # NOTE: Change this as needed
    Update-AzureRmVmss -ResourceGroupName $ResourceGroup -Name $VmssName -VirtualMachineScaleSet $Vmss
}
Catch
{
    $ExceptionMessage = $_.Exception.Message
    Write-Warning $ExceptionMessage
}