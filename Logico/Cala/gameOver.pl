% link: https://www.utnianos.com.ar/foro/tema-pdep-parcial-l%C3%B3gico-14-08-2018

% ---- 1 ---- %
juego(marioBros, aventura(rescatarUnaPrincesa)).
juego(sonic, aventura(rescatarAnimales)).
juego(tetris, ingenio(200)).
juego(bomberman, ingenio(100)).
juego(bomberman, accion(cuadrilatero, 8)).

% ---- 2 ---- %
nombreGeneroDelJuego(Juego, Genero):-
    juego(Juego, Tipo),
    nombreGenero(Genero, Tipo).

nombreGenero(aventura, aventura(_)).
nombreGenero(ingenio, ingenio(_)).
nombreGenero(accion, accion(_, _)).

juegosMismoGenero(Juego1, Juego2):-
    nombreGeneroDelJuego(Juego1, Genero),
    nombreGeneroDelJuego(Juego2, Genero),
    Juego1 \= Juego2.

% ---- 3 ---- %
generoDificil(aventura(_)).

generoDificil(ingenio(NivelIngenio)):-
    NivelIngenio > 100.

generoDificil(accion(_, Jugadores)):-
    between(4, 8, Jugadores).

% ---- 4 ---- %
juegoDificil(Juego):-
    juego(Juego, _),
    forall(juego(Juego, Genero), generoDificil(Genero)).

% ---- 5 ---- %
popular(Juego):-
    juego(Juego, _),
    not(juegoDificil(Juego)).

juegosPopulares(Populares):-
    findall(Juego, popular(Juego), Populares).

% ---- 6 ---- %
cantidadJuegosGenero(Genero, Cantidad):-
    nombreGeneroDelJuego(_, Genero),
    findall(Juego, nombreGeneroDelJuego(Juego, Genero), JuegosGenero),
    length(JuegosGenero, Cantidad).

generoAExpandir(Genero):-
    cantidadJuegosGenero(Genero, CantidadMinima),
    forall(cantidadJuegosGenero(_, Cantidad), CantidadMinima =< Cantidad).

% ---- 7 ---- %

personajesSecundarios(sonic, [tails, knuckles]).
personajesSecundarios(marioBros, [luigi, bowser, peach]).
personajesSecundarios(bomberman, [bombermanNegro, regulus, altair, pommy, orion]).

cantidadPersonajes(Juego, Cantidad):-
    personajesSecundarios(Juego, Secundarios),
    length(Secundarios, CantidadSecundarios),
    Cantidad is 1 + CantidadSecundarios.

superMultijugador(Juego):-
    juego(Juego, _),
    cantidadPersonajes(Juego, CantidadMaxima),
    forall(cantidadPersonajes(_, Cantidad), CantidadMaxima >= Cantidad).

% ---- 8 ---- %

sucesor(marioBros, superMario).
sucesor(superMario, marioNintendo64).
sucesor(marioNintendo64, superMarioGalaxy).

esSaga(Juego, JuegoDeLaSaga):-
    sucesor(JuegoDeLaSaga, Juego).

esSaga(Juego, JuegoDeLaSaga):-
    sucesor(JuegoIntermedio, Juego),
    esSaga(JuegoIntermedio, JuegoDeLaSaga).