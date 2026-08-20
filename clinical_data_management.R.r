# Jointure dans R
# Nom : Dorsa AGHAJANI

# 0) Chargement et installation des packages 

# Liste des packages nécessaires pour ce projet
need <- c("survival", "dplyr", "tidyr")
# Identifier ceux qui ne sont pas encore installés
to_install <- need[!need %in% rownames(installed.packages())]
# Installer les packages manquants si besoin
if (length(to_install) > 0) install.packages(to_install)
# Charger les bibliothèques (sans afficher de messages)
suppressMessages(lapply(need, library, character.only = TRUE))


# 1) Chargement des données 

# Charger la table 'pbc' : une ligne par patient
data(pbc)
# Essayer de charger la table 'pbcseq' (mesures longitudinales)
# Cette table peut ne pas être disponible dans toutes les versions du package 'survival'
has_meta <- "pbcseq" %in% data(package = "survival")$results[, "Item"]
# Si 'pbcseq' est trouvée, on la charge
if (has_meta) {
  try(data(pbcseq), silent = TRUE)
}

# 2) Transformation : format long → format large 
# Objectif : transformer les données répétées 
# en un format large 

pbcseq_large <- pbcseq %>%
  arrange(id, day) %>%                   # trier par patient et par jour de mesure
  group_by(id) %>%                       # grouper les lignes par patient
  mutate(visit = dplyr::row_number()) %>%# créer un numéro de visite pour chaque patient
  ungroup() %>%                          # retirer le groupement
  select(id, visit, day, bili, albumin, protime) %>%  # garder seulement les variables utiles
  tidyr::pivot_wider(                    # passer du format long au format large
    names_from = visit,                  # les colonnes seront créées selon la visite
    values_from = c(day, bili, albumin, protime), # les variables à déplier
    names_glue = "{.value}_v{visit}"     # nommage des colonnes 
  )


#3) Jointure entre les tables 
# On veut combiner la table de base 'pbc' (une ligne par patient)
# avec la table de mesures 'pbcseq_large' (une ligne par patient aussi)
# La clé de jointure est 'id'

pbc_final <- pbc %>%
  dplyr::left_join(pbcseq_large, by = "id")  # jointure gauche (on garde tous les patients de pbc)


#4) Contrôles 
# Identifier les patients présents dans pbc mais absents dans pbcseq
# (patients sans mesures séquentielles)
ids_sans_seq <- pbc %>%
  dplyr::anti_join(pbcseq, by = "id") %>%
  dplyr::distinct(id)
# Afficher le nombre de patients sans suivi longitudinal
cat("Patients sans mesures séquentielles :", nrow(ids_sans_seq), "\n")


# 5) Aperçu & Export
# Afficher un aperçu des 5 premières lignes du tableau final
cat("\nAperçu pbc_final:\n")
print(utils::head(pbc_final, 5))
# Afficher les dimensions du tableau (lignes et colonnes)
cat("\nNombre de lignes/colonnes :", nrow(pbc_final), "/", ncol(pbc_final), "\n")