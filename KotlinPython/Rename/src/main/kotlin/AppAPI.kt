import java.util.*

fun api(){
    val mac = getMac()
    val bd = Repositorio()
    bd.iniciar()
    if(bd.validarDispositivo(mac)) {
        val sn = Scanner(System.`in`)

        val comp: List<Computador> = bd.computador(mac)

        val pc = comp[0]
        println("Credenciais verificadas, Iniciando programa de renomear!")
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
            |1 - Não digite nomes ofencivos;
            |2 - Não use espaços;
            |3 - Use esse Executável conscientemente e não constantemente.
            |
        """.trimMargin())
        Thread.sleep(5000)
        println("Digite o novo nome desse dispositivo:")
        val alias = sn.next()
        bd.rename(alias, pc)
    } else{
        println("Dispositivo não identificado!")
    }




}
