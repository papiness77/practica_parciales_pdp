personaje(pumkin,     ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).

pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).


% --- 1 --- %
realizaActividadPeligrosa(Personaje):-
    personaje(Personaje, mafioso(maton)).

realizaActividadPeligrosa(Personaje):-
    personaje(Personaje, ladron(Robos)),
    member(licorerias, Robos).

cosasTurbias(Personaje):-
    realizaActividadPeligrosa(Personaje).

cosasTurbias(Personaje):-
    trabajaPara(Personaje, Empleado),
    esPeligroso(Empleado).

esPeligroso(Personaje):-
    personaje(Personaje, _),
    cosasTurbias(Personaje).

% --- 2 --- %
amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).


sonPareja(Personaje1, Personaje2):-
    pareja(Personaje1, Personaje2).

sonPareja(Personaje1, Personaje2):-
    pareja(Personaje2, Personaje1).

sonAmigos(Personaje1, Personaje2):-
    amigo(Personaje1, Personaje2).

sonAmigos(Personaje1, Personaje2):-
    amigo(Personaje2, Personaje1).

sonDuo(Personaje1, Personaje2):-
    sonAmigos(Personaje1, Personaje2).

sonDuo(Personaje1, Personaje2):-
    sonPareja(Personaje1, Personaje2).

duoTemible(Personaje1, Personaje2):-
    esPeligroso(Personaje1),
    esPeligroso(Personaje2),
    sonDuo(Personaje1, Personaje2).

% --- 3 --- %
%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).

situacionProblematica(Personaje):-
    trabajaPara(Jefe, Personaje),
    esPeligroso(Jefe),
    sonPareja(Jefe, Pareja),
    encargo(Jefe, Personaje, cuidar(Pareja)).

situacionProblematica(Personaje):-
    encargo(_, Personaje, buscar(OtroPersonaje, _)),
    personaje(OtroPersonaje, boxeador).

estaEnProblemas(butch).

estaEnProblemas(Personaje):-
    personaje(Personaje, _ ),
    situacionProblematica(Personaje).

% --- 4 --- %
sonCercanos(Personaje1, Personaje2):-
    trabajaPara(Personaje1, Personaje2).

sonCercanos(Personaje1, Personaje2):-
    sonAmigos(Personaje1, Personaje2).

sanCayetano(Personaje):-
    personaje(Personaje, _),
    encargo(Personaje, _, _),
    forall(sonCercanos(Personaje, OtroPersonaje), encargo(Personaje, OtroPersonaje, _)).

% --- 5 --- %
cantidadTrabajos(Personaje, Cantidad):-
    personaje(Personaje, _),
    findall(_, encargo(_, Personaje, _), Trabajos),
    length(Trabajos, Cantidad).

masAtareado(Personaje):-
    personaje(Personaje, _),
    cantidadTrabajos(Personaje, CantidadMaxima),
    forall(cantidadTrabajos(_, Cantidad), CantidadMaxima >= Cantidad).

% --- 6 --- %
nivelRespeto(actriz(Peliculas), Nivel):-
    length(Peliculas, CantidadPeliculas),
    Nivel is CantidadPeliculas / 10.

nivelRespeto(mafioso(maton), 1).
nivelRespeto(mafioso(resuelveProblemas), 10).
nivelRespeto(mafioso(capo), 20).

esRespetable(Personaje):-
    personaje(Personaje, Rol),
    nivelRespeto(Rol, Nivel),
    Nivel > 9.

personajesRespetables(Quienes):-
    findall(Personaje, esRespetable(Personaje), Quienes).

% --- 7 --- %

tareaRequiereA(ayudar(Personaje), Personaje).
tareaRequiereA(cuidar(Personaje), Personaje).
tareaRequiereA(buscar(Personaje, _), Personaje).

tareaRequiereElOAmigo(Tarea, Personaje):-
    tareaRequiereA(Tarea, Personaje).

tareaRequiereElOAmigo(Tarea, Personaje):-
    sonAmigos(Personaje, Amigo),
    tareaRequiereA(Tarea, Amigo).

hartoDe(Personaje1, Personaje2):-
    personaje(Personaje1, _),
    personaje(Personaje2, _),
    forall(encargo(_, Personaje1, Tarea), tareaRequiereElOAmigo(Tarea, Personaje2)).

% --- 8 --- %

caracteristicas(vincent,  [negro, muchoPelo, tieneCabeza]).
caracteristicas(jules,    [tieneCabeza, muchoPelo]).
caracteristicas(marvin,   [negro]).

duoDiferenciable(Personaje1, Personaje2):-
    sonDuo(Personaje1, Personaje2),
    caracteristicas(Personaje1, Caracteristicas1),
    caracteristicas(Personaje2, Caracteristicas2),
    member(Caracteristica, Caracteristicas1),
    not(member(Caracteristica, Caracteristicas2)).