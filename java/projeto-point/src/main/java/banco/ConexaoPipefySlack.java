package banco;

import com.github.britooo.looca.api.core.Looca;
import com.github.britooo.looca.api.group.memoria.Memoria;
import com.mashape.unirest.http.exceptions.UnirestException;
import java.io.IOException;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

import org.springframework.jdbc.core.JdbcTemplate;

/**
 *
 * @author Guigu
 */
public class ConexaoPipefySlack {

    public static void main(String[] args) throws IOException, UnirestException {
        Looca looca = new Looca();
        Database database = new Database();
        JdbcTemplate connection = database.getConnection();
        Long memoria = looca.getMemoria().getEmUso();
        while (true) {
            if (memoria > 85) {
                OkHttpClient client = new OkHttpClient();
                String nome = "nome";
                MediaType mediaType = MediaType.parse("application/json");
                RequestBody body = RequestBody.create(mediaType, "{\"query\":\"mutation{   createCard(input:{     pipe_id:302776879,    fields_attributes:[     {field_id:\\\"qual_o_assunto_do_seu_pedido\\\",       field_value:\\\"Alerta de funcionario\\\"},     {field_id:\\\"email\\\",field_value:\\\"email@email.com\\\"},     {field_id:\\\"data_e_hora\\\",field_value:\\\"30/10/2022 01:58\\\"},     {field_id:\\\"nome_do_funcion_rio\\\",field_value:\\\"nome do funcionario\\\"}   ] }) {     card {      id title     }   }   }\"}");

                Request request = new Request.Builder()
                        .url("https://api.pipefy.com/graphql")
                        .post(body)
                        .addHeader("accept", "application/json")
                        .addHeader("Authorization", "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1c2VyIjp7ImlkIjozMDIwODMxNjcsImVtYWlsIjoiZ3VpbGhlcm1lLmFiYXJyb3NAc3B0ZWNoLnNjaG9vbCIsImFwcGxpY2F0aW9uIjozMDAyMDk3MjJ9fQ.F1Bg7s6kjT_BoHO2MI4ILjW8ayv_2YUqnJWJeRbXAkigJmMIpDUY2BMoMw_5qo9oKt8Wbm5akcMs0XMCxAnHMg")
                        /*"Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1c2VyIjp7ImlkIjozMDIwODMxNjcsImVtYWlsIjoiZ3VpbGhlcm1lLmFiYXJyb3NAc3B0ZWNoLnNjaG9vbCIsImFwcGxpY2F0aW9uIjozMDAyMDk3MjJ9fQ.F1Bg7s6kjT_BoHO2MI4ILjW8ayv_2YUqnJWJeRbXAkigJmMIpDUY2BMoMw_5qo9oKt8Wbm5akcMs0XMCxAnHMg"*/
                        .addHeader("Content-Type", "application/json")
                        .build();

                Response response = client.newCall(request).execute();
                System.out.println(response);
                break;
            }
        }

    }

}
