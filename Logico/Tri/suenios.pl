creeEn(gabriel, campanita).
creeEn(gabriel, magoDeOz).
creeEn(gabriel, cavenagi).

creeEn(juan, conejoPascua).

creeEn(macarena, reyesMagos).
creeEn(macarena, magoCapria).
creeEn(macarena, campanita).

suenio(gabriel, loteria([5,9])).
suenio(gabriel, futbolista(arsenal)).
suenio(juan, cantante(100000)).
suenio(macarena, cantante(10000)).

equipoChico(arsenal).
equipoChico(aldosivi).

dificultadSuenio(cantante(Cantidad), 6):- Cantidad > 500000.
dificultadSuenio(cantante(Cantidad), 4):- Cantidad =< 500000.
dificultadSuenio(loteria(Numeros), Dificultad):-
    length(Numeros, CantidadNumeros),
    Dificultad is CantidadNumeros*10.
dificultadSuenio(futbolista(Equipo), 3):-
    equipoChico(Equipo).
dificultadSuenio(futbolista(Equipo), 16):-
    not(equipoChico(Equipo)).

dificultadSuenioPersona(Persona, Dificultad):-
    suenio(Persona, Suenio), 
    dificultadSuenio(Suenio, Dificultad).

esAmbicioso(Persona):-
    suenio(Persona, _),
    findall(Dificultad, dificultadSuenioPersona(Persona, Dificultad), Dificultades),
    sum_list(Dificultades, DificultadTotal),
    DificultadTotal > 20.


suenioPuro(futbolista(_)).
suenioPuro(cantante(Cantidad)):- Cantidad < 200000.

todosSueniosPuros(Persona):-
    suenio(Persona, _),
    forall(suenio(Persona, Suenio), suenioPuro(Suenio)).

tieneQuimica(Persona, Personaje):-
    creeEn(Persona, Personaje),
    cumpleConRequisitoDelPersonaje(Persona, Personaje).
    
cumpleConRequisitoDelPersonaje(Persona, campanita):-
    dificultadSuenioPersona(Persona, Dificultad),
    Dificultad < 5.

cumpleConRequisitoDelPersonaje(Persona, _):-
    not(esAmbicioso(Persona)),
    todosSueniosPuros(Persona).

amigoDe(campanita, reyesMagos).
amigoDe(campanita, conejoPascua).
amigoDe(conejoPascua, cavenagi).

amigosIndirectos(Personaje1, Personaje2):-
    amigoDe(Personaje1, Personaje2).

amigosIndirectos(Personaje1, Personaje2):-
    amigoDe(Personaje1, Personaje3),
    amigosIndirectos(Personaje3, Personaje2).

amigos(Personaje1, Personaje2):-
    amigosIndirectos(Personaje1, Personaje2);
    amigosIndirectos(Personaje2, Personaje1);
    amigoDe(Personaje1, Personaje2);
    amigoDe(Personaje2, Personaje1);

enfermo(campanita).
enfermo(reyesMagos).
enfermo(conejoPascua).

noEnfermo(Personaje):-
    creeEn(_, Personaje),
    not(enfermo(Personaje)).

puedeAlegrar(Personaje, Persona):-
    suenio(Persona, _),
    tieneQuimica(Persona, Personaje),
    hayBackupONoEstaEnfermo(Personaje).

hayBackupONoEstaEnfermo(Personaje):-
    noEnfermo(Personaje).

hayBackupONoEstaEnfermo(Personaje):-
    amigos(Personaje, Backup),
    noEnfermo(Backup).
