duenio(andy, woody, 8).
duenio(sam, jessie, 3).

% deTrapo(tematica)
% deAccion(tematica, partes)
% miniFiguras(tematica, cantidadDeFiguras)
% caraDePapa(partes)


juguete(woody, deTrapo(vaquero)).
juguete(jessie, deTrapo(vaquero)).
juguete(buzz, deAccion(espacial, [original(casco)])).
juguete(soldados, miniFiguras(soldado, 60)).
juguete(monitosEnBarril, miniFiguras(mono, 50)).
juguete(seniorCaraDePapa, caraDePapa([original(pieIzquierdo), original(pieDerecho), repuesto(nariz)])).

% Dice si un juguete es raro
esRaro(deAccion(stacyMalibu, [sombrero])).
% Dice si una persona es coleccionista
esColeccionista(sam).

% --- 1 --- %
% a
tematica(deTrapo(Tematica), Tematica).
tematica(deAccion(Tematica, _), Tematica).
tematica(miniFiguras(Tematica, _), Tematica).
tematica(caraDePapa(_), caraDePapa).

%b
esDePlastico(miniFiguras(_, _)).
esDePlastico(caraDePapa(_)).

%c
esMinifigura(miniFiguras(_, _)).

esDeColeccion(deTrapo(_)).
esDeColeccion(Juguete):-
    not(esMinifigura(Juguete)),
    esRaro(Juguete).

% --- 2 --- %
tieneJuguetePlastico(Duenio, )

amigoFiel(Duenio, NombreJuguete):-
    duenio(Duenio, NombreJuguete, Antiguedad),
    juguete(NombreJuguete, Juguete),
    not(esDePlastico(Juguete)),
