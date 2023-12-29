
# Charger les packages nécessaires en utilisant pacman, qui les installera s'ils ne sont pas déjà installés.
# - rmarkdown : Pour générer des documents R Markdown.
# - purrr : Pour les outils de programmation fonctionnelle.
# - stringr : Pour la manipulation de chaînes de caractères.
pacman::p_load(rmarkdown, purrr, stringr, dplyr)

# Définir un vecteur de pays pour lequel le rapport sera généré.
# Chaque pays de ce vecteur aura un rapport séparé.
countries <- c("Angola", "Nigeria", "Mali")

# Générer un tibble (data frame) contenant les noms de fichiers et les paramètres pour chaque rapport.
# - filename : Construit le nom du fichier de sortie pour chaque rapport, basé sur le nom du pays.
# - params : Une liste de paramètres, où chaque liste contient le nom du pays à passer au document R Markdown.
reports <- tibble(
  filename = str_c("hiv_report_", countries, ".html"),
  params = map(countries, ~list(country = .))
)

# Utiliser pwalk du package purrr pour itérer sur chaque ligne du tibble 'reports'.
# Pour chaque ligne, générer le document R Markdown en utilisant les paramètres spécifiés.
# - output_file : Le nom du fichier où le rapport sera sauvegardé.
# - params : Les paramètres passés au document R Markdown, spécifiant le pays pour le rapport.
# - input : Le chemin vers le document modèle R Markdown.
# - output_dir : Le répertoire où les rapports générés seront sauvegardés.
reports %>%
  select(output_file = filename, params) %>%
  pwalk(rmarkdown::render, input = "hiv_incidence_report.Rmd", output_dir = "output/")
