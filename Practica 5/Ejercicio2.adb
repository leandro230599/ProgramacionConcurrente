-- Se quiere modelar el funcionamiento de un banco, al cual llegan clientes que deben realizar
-- un pago y retirar un comprobante. Existe un único empleado en el banco, el cual atiende de
-- acuerdo con el orden de llegada. Los clientes llegan y si esperan más de 10 minutos se
-- retiran sin realizar el pago.

procedure Banco is

    task Empleado is
        Entry Pago (D: IN int; R: OUT text);
    End Empleado;

    task type Clientes;

    clientes : array(1..N) of Clientes;

    task body Empleado is 
    begin
        loop
            accept Pago (D: IN int; R: OUT text);
                R := procesarPago(D);
            end Pago;
        end loop;
    end Empleado;

    task body Clientes is
        monto : int;
        comprobante : texto;
    begin
        SELECT
           Empleado.Pago(monto,comprobante);
        OR DELAY 600;
            NULL;
        END SELECT;
    end Clientes;

Begin
    null;
End Banco;
