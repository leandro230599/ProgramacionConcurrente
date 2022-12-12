--  En una clínica existe un médico de guardia que recibe continuamente peticiones de
--  atención de las E enfermeras que trabajan en su piso y de las P personas que llegan a la
--  clínica ser atendidos.
--  Cuando una persona necesita que la atiendan espera a lo sumo 5 minutos a que el médico lo
--  haga, si pasado ese tiempo no lo hace, espera 10 minutos y vuelve a requerir la atención del
--  médico. Si no es atendida tres veces, se enoja y se retira de la clínica.
--  Cuando una enfermera requiere la atención del médico, si este no lo atiende inmediatamente
--  le hace una nota y se la deja en el consultorio para que esta resuelva su pedido en el
--  momento que pueda (el pedido puede ser que el médico le firme algún papel). Cuando la
--  petición ha sido recibida por el médico o la nota ha sido dejada en el escritorio, continúa
--  trabajando y haciendo más peticiones.
--  El médico atiende los pedidos dándole prioridad a los enfermos que llegan para ser atendidos.
--  Cuando atiende un pedido, recibe la solicitud y la procesa durante un cierto tiempo. Cuando
--  está libre aprovecha a procesar las notas dejadas por las enfermeras.

procedure Clinica is

    task medico is
        entry solicitudE;
        entry solicitudP;
        entry nota(nota: in text);
    end medico;

    task type enfermeras;
    task type personas;

    personas : array(1..P) of personas;
    enfermeras : array(1..E) of enfermeras;

    task body enfermeras is
        nota : texto;
    begin
        loop
            SELECT
                medico.solicitudE();
            ELSE 
                medico.nota(nota); 
            END SELECT 
        end loop;
    end enfermeras;

    task body personas is
        cantVeces : int
        ok : boolean
    begin
        cantVeces := 0;
        loop
            SELECT
                medico.solicitudP();
                cantVeces := 3;
            OR DELAY 300
                delay(600)
                cantVeces++;
            END SELECT 
            exit when cantVeces == 3;
        end loop;
    end personas;

    task body medico is
    begin
        loop
            SELECT 
                accept solicitudP do
                    procesandoSolicitud()
                end solicitudP;
            OR 
                WHEN (solicitudP'count == 0) => accept solicitudE do
                                                    procesandoSolicitud();
                                                end solicitudE;
            OR 
                WHEN (solicitudP'count == 0 AND solicitudE'count == 0) =>   accept nota(nota: in text) do
                                                                                procesandoNota(nota);
                                                                            end nota;
            END SELECT;
        end loop;
    end medico;
begin
    null;
end Clinica;