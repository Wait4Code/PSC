interleaving
============

l'entrelacement est une technique très régulièrement utilisée dans le cas de communications numériques fortement bruité

cela permet d'améliorer les performances des codes fec ( forward error correction ) comme le codage de reed-solomon utilisé dans le cas de l'adsl

le principe est de donc de changer l'ordre des symboles à l'émission et de les remettre en ordre à la réception

ce bloc se complète avec reed-solomon ( see card https://trello.com/c/HhGvpRLl/13-reed-solomon-channel-coding )


pourquoi faire de l'entrelacement ?
-----------------------------------

la plupart des canaux de communication ne sont pas sans mémoire, c'est-à-dire qu'ils ne sont pas stationnaires et que donc la plupart des erreurs vont apparaître sous forme de bursts plutôt qu'indépendamment les unes des autres

l'entrelacement permet donc de réaliser une distribution uniforme des erreurs en mélangeant les bits à l'aide d'un algorithme de codage et de décodage à l'intérieur d'un même mot-code

l'inconvénient de l'entrelacement est qu'il va augmenter la latence totale de la transmission puisque ce bloc à besoin de recevoir l'ensemble des blocs entrelacés à la réception avant de pouvoir les décoder

le type d'entrelacement utilisé en adsl est __l'entrelaceur convolutionnel__


entrelaceur convolutionnel
--------------------------

l'entrelaceur convolutionnel peut-être vu comme un système de multiplexage-démultiplexage

dans ce système composé de lignes à retard, celles-ci sont utilisés pour augmenter progressivement la longueur ( which one? )

ces lignes à retard sont tout simplement des circuits électroniques dont le but est de retarder le signal d'une certaine durée

CI( n, d ) où n correspond au nombre de lignes à retard et d le nombre de symbols introduits par chaque ligne à retard

for error correction capacity up to t, we have :

`maximum burst length allowed =  ( nd + 1 )( t - 1 )`


implémentation sous matlab
--------------------------

sous le schéma 256-Channel ADSL présent sous Matlab, il y a 2 branches à partir du flux binaire partagé en deux dont la première va être destinée aux fréquences basses et la seconde vers les fréquences hautes

comme en ADSL, le canal de transmission est très peu bruité dans les basses fréquences, nous ne sommes pas dans l'obligation de faire de l'entrelacement sur le flux partant vers les fréquences hautes

sous matlab, l'entrelaceur et le désentrelaceur convolutionnel ont les paramètres suivants :

- n = 5 où n est le nombre de lignes à retard ( rows of shift registers )

- b = 2 où b est le nombre de symboles introduits dans chaque ligne à retard ( register step length )

des fonctions existent sous matlab prenant à charge l'entrelacement convoloutif : `convintrlv` et `convdeintrlv`


sources
-------

- https://en.wikipedia.org/wiki/Forward_error_correction#Interleaving
