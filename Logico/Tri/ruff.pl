jockey(valdivieso, 155, 52).
jockey(leguisamo, 161, 49).
jockey(lezcano, 149, 50).
jockey(baratucci, 153, 55).
jockey(falero, 157, 52).
% jockey(Nombre, Altura, Peso)

caballo(botafogo).
caballo(oldMan).
caballo(energica).
caballo(matBoy).
caballo(yatasto).

prefiere(botafogo, Jockey):-jockey(Jockey, _, Peso), Peso < 52.
prefiere(botafogo, baratucci).
prefiere(old_man, Jockey):-jockey(Jockey, _, _), atom_length(Jockey, CantidadLetras), CantidadLetras > 7.
prefiere(energica, Jockey):-jockey(Jockey, _, _), not(prefiere(botafogo, Jockey)).
prefiere(mat_boy, Jockey):-jockey(Jockey, Altura, _), Altura > 170.

stud(valdivieso, eltute).
stud(falero, eltute).
stud(lezcano, hormigas).
stud(baratucci, charabon).
stud(leguisamo, charabon).

gano(botafogo, granPremioNacional).
gano(botafogo, granPremioRepublica).
gano(old_man, granPremioRepublica).
gano(old_man, campeonatoPalermoOro).
gano(mat_boy, granPremioCriadores).

prefiereMasDeUno(NombreCaballo):-
    prefiere(NombreCaballo, Jockey1),
    prefiere(NombreCaballo, Jockey2),
    Jockey1 \= Jockey2.

aborreceStud(NombreCaballo, NombreStud):-
    caballo(NombreCaballo),
    stud(_, NombreStud),
    forall(stud(Jockey, NombreStud), not(prefiere(NombreCaballo, Jockey))).

ganoPremioImportante(NombreCaballo):- gano(NombreCaballo, granPremioNacional) ; gano(NombreCaballo, granPremioRepublica).

piolin(NombreJockey):-
    jockey(NombreJockey, _, _),
    forall(ganoPremioImportante(NombreCaballo), prefiere(NombreCaballo, NombreJockey)).

ganadora(ganador(Caballo), Resultado):-salioPrimero(Caballo, Resultado).
ganadora(segundo(Caballo), Resultado):-salioPrimero(Caballo, Resultado).
ganadora(segundo(Caballo), Resultado):-salioSegundo(Caballo, Resultado).
ganadora(exacta(Caballo1, Caballo2),Resultado):-salioPrimero(Caballo1, Resultado), salioSegundo(Caballo2, Resultado).
ganadora(imperfecta(Caballo1, Caballo2),Resultado):-salioPrimero(Caballo1, Resultado), salioSegundo(Caballo2, Resultado).
ganadora(imperfecta(Caballo1, Caballo2),Resultado):-salioPrimero(Caballo2, Resultado), salioSegundo(Caballo1, Resultado).

salioPrimero(Caballo, [Caballo|_]).
salioSegundo(Caballo, [_|[Caballo|_]]).