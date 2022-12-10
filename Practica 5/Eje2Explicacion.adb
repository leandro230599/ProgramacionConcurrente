### Se debe modelar la atención en un banco por medio de un único empleado. Los
clientes llegan y esperan a lo sumo 10 minutos a ser atendido de acuerdo al orden
de llegada. Pasado ese tiempo se retira sin ser atendido. ###

Procedure Banco2 is
    Task empleado is
        Entry Pedido (D: IN texto; R: OUT texto);
    End empleado;

    Task type cliente;

    arrClientes: array (1..N) of Cliente;
    
    Task Body cliente is
        Resultado: texto;
    Begin
        SELECT
            Empleado.Pedido (“datos”, Resultado);
        OR DELAY 600.0
            NULL;
        END SELECT;
    End cliente;

    Task Body empleado is
    Begin
        loop
            accept Pedido (D: IN texto; R: OUT texto) do
                R := resolverPedido(D);
            end Pedido;
        end loop;
    End empleado;

Begin
    null;
End Banco2;