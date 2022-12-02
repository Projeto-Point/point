package banco;

public class Localizacao {
    public String ip;
    public String city;
    public String region;
    public String country;
    public String loc;
    public String org;
    public String postal;
    public String timezone;
    public String readme;
    public String hostname;

    public String[] getLocation(Localizacao local) {
        String locLat = local.loc;
        String[] geoLocation = locLat.split(",");
        return geoLocation;
    }

    public void inserirLocalizacao(Database banco, String acao, Integer idMaquina, Localizacao local) {
        banco.inserirRegistro(String.format("INSERT INTO Localizacao (acao, dataEhora, ipAdress, longitude, latitude, cidade, pais, fkMaquina) VALUES ('%s', DATA, '%s', %s, %s, '%s', '%s', %d)",
                acao,
                local.ip,
                getLocation(local)[0],
                getLocation(local)[1],
                local.city,
                local.country,
                idMaquina
            )
        );
    }
}
