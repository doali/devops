# Virtualisation et connexion au réseau

## Connexions

|                  |bridge                  |NAT               |Host Only         |LAN segment             |
|------------------|------------------------|------------------|------------------|------------------------|
|monde exterieur   |accessible              |accessible        |uniquement host   |uniquement 1 LAN virtuel|
|principe          |carte reseau virtuelle  |i_face virtuel    |i_face virtuel    | LAN-1                  |
|                  |         I              |      I           | (adapt virtuel)  | LAN-2                  |
|                  |carte reseau physique   |i_face phy        |       I          | LAN-3                  |
|                  |  (monde exterieur)     | (monde exterieur)| (adapt virtuel!) | ...                    |
|                  |                        |                  |i_face phy        | LAN N                  |
|                  |                        | (DHCP virtuel)   |                  |                        |
|                  |                        |                  | (DHCP virtuel)   |(pas de comm entre LAN) |
|                  |                        |                  |                  |(pas acces à l'hote phy)|


## Biblio

- [it-connect](https://www.it-connect.fr/virtualisation-les-types-de-connexion-au-reseau/#V_Le_type_LAN_Segment)
