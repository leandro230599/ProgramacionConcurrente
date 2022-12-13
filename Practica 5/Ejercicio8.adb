--  Una empresa de limpieza se encarga de recolectar residuos en una ciudad por medio de 3
--  camiones. Hay P personas que hacen continuos reclamos hasta que uno de los camiones
--  pase por su casa. Cada persona hace un reclamo, espera a lo sumo 15 minutos a que llegue
--  un camión y si no vuelve a hacer el reclamo y a esperar a lo sumo 15 minutos a que llegue
--  un camión y así sucesivamente hasta que el camión llegue y recolecte los residuos; en ese
--  momento deja de hacer reclamos y se va. Cuando un camión está libre la empresa lo envía a
--  la casa de la persona que más reclamos ha hecho sin ser atendido. Nota: maximizar la
--  concurrencia.

procedure recolección is 
    task type camion; 
    camiones: array[1..3] of camion; 

    task type persona is
        entry identificación(id: in int); 
        entry recolección; 
    end persona; 
    personas: array[1..P] of persona; 

    task Empresa is 
        entry reclamo(idP: in int)
        entry siguiente(idP: in int); 
    end Empresa;

    task body persona is
        id: int; 
        ok: boolean; 
    begi
        accept indentificación(pos) do
        id := pos;
        end identificación
        ok := false; 
        while (not ok) loop
            Empresa.reclamo(id); 
            select 
                accept recolección do  
                    ok := true; 
                edn recolección; 
            or delay(15*60); 
                null
        end loop; 
    End persona; 

    task body Empresa is 
        reclamos: array[1..P] of int; 
        idP, posMax, total: int; 
    begin
        for i:= 1..P loop
            reclamos[i] := 0; 
        end loop;

        total := 0; 
        while(true) loop
            select
                //es correcto? 
                accept reclamo(idP) do 
                    reclamos[idP] ++; 
                    total ++:
                end reclamo;
            or when(siguiente'count > 0 and total > 0) => 
                
                // posMax es un param de salida acà   
                accept siguiente(posMax) do 
                    posMax := posConMasReclamos(reclamos); 
                    total := total - reclamos[posMax]; 
                    reclamos[posMax] := 0; 
                end siguiente; 

        end loop; 
    end Empresa

    task body camion is 
        idC: int; 
    begin
        while (true) loop 
            Empresa.siguiente(posMax);
            idC := posMax; 
            persona[idC].recolección; 
        end loop
    end camion; 

begin 
    for i:= 1..P loop 
        personas[i].identificación(i); 
    end loop 
End recolección; 