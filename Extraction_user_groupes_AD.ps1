# Spécifier le nom de domaine
$nomDomaine = "NATURACARE"

# Charger le module Active Directory
Import-Module ActiveDirectory

# Récupérer tous les groupes du domaine
$groupes = Get-ADGroup -Filter * -Server $nomDomaine

# Créer un tableau pour stocker les résultats
$resultats = @()

# Parcourir chaque groupe
foreach ($groupe in $groupes) {
    # Récupérer les membres du groupe
    $membres = Get-ADGroupMember -Identity $groupe -Server $nomDomaine

    # Parcourir chaque membre du groupe
    foreach ($membre in $membres) {
        # Vérifier si le membre est un utilisateur
        if ($membre.objectClass -eq "user") {
            # Créer un objet contenant les informations du groupe et du membre
            $resultat = [PSCustomObject] @{
                "Groupe" = $groupe.Name
                "Utilisateur" = $membre.Name
            }
            
            # Ajouter l'objet au tableau des résultats
            $resultats += $resultat
        }
    }
}

# Exporter les résultats vers un fichier CSV
$resultats | Export-Csv -Path "chemin_vers_le_fichier.csv" -NoTypeInformation
