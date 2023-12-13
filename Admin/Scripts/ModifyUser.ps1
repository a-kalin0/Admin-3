Import-Module ActiveDirectory

function Modify-UserFromCSV {
    param(
        [string]$csvPath
    )

    $usersData = Import-Csv $csvPath

    foreach ($userData in $usersData) {
        $username = $userData.Username
        $attribute = $userData.Attribute
        $newValue = $userData.NewValue

        switch ($attribute) {
            "Password" {
                $securePassword = ConvertTo-SecureString $newValue -AsPlainText -Force
                Set-ADAccountPassword -Identity $username -NewPassword $securePassword -Reset
                Write-Host "Le mot de passe pour le compte $username a été modifié !"
            }
            "Email" {
                Set-ADUser -Identity $username -EmailAddress $newValue
                Write-Host "L'adresse e-mail pour le compte $username a été modifiée !"
            }
            "Username" {
                $newSamAccountName = $newValue
                $newUserPrincipalName = "$newValue@3TL2-7V2.lab"
                Get-ADUser -Identity $username | Set-ADUser -SamAccountName $newSamAccountName -UserPrincipalName $newUserPrincipalName
                Write-Host "Le nom d'utilisateur pour $username a été changé en $newSamAccountName !"
            }

            default {
                Write-Host "Attribut non reconnu : $attribute"
            }
        }
    }
}

Modify-UserFromCSV -csvPath "C:\Users\Administrator\Desktop\Admin\Scripts\NewUsers.csv"