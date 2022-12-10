### . Se requiere modelar un puente de un único sentido que soporta hasta 5 unidades de peso.
El peso de los vehículos depende del tipo: cada auto pesa 1 unidad, cada camioneta pesa 2
unidades y cada camión 3 unidades. Suponga que hay una cantidad innumerable de
vehículos (A autos, B camionetas y C camiones). Analice el problema y defina qué tareas,
recursos y sincronizaciones serán necesarios/convenientes para resolver el problema.

a. Realice la solución suponiendo que todos los vehículos tienen la misma prioridad. ###

procedure Puente is 

    task Admin is
        Entry entraAuto()
        Entry entraCamioneta()
        Entry entraCamion()
        Entry saleAuto()
        Entry saleCamioneta()
        Entry saleCamion()
    end Admin

    task type Vehiculos

    vehiculos : array(1..N) of vehiculos

    task body Vehiculos is
    Begin
        if ("es auto") then
            Admin.entraAuto()
            Admin.saleAuto()
        elif ("es camioneta") then
            Admin.entraCamioneta()
            Admin.saleCamioneta()
        else
            Admin.entraCamion()
            Admin.saleCamion()
        endif
    end Vehiculos

    task body Admin is
        peso: int
    Begin
        peso:=0
        loop
            SELECT
                when(peso<5) =>
                    accept entraAuto() do
                        peso += 1
                    end entraAuto
            or
                when(peso<4) =>
                    accept entraCamioneta() do
                        peso +=2
                    end entraCamioneta
            or 
                when(peso<3) =>
                    accept entraCamion() do
                        peso +=3
                    end entraCamion
            or 
                accept saleAuto() do
                    peso -=1
                end saleAuto
            or
                accept saleCamioneta() do
                    peso -=2
                end saleCamioneta
            or 
                accept saleCamion() do
                    peso -=3
                end saleCamion
            end SELECT
        end loop
    end Admin
Begin
    null;
End Puente;



# b. Modifique la solución para que tengan mayor prioridad los camiones que el resto de los
# vehículos.

procedure Puente is 

    task Admin is
        Entry entraAuto()
        Entry entraCamioneta()
        Entry entraCamion()
        Entry saleAuto()
        Entry saleCamioneta()
        Entry saleCamion()
    end Admin

    task type Vehiculos

    vehiculos : array(1..N) of vehiculos

    task body Vehiculos is
    Begin
        if ("es auto") then
            Admin.entraAuto()
            Admin.saleAuto()
        elif ("es camioneta") then
            Admin.entraCamioneta()
            Admin.saleCamioneta()
        else
            Admin.entraCamion()
            Admin.saleCamion()
        endif
    end Vehiculos

    task body Admin is
        peso: int
    Begin
        peso:=0
        loop
            SELECT
                when(entraCamion´count==0 and peso<5) =>
                    accept entraAuto() do
                        peso += 1
                    end entraAuto
            or
                when(entraCamion´count==0 and peso<4) =>
                    accept entraCamioneta() do
                        peso +=2
                    end entraCamioneta
            or 
                when(peso<3) =>
                    accept entraCamion() do
                        peso +=3
                    end entraCamion
            or 
                accept saleAuto() do
                    peso -=1
                end saleAuto
            or
                accept saleCamioneta() do
                    peso -=2
                end saleCamioneta
            or 
                accept saleCamion() do
                    peso -=3
                end saleCamion
            end SELECT
        end loop
    end Admin
Begin
    null;
End Puente;