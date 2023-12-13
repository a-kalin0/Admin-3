#4.3 Déblocage des comptes utilisateur ayant dépassé le nombre de tentatives de login erroné.

Import-Module ActiveDirectory

function Unlock-UserFromCSV {
    param(
        [string]$csvPath
    )

    $usersData = Import-Csv $csvPath

    foreach ($userData in $usersData) {
        $username = $userData.Username

        Unlock-ADAccount -Identity $username

        Write-Host "Le compte $username a bien été débloqué !"
    }
}

Unlock-UserFromCSV -csvPath "Users.csv"