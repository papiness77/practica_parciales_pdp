% Acá va el código

%%%%%%%%%%%%%%%
% ---- 1 ---- %
%%%%%%%%%%%%%%%

juego(callOfDuty, accion, 2000).
juego(counterStrike, accion, 2000).

juego(lol, rol(200000), 0).
juego(minecraft, rol(500000), 1000).

juego(witness, puzzle(25, dificil), 1500).
juego(obduction, puzzle(15, facil), 1500).
juego(portal2, puzzle(10, dificil), 1500).

descuento(witness, -0.2).
descuento(counterStrike, -0.75).
descuento(obduction, -0.60).

tiene(ibai, minecraft).
tiene(ibai, lol).

tiene(jackSparrow, callOfDuty).
tiene(jackSparrow, portal2).
tiene(jackSparrow, witness).

planeaAdquirir(jackSparrow, minecraft, jackSparrow).
planeaAdquirir(jackSparrow, counterStrike, ibai).
planeaAdquirir(ibai, counterStrike, jackSparrow).

planeaAdquirir(carlos, obduction, carlos).
planeaAdquirir(carlos, counterStrike, carlos).

jugador(Jugador):-
    tiene(Jugador, _).

jugador(Jugador):-
    planeaAdquirir(Jugador, _, _).

%%%%%%%%%%%%%%%
% ---- 2 ---- %
%%%%%%%%%%%%%%%

esJuego(Juego):-
    juego(Juego, _, _).

cuantoSale(Juego, Precio):-
    not(descuento(Juego, _)),
    juego(Juego, _, Precio).

cuantoSale(Juego, Precio):-
    juego(Juego, _, PrecioBase),
    descuento(Juego, Descuento),
    Precio is abs(PrecioBase * Descuento).

buenDescuento(Juego):-
    esJuego(Juego),
    descuento(Juego, Descuento),
    Descuento =< -0.5 .

esPopular(Juego):-
    juego(Juego, accion, _),
    Juego \= counterStrike.

esPopular(Juego):-
    juego(Juego, rol(UsuariosActivos), _),
    UsuariosActivos > 1000000,
    Juego \= minecraft.

esPopular(Juego):-
    juego(Juego, puzzle(_, facil), _).

esPopular(Juego):-
    juego(Juego, puzzle(25, _), _).

esPopular(minecraft).
esPopular(counterStrike).

adictoADescuentos(Jugador):-
    jugador(Jugador),
    forall(planeaAdquirir(Jugador, Juego, _), buenDescuento(Juego)).

esDe(Nombre, accion):-
    juego(Nombre, accion, _).

esDe(Nombre, rol):-
    juego(Nombre, rol(_), _).
    
esDe(Nombre, puzzle):-
    juego(Nombre, puzzle(_, _), _).

genero(Genero):-
    juego(Nombre, _, _),
    esDe(Nombre, Genero).

fanatico(Jugador, Genero):-
    jugador(Jugador),
    genero(Genero),
    findall(Juego, (tiene(Jugador, Juego), esDe(Juego, Genero)), JuegosPorGenero),
    length(JuegosPorGenero, Cantidad),
    Cantidad >= 2.

monotematico(Jugador):-
    jugador(Jugador),
    tiene(Jugador, Juego),
    esDe(Juego, Genero),
    forall(tiene(Jugador, OtroJuego), esDe(OtroJuego, Genero)).    

buenosAmigos(Jugador, OtroJugador):-
    jugador(Jugador),
    jugador(OtroJugador),
    planeaAdquirir(Jugador, Juego, OtroJugador),
    planeaAdquirir(OtroJugador, Juego, Jugador),
    esPopular(Juego),
    Jugador \= OtroJugador.

cuantoGastara(Jugador, Cuanto):-
    jugador(Jugador),
    findall(Precio, (planeaAdquirir(Jugador, Juego, _), cuantoSale(Juego, Precio)), ListaPrecios),
    sumlist(ListaPrecios, Cuanto).