#  Modification automatique des informations sur des comptes utilisateur.

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

        Set-ADUser -Identity $username - $attribute $newValue

        Write-Host "Les informations pour le compte $username ont été modifiées !"
    }
}

Modify-UserFromCSV -csvPath "NewUsers.csv"