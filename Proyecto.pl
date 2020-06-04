% Almaraz Fabricio, Quiruga Luciano
:- use rendering(table).


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