--  Se debe modelar un buscador para contar la cantidad de veces que aparece un número dentro de un
--  vector distribuido entre las N tareas contador. Además existe un administrador que decide el
--  número que se desea buscar y se lo envía a los N contadores para que lo busquen en la parte del
--  vector que poseen, y calcula la cantidad total.

Procedure ContadorOcurrencias is

    Task Admin is
        entry Valor (num: out integer);
        entry Resultado (res: in integer);
    End admin;

    Task type Contador;
    
    ArrC: array (1..N) of Contador;

    Task body Contadoris
        vec: array (1..V) of integer := InicializarVector;
        valor, cant: integer :=0;
    Begin
        Admin.valor(valor);
        for i in 1..V loop
            if (vec(i)= valor) then
                cant:=cant+1;
            end if;
        end loop;
        Admin.Resultado(cant);
    End contador;

    Task body Admin is
        numero: integer := elegirNumero; total: integer:= 0;
    Begin
        for i in 1..2*N loop
            select
                accept Valor (num: out integer) do
                    num := numero;
                end Valor;
            or
                accept Resultado (res: in integer) do
                    total:= total + res;
                end Resultado;
            end select;
        end loop;
    End Admin;

Begin
    null;
End ContadorOcurrencias;