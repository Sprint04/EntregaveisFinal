import java.util.*

fun api(){
    val mac = getMac()
    val bd = Repositorio()
    bd.iniciar()
    if(bd.validarDispositivo(mac)) {
        val sn = Scanner(System.`in`)

        val comp: List<Computador> = bd.computador(mac)

        val pc = comp[0]
        println("Credenciais verificadas, Iniciando programa de encerrar!")
        Thread.sleep(2000)
        println(
            """
        |
        |Dispositivo: ${pc.ip}
        |Apelido atual: ${pc.alias}
        |
    """.trimMargin()
        )
        Thread.sleep(2000)
        println("""
            |
            |Regras:
            |1 - O encerramento é permanente;
            |2 - Os dados dessa maquina existe ainda, porem não serão mais disposiveis para você por meio de grafico na dashboard;
            |3 - Cuidado para não remover uma maquina que o monitoramente seja realmente importante.
            |4 - Cuidado, qualquer "s" que você digitar será contabilizado como SIM.
            |
        """.trimMargin())
        Thread.sleep(5000)
        println("Tem certeza que deseja deletar? S/N")
        val alias = sn.next().toString().lowercase()
        if(alias.contains('s')){
            bd.encerrar(pc)
        } else{
            println("Operação cancelada")
        }
    } else{
        println("Dispositivo não identificado!")
    }




}
