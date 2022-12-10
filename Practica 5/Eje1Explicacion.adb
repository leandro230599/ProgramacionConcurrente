### Se debe modelar la atención en un banco por medio de un único empleado. Los
clientes llegan y son atendidos de acuerdo al orden de llegada. ###

Procedure Banco1 is
    Task empleado is
        Entry Pedido (D: IN texto; R: OUT texto);
    End empleado;

    Task type cliente;
    
    arrClientes: array (1..N) of Cliente;
    
    Task Body cliente is
        Resultado: texto;
    Begin
        Empleado.Pedido (“datos”, Resultado);
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
End Banco1;