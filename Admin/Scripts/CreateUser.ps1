# Création automatiquement des comptes utilisateurs Active Directory.

Import-Module ActiveDirectory

function Create-UserFromCSV {
    param(
        [string]$csvPath
    )

    $usersData = Import-Csv $csvPath

    foreach ($userData in $usersData) {
        $username = $userData.Username
        $password = $userData.Password
        $email = $userData.Email

        # Vérifier si l'utilisateur existe déjà
        $userExists = Get-ADUser -Filter "SamAccountName -eq '$username'" -ErrorAction SilentlyContinue

        if ($userExists) {
            Write-Host "Le user $username a déjà été créé comme il faut"
        } else {
            try {
                New-ADUser -SamAccountName $username -UserPrincipalName "$username@your_domain.com" -Name $username -GivenName $username -Surname "User" -EmailAddress $email -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -Enabled $true
                Write-Host "Bravo ! Le user $username a été créé !"
            } catch [Microsoft.ActiveDirectory.Management.ADPasswordComplexityException] {
                Write-Host "Le mot de passe ne respecte pas les conditions pour $username"
            } catch {
                Write-Host "Une erreur est survenue lors de la création du user $username : $_"
            }
        }
    }
}

Create-UserFromCSV -csvPath "C:\Users\Administrator\Desktop\Admin\Scripts\Users.csv"
