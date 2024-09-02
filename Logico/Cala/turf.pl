% --- 1 --- %

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

preferencia(botafogo, Jockey):-
    jockey(Jockey, _, Peso),
    Peso < 52.

preferencia(botafogo, baratucci).

preferencia(oldMan, Jockey):-
    jockey(Jockey, _, _),
    atom_length(Jockey, LongitudNombre),
    LongitudNombre > 7.

preferencia(energica, Jockey):-
    jockey(Jockey, _, _),
    not(preferencia(botafogo, Jockey)).

preferencia(matBoy, Jockey):-
    jockey(Jockey, Altura, _),
    Altura > 170.

stud(elTute, valdivieso).
stud(elTute, falero).
stud(lasHormigas, lezcano).
stud(charabon, baratucci).
stud(charabon, leguisamo).

gano(botafogo, granPremioNacional).
gano(botafogo, granPremioRepublica).
gano(oldMan, granPremioRepublica).
gano(oldMan, campeonatoPalermoDeOro).
gano(matBoy, granPremioCriadores).

% --- 2 --- %

prefiereVarios(Caballo):-
    preferencia(Caballo, Jockey),
    preferencia(Caballo, OtroJockey),
    Jockey \= OtroJockey.

% --- 3 --- %

aborrece(Caballo, Stud):-
    caballo(Caballo),
    stud(Stud, _),
    forall(stud(Stud, Jockey), not(preferencia(Caballo, Jockey))).

% --- 4 --- %

importante(granPremioNacional).
importante(granPremioRepublica).

ganadorImportante(Caballo):-
    caballo(Caballo),
    gano(Caballo, Premio),
    importante(Premio).

piolines(Jockey):-
    jockey(Jockey, _, _),
    forall(ganadorImportante(Caballo), preferencia(Caballo, Jockey)).

% --- 5 --- %

% apuesta(ganador(Caballo)).
% apuesta(segundo(Caballo)).
% apuesta(exacta(Primero, Segundo)).
% apuesta(imperfecta(Primero, Segundo)).

salioPrimero(Caballo, Resultados):-
    nth1(1, Resultados, Caballo).

salioSegundo(Caballo, Resultados):-
    nth1(2, Resultados, Caballo).

primeroOSegundo(Caballo, Resultados):-
    salioPrimero(Caballo, Resultados).

primeroOSegundo(Caballo, Resultados):-
    salioSegundo(Caballo, Resultados).

exactos(Primero, Segundo, Resultados):-
    salioPrimero(Primero, Resultados),
    salioSegundo(Segundo, Resultados).

apuestaGanadora(ganador(Caballo), Resultados):-
    salioPrimero(Caballo, Resultados).

apuestaGanadora(segundo(Caballo), Resultados):-
    primeroOSegundo(Caballo).

apuestaGanadora(exacta(Primero, Segundo), Resultados):-
    exactos(Primero, Segundo, Resultados).

apuestaGanadora(imperfecta(Primero, Segundo), Resultados):-
    exactos(Primero, Segundo, Resultados).

apuestaGanadora(imperfecta(Primero, Segundo), Resultados):-
    salioPrimero(Segundo, Resultados),
    salioSegundo(Preimero, Resultados).

% --- 6 --- %

color()