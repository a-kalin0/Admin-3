Import-Module ActiveDirectory

function Remove-UserFromCSV {
    param(
        [string]$csvPath
    )

    $usersData = Import-Csv $csvPath

    foreach ($userData in $usersData) {
        $username = $userData.Username

        try {
            # Suppression du compte utilisateur
            Remove-ADUser -Identity $username -Confirm:$false
            Write-Host "Le compte de $username a été supprimé avec succès."
        } catch {
            Write-Host "Erreur lors de la suppression du compte de $username : $_"
        }
    }
}

Remove-UserFromCSV -csvPath "C:\Users\Administrator\Desktop\Admin\Scripts\Users.csv"