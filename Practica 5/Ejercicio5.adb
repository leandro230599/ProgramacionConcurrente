--  En un sistema para acreditar carreras universitarias, hay UN Servidor que atiende pedidos
--  de U Usuarios de a uno a la vez y de acuerdo con el orden en que se hacen los pedidos.
--  Cada usuario trabaja en el documento a presentar, y luego lo envía al servidor; espera la
--  respuesta de este que le indica si está todo bien o hay algún error. Mientras haya algún error,
--  vuelve a trabajar con el documento y a enviarlo al servidor. Cuando el servidor le responde
--  que está todo bien, el usuario se retira. Cuando un usuario envía un pedido espera a lo sumo
--  2 minutos a que sea recibido por el servidor, pasado ese tiempo espera un minuto y vuelve a
--  intentarlo (usando el mismo documento).

procedure Sistema is

    task servidor is
        entry pedido(doc: IN texto; ok: OUT Boolean);
    end servidor;

    task type usuarios;

    usuarios : array(1..U) of usuarios;

    task body servidor is
    begin
        loop
            accept pedido(doc: IN texto; ok: OUT boolean) do
                ok := procesandoDocumento(doc);
            end pedido;
        end loop;
    end servidor;

    task body usuarios is
        doc: texto;
        res: boolean;
    begin
        doc := trabajandoDocumento();
        loop
            SELECT 
                servidor.pedido(doc,res)
                if (not res) then
                    doc := corregirDocumento() o trabajandoDocumento();
                endif;
            OR DELAY 120
                DELAY 60
            END SELECT 
            exit when res;
        end loop;
    end usuarios;
begin
    null;
end Sistema;