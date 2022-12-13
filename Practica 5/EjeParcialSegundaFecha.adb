--  Resolver con ADA el siguiente problema. Una empresa de venta de calzado cuenta con S sedes. En la oficina
--  central de la empresa se utiliza un sistema que permite controlar el stock de los diferentes modelos, ya que
--  cada sede tiene una base de datos propia. El sistema de control de stock funciona de la siguiente manera:
--  dado un modelo determinado, lo envía a las sedes para que cada una le devuelva la cantidad disponible en
--  ellas; al final del procesamiento, el sistema informa el total de calzados disponibles de dicho modelo. Una
--  vez que se completó el procesamiento de un modelo, se procede a realizar lo mismo con el siguiente modelo.
--  Nota: suponga que existe una función DevolverStock(modelo,cantidad) que utiliza cada sede donde recibe
--  como parámetro de entrada el modelo de calzado y retorna como parámetro de salida la cantidad de pares
--  disponibles. Maximizar la concurrencia y no generar demora innecesaria

procedure empresa is

    task central is
        entry recibirDato(cantidad: IN int);
    end central;

    task type sede is
        entry solicitaDato(modelo: IN texto); -- Esto puedo evitarlo metiendolo al central y que el dato sea de salida
    end sede;

    sedes : array(1..S) of sede;

    task body central is
        cantidad : int;
        total : int;
        modelo: texto;
    begin
        loop
            total :=0;
            modelo := eligeModelo();
            for I in 1..S loop
                sedes[I].solicitaDato(modelo);
            end loop;
            
            for I in 1..S loop
                accept recibirDato(cantidad : IN int) do
                    total := total + cantidad;
                end recibirDato;
            end loop;
            imprimirPantalla(total);
        end loop;
    end central;

    task body sede is
        cantidad: int
        m : texto;
    begin
        loop
            accept solicitaDato(modelo: IN texto) do
                m := modelo;
            end solicitaDato;
            DevolverStock(m,cantidad);
            central.recibirDato(cantidad);
        end loop;
    end sede;
begin
    null;
end empresa;
