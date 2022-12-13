--  Resolver con ADA el siguiente problema. Se quiere modelar el funcionamiento de un banco, al cual llegan
--  clientes que deben realizar un pago y llevarse su comprobante. Los clientes se dividen entre los regulares y los
--  premium, habiendo R clientes regulares y P clientes premium. Existe un único empleado en el banco, el cual
--  atiende de acuerdo al orden de llegada, pero dando prioridad a los premium sobre los regulares. Si a los 30
--  minutos de llegar un cliente regular no fue atendido, entonces se retira sin realizar el pago. Los clientes premium
--  siempre esperan hasta ser atendidos.

Procedure banco is

    task empleado is
        entry pagaRegular (D: IN int; R: OUT texto);
        entry pagaPremium (D: IN int; R: OUT texto);
    end empleado;

    task type clientes;

    clientes : array(1..N) of clientes;

    task body empleado is
        
    begin
        loop
            SELECT 
                accept pagaPremium(D: IN int; R: OUT texto) do
                    R := procesarPago(D);
                end pagaPremium;
            OR 
                when(pagaPremium'count==0) =>   accept pagaRegular(D: IN int; R: OUT texto) do
                                                    R := procesarPago(D);
                                                end pagaRegular;
            END SELECT;
        end loop;
    end empleado;


    task body clientes is
        D:int;
        R:texto;
    begin
        if ("es premium") then
            empleado.pagaPremium(D, R);
        else
            SELECT 
                empleado.pagaRegular(D, R);
            OR DELAY(1800);
                null;
            END SELECT;
        end if;       
    end clientes;

Begin 
    null;
end banco;