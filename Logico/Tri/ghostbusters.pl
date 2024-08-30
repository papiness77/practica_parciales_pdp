herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

% 1
tiene(egon, aspiradora(200)).
tiene(egon, trapeador).
tiene(peter, trapeador).
tiene(winston, varitaDeNeutrones).

%2
satisfaceHerramientaRequerida(NombrePersona, Herramienta):-
    tiene(NombrePersona, Herramienta).

satisfaceHerramientaRequerida(NombrePersona, aspiradora(PotenciaRequerida)):-
    tiene(NombrePersona, aspiradora(Potencia)),
    Potencia >= PotenciaRequerida.

%3
puedeRealizarTarea(NombrePersona, NombreTarea):-
    herramientasRequeridas(NombreTarea, Herramientas),
    forall(member(Herramienta, Herramientas), satisfaceHerramientaRequerida(NombrePersona, Herramienta)).
puedeRealizarTarea(NombrePersona, _):-
    tiene(NombrePersona, varitaDeNeutrones).

%4
%tareaPedida(nombreCLiente, tarea, metrosCuadrados)
tareaPedida(tuco, limpiarBanio, 20).

%precio(tarea, precioPorMEtroCuadrado)
precio(limpiarBanio, 10).

obtenerPrecioTareaPorMetroCuadrado(NombreTarea, MetrosCuadrados, Precio):-
    precio(NombreTarea, PrecioUnMetroCuadrado),
    Precio is PrecioUnMetroCuadrado * MetrosCuadrados.

obtenerPrecioTareaPorMetroCuadradoCliente(NombreCLiente, Precio):-
    tareaPedida(NombreCLiente, NombreTarea, MetrosCuadrados), 
    obtenerPrecioTareaPorMetroCuadrado(NombreTarea, MetrosCuadrados, Precio).

cobroAcliente(NombreCLiente, PrecioTotal):-
    findall(PrecioTarea, obtenerPrecioTareaPorMetroCuadradoCliente(NombreCLiente, PrecioTarea), Precios),
    sum_list(Precios, PrecioTotal).

%5
aceptaPedido(ray, NombreCLiente):-
    forall(tareaPedida(NombreCLiente, NombreTarea, _), (puedeRealizarTarea(NombreGhostBUster, NombreTarea), NombreTarea \= limpiarTecho)).

aceptaPedido()
