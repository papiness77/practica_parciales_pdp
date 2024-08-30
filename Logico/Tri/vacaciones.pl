destino(dodain, pehuenia).
destino(dodain, sanMartin).
destino(dodain, esquel).
destino(dodain, sarmiento).
destino(dodain, camarones).
destino(dodain, playasDoradas).

destino(alf, bariloche).
destino(alf, sanMartin).
destino(alf, elBolson).

destino(nico, marDelPlata).

destino(vale, calafate).
destino(vale, elBolson).

destino(martu, Destino):-
    destino(nico, Destino).
destino(martu, Destino):-
    destino(alf, Destino).

esPersona(NombrePersona):-
    destino(NombrePersona, _).

atraccion(esquel, parqueNacional(losAlceres)).
atraccion(esquel, excursion(trochita)).
atraccion(esquel, excursion(trevelin)).

atraccion(pehuenia, cerro(bateMahuida, 2000)).
atraccion(pehuenia, cuerpoDeAgua(moquehue, pescar, 14)).
atraccion(pehuenia, cuerpoDeAgua(alumine, pescar, 19)).

atraccionCopada(cerro(_, Altura)):- Altura > 2000.
atraccionCopada(cuerpoDeAgua(_, pescar, _)).
atraccionCopada(cuerpoDeAgua(_, _, Temperatura)):- Temperatura > 20.
atraccionCopada(playa(Marea)):- Marea < 5.
atraccionCopada(excursion(Nombre)):- string_length(Nombre, Largo), Largo > 7.
atraccionCopada(parqueNacional(_)). 

lugarTieneAtraccionCopada(Lugar):-
    atraccion(Lugar, Atraccion),
    atraccionCopada(Atraccion).

vacacionesCopadas(NombrePersona):-
    esPersona(NombrePersona),
    forall(destino(NombrePersona, Lugar), lugarTieneAtraccionCopada(Lugar)).

noSeCruzaron(Persona1, Persona2):-
    esPersona(Persona1), esPersona(Persona2),
    forall(destino(Persona1, Lugar), not(destino(Persona2, Lugar))).

costoDeVida(sarmiento, 100).
costoDeVida(esquel, 150).
costoDeVida(pehuenia, 180).
costoDeVida(sanMartin, 150).
costoDeVida(bariloche, 140).
costoDeVida(elBolson, 145).
costoDeVida(camarones, 135).
costoDeVida(playasDoradas, 170).
costoDeVida(calafate, 240).
costoDeVida(marDelPlata, 140).

vacacionesGasoleras(Persona):-
    esPersona(Persona),
    forall(destino(Persona, Lugar), esGasolero(Lugar)).

esGasolero(Lugar):-
    costoDeVida(Lugar, Costo),
    Costo < 160.

