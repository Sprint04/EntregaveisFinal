import org.springframework.jdbc.core.BeanPropertyRowMapper
import org.springframework.jdbc.core.JdbcTemplate

class Repositorio {
    lateinit var server: JdbcTemplate

    fun iniciar(){
        server = SQLserver.bd!!
    }
    fun validarDispositivo(ip: String): Boolean {
            val token: String? = server.queryForObject(
                """
            SELECT chaveAtivacao AS token FROM dispositivo 
            JOIN empresa ON fkempresa = empresa.idEmpresa
            JOIN tokens ON fkToken = idToken
            WHERE ip = '$ip'
            """,String::class.java
            )
            return token!!.isNotBlank()
    }
    fun computador(ip: String): List<Computador> {
        return server.query(
            """
        select * from dispositivo
            where ip = '$ip' 
    """,
            BeanPropertyRowMapper(Computador::class.java)
        )
    }

    fun rename(alias:String, pc:Computador):Boolean{
        val update = server.update("update dispositivo set alias = '$alias' where idDispositivo = ${pc.idDispositivo}")
        return update == 1
    }
}

