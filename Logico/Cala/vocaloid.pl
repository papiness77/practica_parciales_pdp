% ----------------- %
% ---- PARTE 1 ---- %
% ----------------- %

canta(megurineLuka, nightFever, 4).
canta(megurineLuka, foreverYoung, 5).

canta(hatsuneMiku, tellYourWorld, 4).

canta(gumi, foreverYoung, 4).
canta(gumi, tellYourWorld, 5).

canta(seeU, novemberRain, 6).
canta(seeU, nightFever, 5).

vocaloid(Vocaloid):-
    canta(Vocaloid, _, _).

% ---- 1 ---- %

cantidadCanciones(Vocaloid, Cantidad):-
    findall(Cancion, canta(Vocaloid, Cancion, _), Canciones),
    length(Canciones, Cantidad).

sabeAlMenosDos(Vocaloid):-
    canta(Vocaloid, Cancion, _),
    canta(Vocaloid, OtraCancion, _),
    Cancion \= OtraCancion.

tiempoTotalCanciones(Vocaloid, TiempoTotal):-
    findall(Tiempo, canta(Vocaloid, _, Tiempo), TiempoCanciones),
    sumlist(TiempoCanciones, TiempoTotal).

novedoso(Vocaloid):-
    vocaloid(Vocaloid),
    sabeAlMenosDos(Vocaloid),
    tiempoTotalCanciones(Vocaloid, TiempoTotal),
    TiempoTotal < 15.

% ---- 2 ---- %

cantaMasDe(Vocaloid, Minutos):-
    canta(Vocaloid, _, Duracion),
    Duracion > Minutos.

acelerado(Vocaloid):-
    vocaloid(Vocaloid),
    not(cantaMasDe(Vocaloid, 4)).
    
% ----------------- %
% ---- PARTE 2 ---- %
% ----------------- %

% ---- 1 ---- %

concierto(mikuExpo, estadosUnidos, 2000, gigante(2, 6)).
concierto(magicalMirai, japon, 3000, gigante(3, 10)).
concierto(vocalektVisions, estadosUnidos, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequenio(4)).

esConcierto(Concierto):-
    concierto(Concierto, _, _, _).

% ---- 2 ---- %

puedeParticipar(Vocaloid, Concierto):-
    vocaloid(Vocaloid),
    concierto(Concierto, _, _, TipoConcierto),
    cumpleRequisitos(Vocaloid, TipoConcierto),
    Vocaloid \= hatsuneMiku.

puedeParticipar(hatsuneMiku, Concierto):-
    esConcierto(Concierto).

cumpleRequisitos(Vocaloid, pequenio(DuracionMinima)):-
    cantaMasDe(Vocaloid, DuracionMinima).

cumpleRequisitos(Vocaloid, mediano(MaximoTiempoTotal)):-
    tiempoTotalCanciones(Vocaloid, TiempoTotal),
    TiempoTotal =< MaximoTiempoTotal.

cumpleRequisitos(Vocaloid, gigante(MinimoCanciones, MinimoTiempoTotal)):-
    cantidadCanciones(Vocaloid, Cantidad),
    tiempoTotalCanciones(Vocaloid, TiempoTotal),
    Cantidad > MinimoCanciones,
    TiempoTotal > MinimoTiempoTotal.

% ---- 3 ---- %

famaDeConciertos(Vocaloid, Nivel):-
    findall(Fama, (puedeParticipar(Vocaloid, Concierto), concierto(Concierto, _, Fama, _)), FamaCadaConcierto),
    sumlist(FamaCadaConcierto, Nivel).

nivelFama(Vocaloid, Nivel):-
    famaDeConciertos(Vocaloid, FamaConciertos),
    cantidadCanciones(Vocaloid, Cantidad),
    Nivel is FamaConciertos * Cantidad.

tieneMasFama(Vocaloid, OtroVocaloid):-
    nivelFama(Vocaloid, Fama1),
    nivelFama(OtroVocaloid, Fama2),
    Fama1 >= Fama2.

masFamoso(MejorVocaloid):-
    vocaloid(MejorVocaloid),
    forall(vocaloid(OtroVocaloid), tieneMasFama(MejorVocaloid, OtroVocaloid)).

% ---- 4 ---- %

conoce(megurineLuka, hatsuneMiku).
conoce(gumi, seeU).
conoce(seeU, kaito).

participanMismoConcierto(Vocaloid, OtroVocaloid, Concierto):-
    puedeParticipar(Vocaloid, Concierto),
    puedeParticipar(OtroVocaloid, Concierto).

conocidos(Vocaloid, OtroVocaloid):-
    conoce(Vocaloid, OtroVocaloid).

conocidos(Vocaloid, OtroVocaloid):-
    conoce(Vocaloid, UnVocaloid),
    conocidos(UnVocaloid, OtroVocaloid).
    
unicoParticipante(Vocaloid, Concierto):-
    vocaloid(Vocaloid),
    esConcierto(Concierto),
    forall(conocidos(Vocaloid, Conocido), not(participanMismoConcierto(Vocaloid, Conocido, Concierto))).