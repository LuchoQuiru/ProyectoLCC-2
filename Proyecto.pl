% Almaraz Fabricio, Quiruga Luciano
:- use_rendering(table).


% Dir  -> Especifica la direccion del desplazamiento. Izq, der para fila, arriba o abajo para columna.
% Num  -> Especifica el numero de fila o columna a desplazar (del 1 al 5).
% Cant -> Especifica la cantidad de lugares a desplazar (del 1 al 4).
% Tablero -> Especifica el tablero sobre el cual se aplicará el desplazamiento.
% EvolTablero -> Es una lista de tableros que representa la evolucion del tablero original
%	EvolTablero incluirá algunos de (posiblemente todos) los siguientes tableros:
%		1. Resultante de realizar el desplazamiento (Dir,Num,Cant) sobre Tablero.
%		2. Resultante de colapsar todos los grupos de mamushkas alineadas y contiguas en la mamushka de tamanio 
%			 siguiente a partir de Tablero1; no se deben rellenar los espacios vacios que se generaron, sino que deben 
%			 ser reemplazados por la constante.
%		3. Resultante de desplazar hacia abajo, por "gravedad", las muniecas por encima de los espacios vacios en Tablero2,
%		     lo que "movera" los espacios vacios hacia arriba, a la parte superior del tablero.
%		4. Resultante de rellenar los espacios vacios en Tablero3 con mu~necas de tamanio chico y colores elegidos aleatoriamente.

desplazar(Dir, Num, Cant, Tablero, EvolTablero).
	



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rotar columna
desplazar_arriba(Num,Cant,Tablero,Rta):-
	obtener__columna(Num,Tablero,Elems,Tablero2),
	desplazar_izquierda(Cant,Elems,Elems2),
	insertar_elementos_columna(Num,Tablero2,Elems2,Rta).

desplazar_abajo(Num,Cant,Tablero,Rta):-
	obtener__columna(Num,Tablero,Elems,Tablero2),
	desplazar_derecha(Cant,Elems,Elems2),
	insertar_elementos_columna(Num,Tablero2,Elems2,Rta).

% Obtiene los elementos correspondientes a la columna de la posicion Pos
obtener_columna(Pos,[L|Ls],Elems,Rta):-
	posicion_de_lista(Pos,L,E,Fila),
	obtener__columna(Pos,Ls,E2,R),
	insertar_inicio(Fila,R,Rta),
	insertar_inicio(E,E2,Elems).

obtener__columna(Pos,[L],[E],[Fila]):-
	posicion_de_lista(Pos,L,E,Fila).

insertar_elementos_columna(Pos,[Col|Cols],[Elem|Elems],Tablero):-
	insertar_en_pos(Elem,Col,Pos,Columna2),
	insertar_elementos_columna(Pos,Cols,Elems,T),
	insertar_inicio(Columna2,T,Tablero).
insertar_elementos_columna(_,[],[],[]).
	

% Elimina el elemento de la posicion Pos y lo retorna
posicion_de_lista(Pos,[L|Ls],Elem,Lista):-
	P is Pos-1,
	P == 0,
	Elem = L,
	Lista = Ls.
posicion_de_lista(Pos,[L|Ls],Elem,ListaRet):-
	P is Pos-1,
	posicion_de_lista(P,Ls,Elem,Lista),
	insertar_inicio(L,Lista,ListaRet).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rotar fila

% Rota a Fila Cant veces a la izquierda
desplazar_izquierda(Num,Cant,[T|Ts],Rta):-
	obtener_fila(Num,[T|Ts],Fila,Tablero),
	desplazar_izquierda(Cant,Fila,Fila2),
	insertar_en_pos(Fila2,Tablero,Num,Rta).

desplazar_izquierda(Cant,Fila,Rta):-
	Cant > 0,
	rotar_izquierda(Fila,R),
	Cant2 is Cant - 1,
	desplazar_izquierda(Cant2,R,Rta).
desplazar_izquierda(0,Fila,Fila).
	
% Coloca el ultimo elemento de la lista al inicio de la misma
rotar_izquierda([H|T], R):- 
	append(T, [H], R).

% Rota a Fila Cant veces a la derecha
desplazar_derecha(Num,Cant,[T|Ts],Rta):-
	obtener_fila(Num,[T|Ts],Fila,Tablero),
	desplazar_derecha(Cant,Fila,Fila2),
	insertar_en_pos(Fila2,Tablero,Num,Rta).


desplazar_derecha(Cant,Fila,Rta):-
	Cant > 0,
	ultimo(Fila,U,R),
	insertar_inicio(U,R,R1),
	Cant2 is Cant-1,
	desplazar_derecha(Cant2,R1,Rta).
desplazar_derecha(0,Fila,Fila).

% Elimina el ultimo elemento de la lista y lo retorna
ultimo([L],L,[]).
ultimo([L|Ls],U,[L|R]):-
	ultimo(Ls,U,R).

	
%insertar_en_pos(Elem,[],5,[Elem]).
insertar_en_pos(Elem,[L|Ls],Pos,Rta):-
	P is Pos-1,
	P == 0,
	insertar_inicio(Elem,[L|Ls],Rta).

insertar_en_pos(Elem,[L|Ls],Pos,Rta):-
	P is Pos-1,
	insertar_en_pos(Elem,Ls,P,R),
	insertar_inicio(L,R,Rta).

insertar_en_pos(Elem,[],_,[Elem]).

% Retona la fila por una parte y el tablero sin ella por otro
obtener_fila(Num,[T|Ts],T,Ts):-
	Num2 is Num-1,
	Num2 == 0.
obtener_fila(Num,[T|Ts],Fila,Tab):-
	Num2 is Num-1,
	obtener_fila(Num2,Ts,Fila,Tab2),
	insertar_inicio(T,Tab2,Tab).

insertar_inicio(X,L,[X|L]).
	
