#script para privar todos os repositorios publicos de uma conta github

# Define o nome de usuario do github
$githubUsername = "username"

# Coleta lista de repositorios publicos

$reposJson = gh repo list $githubUsername -L 100 --json nameWithOwner,isPrivate


$repos = $reposJson | ConvertFrom-Json

# filtra publicos e coleta o nome dos repos
$publicRepos = $repos | Where-Object { $_.isPrivate -eq $false } | Select-Object -ExpandProperty nameWithOwner

# Loop por todos os repos é seta como privado
foreach ($repo in $publicRepos) {
    gh repo edit $repo --visibility private
}
