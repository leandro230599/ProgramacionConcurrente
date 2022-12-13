--  Hay un sistema de reconocimiento de huellas dactilares de la policía que tiene 8 Servidores
--  para realizar el reconocimiento, cada uno de ellos trabajando con una Base de Datos propia;
--  a su vez hay un Especialista que utiliza indefinidamente. El sistema funciona de la siguiente
--  manera: el Especialista toma una imagen de una huella (TEST) y se la envía a los servidores
--  para que cada uno de ellos le devuelva el código y el valor de similitud de la huella que más
--  se asemeja a TEST en su BD; al final del procesamiento, el especialista debe conocer el
--  código de la huella con mayor valor de similitud entre las devueltas por los 8 servidores.
--  Cuando ha terminado de procesar una huella comienza nuevamente todo el ciclo. Nota:
--  suponga que existe una función Buscar(test, código, valor) que utiliza cada Servidor donde
--  recibe como parámetro de entrada la huella test, y devuelve como parámetros de salida el
--  código y el valor de similitud de la huella más parecida a test en la BD correspondiente.
--  Maximizar la concurrencia y no generar demora innecesaria

procedure Sistema is 
    task type servidor;  

    servidores: array(1..8) of servidor; 

    task especialista is 
        entry siguienteHuella(h: out img);  
        entry resultado(c: in int, v: in int); 
        entry fin; 
    end especialista

    task body especialista
        valorMax, codigoMax; 
    begin   
        while (true) loop  
            huella := tomarHuella()
            valorMax := -1; 
            codigoMax := -1; 
            for i:= 1..16 do loop
                select 
                    accept siguienteHuella(huella); 
                or 
                    when (siguienteHuella'count == 0) => 
                        accept resultado(c, v) do 
                            if (v > valorMax ) then
                                valorMax := v; 
                                codigoMax := c; 
                            end; 
                        end resultado; 
                end select;  
            end 

            for i:= 1..8 do loop; 
                accept fin; 
            end loop;
        end loop; 

    end especialista; 

    task body servidor is 
     huella: img; 
     valor, código: int; 
    begin  
        while (true) loop
            especialista.siguienteHuella(h); 
            huella := h; 
            buscarHuella(huella, calor, código); 
            especialista.resultado(código, valor); 
            especialista.fin; 
        end loop; 
    end servidor; 

begin 
    null; 
End Sistema; 