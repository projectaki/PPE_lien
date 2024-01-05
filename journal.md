## Journal de groupe
# Cours 10 - 29/11
(Débora) Création du journal de groupe / j'ai eu juste avant de rendre le devoir une branche divergente. Après
plusieurs dizaines de minutes à essayer de gérer le problème, je n'ai finalement fait qu'agraver les chose car
je me suis retrouvée à 10 commits de retards. Je le ferai plus tard à tête reposée. 

(Maria) J'ai rencontré quelques difficultés lors de la création de scripts après le 10e cours. La tâche la plus 
difficile a été d'obtenir correctement le nom de base du fichier que je traitais. Cela a nécessité de nombreuses
modifications de code, mais j'ai réussi à obtenir le format souhaité. De plus, indiquer les chemins des fichiers 
s'est avéré être un défi, mais j'ai réussi à résoudre ce problème en utilisant des chemins absolus.

# Cours 11 - 06/12
(Débora) J'ai réussi à résoudre ma branche divergente en suivant des indications sur un forum et les conseils de
notre ami bash. J'ai maintenant un peu mieux compris l'histoire des merge et des rebase.

(Maria) J'ai fait quelques modifications sur notre page web et j'ai modifié le code HTML pour que le site soit plus clair. On continuera l'édition de notre site web ensemble après le cours 12. 

# Cours 12 - 13/12
(Débora) J'ai demandé en cours pour la tokenisation du coréen, et j'ai dû installer la librairie konlpy. On a
modifié le fichier de tokenisation du japonais et on l'a renommé korean.py. Les essais ont l'air concluants.

# 03/01
(Débora) Modifications de la page html et ajout de nouveaux liens pour le coréen.

# 04/01
(Maria) J'ai modifié le script de concordances en bash pour qu'il génère une page HTML avec des concordances.

# 05/01
(Maria)
Aujourd'hui, j'ai travaillé sur mon script, et j'ai rencontré quelques difficultés tout au long du processus :
- Encodage des Caractères Polonais :
J'ai dû m'assurer que les caractères polonais étaient correctement affichés dans le script. Pour cela, j'ai ajouté l'option -assume_charset=UTF-8 à Lynx pour garantir le traitement en UTF-8 du contenu.
- Encodage des Fichiers Dump :
La gestion appropriée de l'encodage des fichiers dump générés par Lynx était cruciale. J'ai utilisé la commande file pour vérifier l'encodage et, au besoin, j'ai employé iconv pour une conversion explicite vers UTF-8.
- Utilisation de grep avec Différentes Versions :
J'ai rencontré des problèmes liés à l'utilisation de grep avec l'option -P. Certains systèmes ne la prennent pas en charge, donc j'ai ajusté le script pour utiliser l'option -E là où nécessaire.

