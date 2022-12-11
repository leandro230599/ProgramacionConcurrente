--  Se debe modelar la atención en un banco por medio de un único empleado. Los
--  clientes llegan y esperan a ser atendidos; pueden ser Regulares o Prioritarios. El
--  empleado los atiende de acuerdo al orden de llegada pero dando prioridad a los
--  clientes Prioritarios

Procedure Banco3 is

    Task empleado is
        Entry Prioritario (D: IN texto; R: OUT texto);
        Entry Regular (D: IN texto; R: OUT texto);
    End empleado;

    Task type cliente;
    
    arrClientes: array (1..N) of Cliente;
    
    Task Body cliente is
        Resultado: texto;
    Begin
        if (“es cliente prioritario”) then
            Empleado.Prioritario (“datos”, Resultado);
        else
            Empleado.Regular (“datos”, Resultado);
        end if;
    End cliente;

    Task Body empleado is
    Begin
        loop
            SELECT
                accept Prioritario (D: IN texto; R: OUT texto) do
                    R := resolverPedidoPrioritario(D);
                end Prioritario;
            OR
                when (Prioritario’count= 0) =>
                    accept Regular (D: IN texto; R: OUT texto) do
                        R := resolverPedidoRegular(D);
                    end Regular;
            END SELECT;
        end loop;
    end empleado;

Begin
    null;
End Banco3;