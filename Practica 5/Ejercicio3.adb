--  Se dispone de un sistema compuesto por 1 central y 2 procesos periféricos, que se
--  comunican continuamente. Se requiere modelar su funcionamiento considerando las
--  siguientes condiciones:
--  - La central siempre comienza su ejecución tomando una señal del proceso 1; luego
--  toma aleatoriamente señales de cualquiera de los dos indefinidamente. Al recibir una
--  señal de proceso 2, recibe señales del mismo proceso durante 3 minutos.
--  - Los procesos periféricos envían señales continuamente a la central. La señal del
--  proceso 1 será considerada vieja (se deshecha) si en 2 minutos no fue recibida. Si la
--  señal del proceso 2 no puede ser recibida inmediatamente, entonces espera 1 minuto y
--  vuelve a mandarla (no se deshecha).

procedure Sistema is 

    task central is
        entry entradaA ();
        entry entradaB ();
        entry fin();

    task timer is
        entry inicia ();
        entry fin ();
    
    task type periferico;

    p1,p2 : periferico;

    task body timer is
    begin
        while true loop
            accept iniciar();
            delay(180);
            central.fin();
        end loop;
    end

    task body periferico is
        ok := false;
    begin
        loop
            if ("es periferico 1") then
                SELECT
                    central.entradaA();
                OR DELAY 120
                    null;
                END SELECT;
            else
                loop 
                    SELECT
                        central.entradaB();
                        ok := true;
                    OR DELAY 60
                        null;
                    END SELECT;

                exit when ok
                end loop;

        end loop;
    end periferico;

    task body central is
        ok := bool
    begin
        accept entradaA();
        loop
            SELECT 
                accept entradaA();
            OR
                accept entradaB() do
                    ok := false;
                    timer.iniciar();
                    while (not ok) loop 
                        SELECT 
                            when (fin'.count==0) => accept entradaB()
                        OR 
                            accept fin() do
                                ok := true;
                            end fin
                        end SELECT
                    end loop;
                end entradaB
            end SELECT
        end loop
    end central;