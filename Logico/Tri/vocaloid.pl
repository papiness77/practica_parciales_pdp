%canta(nombreCancion, cancion)%
canta(megurineLuka, cancion(nightFever, 4)).
canta(megurineLuka, cancion(foreverYoung, 5)).
canta(hatsuneMiku, cancion(tellYourWorld, 4)).
canta(gumi, cancion(foreverYoung, 4)).
canta(gumi, cancion(tellYourWorld, 5)).
canta(seeU, cancion(novemberRain, 6)).
canta(seeU, cancion(nightFever, 5)).

esCantante(Cantante):-
    canta(Cantante, _).

cantanteNovedoso(Cantante):-
    esCantante(Cantante),
    cantidadDeCancionesCantanteEsMayorOIgualA(Cantante, 2),
    tiempoTotalDuracionCanciones(Cantante, TiempoTotal),
    TiempoTotal < 15.


cantidadCancionesCantante(Cantante, Cantidad):-
    esCantante(Cantante),
    findall(Cancion, canta(Cantante, Cancion), Canciones),
    length(Canciones, Cantidad).

cantidadDeCancionesCantanteEsMayorOIgualA(Cantante, UpperBound):-
    esCantante(Cantante),
    cantidadCancionesCantante(Cantante, CantidadCanciones),
    CantidadCanciones >= UpperBound.


tiempoTotalDuracionCanciones(Cantante, TiempoTotal):-
    esCantante(Cantante),
    findall(Duracion, (canta(Cantante, Cancion), tiempoDuracionCancion(Cancion, Duracion)), Duraciones),
    sum_list(Duraciones, TiempoTotal).


duraCancionMenosOIgualQue(Cancion, DuracionMaxima):-
    tiempoDuracionCancion(Cancion, Duracion),
    Duracion =< DuracionMaxima.

tiempoDuracionCancion(cancion(_,Duracion), Duracion).

cantanteAcelerado(Cantante):-
    esCantante(Cantante),
    canta(Cantante, Cancion),
    not(not(duraCancionMenosOIgualQue(Cancion, 4))).

%concierto(nombre, pais, fama, tipo())

concierto(mikuExpo, eeuu, 2000, gigante(2,6)).
concierto(magicalMirai, japon, 3000, gigante(3,10)).
concierto(vocalektVisions, eeuu, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, diminuto(4)).

cumpleRequisitos(Cantante, gigante(Canciones, Tempo)):-
    cantidadDeCancionesCantanteEsMayorOIgualA(Cantante, Canciones),
    tiempoTotalDuracionCanciones(Cantante, TiempoTotal),
    TiempoTotal >= Tempo.

cumpleRequisitos(Cantante, mediano(DuracionMaxima)):-
    esCantante(Cantante),
    tiempoTotalDuracionCanciones(Cantante, Duracion),
    Duracion < DuracionMaxima.

cumpleRequisitos(Cantante, diminuto(Tiempo)):-
    canta(Cantante, Cancion),
    tiempoDuracionCancion(Cancion, TiempoCancion),
    TiempoCancion > Tiempo.

puedeParticipar(hatsuneMiku, Concierto):-
    concierto(Concierto, _, _, _).

puedeParticipar(Cantante, Concierto):-
    esCantante(Cantante),
    concierto(Concierto, _, _, Tipo),
    cumpleRequisitos(Cantante, Tipo).


vocaloidMasFamoso(Cantante):-
    nivelDeFama(Cantante, NivelFamoso),
    forall(nivelDeFama(_, Nivel), NivelFamoso >= Nivel).

nivelDeFama(Cantante, Nivel):-
