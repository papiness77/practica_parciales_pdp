% ---- 1 ---- % 

creeEn(gabriel, campanita).
creeEn(gabriel, magoDeOz).
creeEn(gabriel, cavenaghi).

creeEn(juan, conejoDePascua).

creeEn(macarena, reyesMagos).
creeEn(macarena, magoCapria).
creeEn(macarena, campanita).

suenia(gabriel, loteria([5, 9])).
suenia(gabriel, futbolista(arsenal)).
suenia(juan, cantante(100000)).
suenia(macarena, cantante(10000)).

% b- polimorfismo

% ---- 2 ---- %

chico(aldosivi).
chico(arsenal).

dificultadSegunTipo(cantante(Ventas), 6):-
    Ventas > 500000.

dificultadSegunTipo(cantante(Ventas), 4):-
    Ventas =< 500000. 

dificultadSegunTipo(loteria(NumerosApostados), Dificultad):-
    length(NumerosApostados, CantidadNumerosApostados),
    Dificultad is 10 * CantidadNumerosApostados.

dificultadSegunTipo(futbolista(Equipo), 3):-
    chico(Equipo).

dificultadSegunTipo(futbolista(Equipo), 16):-
    not(chico(Equipo)).

dificultadSuenio(Persona, Suenio, Dificultad):-
    suenia(Persona, Suenio),
    dificultadSegunTipo(Suenio, Dificultad).

sumaDificultadSuenios(Persona, DificultadTotal):-
    findall(Dificultad, dificultadSuenio(Persona, _, Dificultad), DificultadPorSuenio),
    sumlist(DificultadPorSuenio, DificultadTotal).

ambicioso(Persona):-
    suenia(Persona, _),
    sumaDificultadSuenios(Persona, DificultadTotal),
    DificultadTotal > 20.

% ---- 3 ---- %

puro(futbolista(_)).
puro(cantante(Ventas)):-
    Ventas < 200000.

quimicaSegunPersonaje(Persona, campanita):-
    dificultadSuenio(Persona, _, Dificultad),
    Dificultad < 5.

quimicaSegunPersonaje(Persona, _):-
    forall(suenia(Persona, Suenio), puro(Suenio)),
    not(ambicioso(Persona)).

tienenQuimica(Personaje, Persona):-
    creeEn(Persona, Personaje),
    quimicaSegunPersonaje(Persona, Personaje).
    
% ---- 4 ---- %

amigos(campanita, reyesMagos).
amigos(campanita, conejoDePascua).
amigos(conejoDePascua, cavenaghi).

enfermo(campanita).
enfermo(reyesMagos).
enfermo(conejoDePascua).

backup(Personaje, Amigo):-
    amigos(Personaje, Amigo).

backup(Personaje, Amigo):-
    amigos(Personaje, OtroPersonaje),
    backup(OtroPersonaje, Amigo).

personajeOAmigosSanos(Personaje):-
    not(enfermo(Personaje)).

personajeOAmigosSanos(Personaje):-
    enfermo(Personaje),
    backup(Personaje, Backup),
    not(enfermo(Backup)).

puedeAlegrar(Personaje, Persona):-
    suenia(Persona, _),
    tienenQuimica(Personaje, Persona),
    personajeOAmigosSanos(Personaje).

