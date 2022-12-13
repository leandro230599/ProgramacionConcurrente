--  En una playa hay 5 equipos de 4 personas cada uno (en total son 20 personas donde cada
--  una conoce previamente a que equipo pertenece). Cuando las personas van llegando
--  esperan con los de su equipo hasta que el mismo esté completo (hayan llegado los 4
--  integrantes), a partir de ese momento el equipo comienza a jugar. El juego consiste en que
--  cada integrante del grupo junta 15 monedas de a una en una playa (las monedas pueden ser
--  de 1, 2 o 5 pesos) y se suman los montos de las 60 monedas conseguidas en el grupo. Al
--  finalizar cada persona debe conocer el grupo que más dinero junto. Nota: maximizar la
--  concurrencia. Suponga que para simular la búsqueda de una moneda por parte de una
--  persona existe una función Moneda() que retorna el valor de la moneda encontrada.

procedure juego is 
    task admin is 
        entry totalEquipo(t: in int, e: in int); 
    end admin

    task type equipo is
        entry nro(n: in int);  
        entry llegada(n: in int); 
        entry monedas(t: in int); 
    end equipo

    task type jugador is 
        entry numero(n: in int, e: in int)
        entry iniciar; 
        entry equipoGanador(e: in int); 
    end jugador 

    equipos: array(1..5) of equipo; 
    jugadores: array(1..20) of jugadores; 

    task body jugador is 
        nro, eq, total: int; 
    begin 
        total := 0; 
        accept numero(n, e) do 
            nro := n; 
            eq := e; 
        end numero 

        equipo(eq).llegada(nro); 
        accept iniciar; 

        for i:= 1..15 loop  
            total += monedaEncontrda()
        end loop; 

        equipo(eq).total(total); 
        accept equipoGanador(rta); 

    end jugador; 

    task body equipo is 
        n, total: int;
        queue cola;  
    begin 
        accept nro(num) do 
            n := num;
        end nro; 

        for i:= 1..4 loop   
            accept llegada(n) do 
                push(cola(n)); 
            end llegada
        end loop

        for i:= 1..4 loop
            pop(cola(n))
            jugadores(n).iniciar; 
        end loop

        for i:= 1..4 loop 
            accept monedas(t) do 
                total += t; 
            end monedas
        end loop

        admin.totalEquipo(n, total); 
    end equipo

    task body admin is 
        totalXEquipo: array(1..5) of int; 
        ganador: int; 
    begin 
        for i:= 1..5 loop 
            accept totalEquipo(n, t) do 
                totalXEquipo(n) := t; 
            end totalXEquipo; 
        end loop; 

        ganador := máximo(totalXEquipo); 

        for i:= 1..20 loop 
            jugadores(i).equipoGanador(ganador); 
        end 
    end admin

begin 
    for i:= 1..20 loop
        e := asignarEquipo(random(1..5)); 
        jugador[i].numero(i, e); 
    end loop

    for i:= 1..5 loop
        equipos(i).nro(i); 
    end loop; 
end juego; 