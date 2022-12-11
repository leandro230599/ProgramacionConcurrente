--  Se debe modelar la atención en un banco por medio de DOS empleados. Los clientes
--  llegan y son atendidos de acuerdo al orden de llegada por cualquiera de los dos.

Procedure Banco4 is

    Task Administrador is
        entry Pedido (IdC: IN integer; D: IN texto);
        entry Siguiente (Id: OUT integer; DC: OUT texto);
    End Administrador;

    Task Type Cliente is
        entry Ident (Pos: IN integer);
        entry Respuesta (R: IN texto);
    End Cliente;

    arrClientes: array (1..N) of Cliente;
    
    Task Body Administrador is
    Begin
        loop
            Accept Siguiente (Id: OUT integer; DC: OUT texto) do
                Accept Pedido (IdC: IN integer; D: IN texto) do
                    Id := IdC;
                    DC := D;
                End Pedido;
            End Siguiente;
        end loop;
    End Empleado;

    Task Type Empleado;
        
    EmpleadoA, EmpleadoB: Empleado;
    
    Task Body Empleado is
        Res, Dat: texto; idC: integer;
    Begin
        loop
            Administrador.Siguiente (idC, Dat);
            Res := resolverPedido(Dat);
            arrClientes(idC).Respuesta(Res);
        end loop;
    End Empleado;

    Task Body cliente is
        Resultado: texto; id: integer;
    Begin
        AcceptIdent (Pos: IN integer) do
            id := Pos;
        end Ident;
        Administrador.Pedido (id, “datos”);
        Accept Respuesta (R: IN texto) do
            Resultado := R;
        end Respuesta;
    End cliente;

Begin
    for i in 1..N loop
    arrClientes(i).Ident(i);
end loop;
End Banco4;