# WeatherSystem
Change la météo toutes les 10 minutes en suivant un rythme naturel (je ne suis pas un météorologue mais j'ai essayé d'être cohérent), avec un brouillard: quand il y a une tempête ou lorsque le ciel est couvert.

Quelques commandes sympas (qui nécessitent d'être administrateur):

/weather (change la météo pour tout les joueurs présent, attention un joueur qui va spawn ne sera pas synchronisé sur cette météo. J'ai manqué de temps et de connaissances), donc n'utilisez cette commande que si vous en avez vraiment envie).

/freezeweather (met en pause le système météorologique)

/unfreezeweather (enlève la pause, et continue le rythme naturel)

# Requirements
onsetrp https://github.com/frederic2ec/onsetrp

# Installation

Déplacer le dossier "weathersystem" dans package > onsetrp 

copier la ligne "weathersystem/server.lua" dans: package > onsetrp > package.json à la fin de servers_scripts

copier la ligne "weathersystem/client.lua" dans package > onsetrp > package.json à la fin de clients_scripts
