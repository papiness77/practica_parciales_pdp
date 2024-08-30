herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

% ---- 1 ---- %

tiene(egon, aspiradora(200)).
tiene(egon, trapeador).

tiene(peter, trapeador).

tiene(winston, varitaDeNeutrones).

limpiador(Limpiador):-
    tiene(Limpiador, _).

tarea(Tarea):-
    herramientasRequeridas(Tarea, _).

% ---- 2 ---- %

cumpleRequerimiento(Herramienta, Herramienta).
cumpleRequerimiento(aspiradora(Potencia), aspiradora(PotenciaRequerida)):-
    Potencia >= PotenciaRequerida.

satisfaceNecesidad(Limpiador, Requerimiento):-
    tiene(Limpiador, UnaHerramienta),
    cumpleRequerimiento(UnaHerramienta, Requerimiento).

% ---- 3 ---- %

cumpleRequerimientosTarea(Limpiador, _):-
    tiene(Limpiador, varitaDeNeutrones).

cumpleRequerimientosTarea(Limpiador, Tarea):-
    herramientasRequeridas(Tarea, Requerimientos),
    forall(member(Requerimientos, Requerimiento), satisfaceNecesidad(Limpiador, Requerimiento)).

puedeRealizarTarea(Limpiador, Tarea):-
    limpiador(Limpiador),
    tarea(Tarea),
    cumpleRequerimientosTarea(Limpiador, Tarea).

% ---- 4 ---- %

% tareaPedida(Cliente, Tarea, CantidadMetros)
% precio(Tarea, PrecioPorMetro)

tarea(juan, ordenarCuarto, 10).
tarea(juan, cortarPasto, 20).

tarea(marcos, limpiarBanio, 5).

tarea(gonzalo, encerarPisos, 15).

cliente(Cliente):-
    tarea(Cliente, _, _).

precio(encerarPisos, 50).
precio(cortarPasto, 20).
precio(ordenarCuarto, 15).
precio(limpiarBanio, 30).
precio(limpiarTecho, 30).

precioPorTarea(Cliente, PrecioTotal):-
    tarea(Cliente, Tarea, Metros),
    precio(Tarea, Precio),
    PrecioTotal is Metros * Precio.
    
precioPedido(Cliente, PrecioFinal):-
    cliente(Cliente),
    findall(Precio, precioPorTarea(Cliente, Precio), ListaPrecios),
    sumlist(ListaPrecios, PrecioFinal).

% ---- 5 ---- %

esCompleja(limpiarTecho).

esCompleja(Tarea):-
    herramientasRequeridas(Tarea, Herramientas),
    length(Herramientas, Cantidad),
    Cantidad > 2.

dispuestoAceptar(Cliente, ray):-
    tarea(Cliente, Tarea, _),
    Tarea \= limpiarTecho.

dispuestoAceptar(Cliente, winston):-
    precioPedido(Cliente, Precio),
    Precio > 500.

dispuestoAceptar(Cliente, egon):-
    forall(tarea(Cliente, Tarea, _), not(esCompleja(Tarea))).

dispuestoAceptar(_, peter).

aceptanPedido(Cliente, Limpiador):-
    cliente(Cliente),
    limpiador(Limpiador),
    forall(tarea(Cliente, Tarea, _), puedeRealizarTarea(Limpiador, Tarea)),
    dispuestoAceptar(Cliente, Limpiador).    

