### Resolver la administración de las impresoras de una oficina. Hay 3 impresoras, N usuarios y
1 director. Los usuarios y el director están continuamente trabajando y cada tanto envían
documentos a imprimir. Cada impresora, cuando está libre, toma un documento y lo
imprime, de acuerdo con el orden de llegada, pero siempre dando prioridad a los pedidos
del director. Nota: los usuarios y el director no deben esperar a que se imprima el
documento. ###

chan PedidosUser (text);
chan PedidoDirector (text);
chan HayPedido (bool);

process Usuarios [ID:1..N] {
    texto documento;

    send PedidoUser (documento);
    send HayPedido (true);
}

process Director {
    texto documento;

    send PedidoDirector (documento);
    send HayPedido (true);
}

process Impresoras [ID:1..3] {
    texto documento;
    bool pedido = false;
    while true {
        receive HayPedido (pedido);
        if pedido==true {
            if empty(PedidoDirector) {
                receive PedidoUser (documento);
            } else {
                receive PedidoDirector (documento);
            }
            imprimir(documento);
        }
    }
}