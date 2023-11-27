#Désactivation automatiquement des comptes utilisateurs AD.

Import-Module ActiveDirectory

function Disable-UserFromCSV {
    param(
        [string]$csvPath
    )

    $usersData = Import-Csv $csvPath

    foreach ($userData in $usersData) {
        $username = $userData.Username

        Disable-ADAccount -Identity $username

        Write-Host "Le compte $username a bien été bloqué !"
    }
}

Disable-UserFromCSV -csvPath "Users.csv"