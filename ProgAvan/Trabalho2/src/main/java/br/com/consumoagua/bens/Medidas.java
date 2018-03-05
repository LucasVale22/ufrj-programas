package br.com.consumoagua.bens;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import javax.json.Json;
import javax.json.JsonObject;

public class Medidas /*implements Serializable*/{
    /*final float COEF_PULSOS = 0.3F;
    final float CUSTO_POR_VOLUME = 0.005F;
    
    private String apto = "";
    private Timestamp datahora;
    private String lognumber = "";
    private Timestamp datahoraMaisrecente;
    private Timestamp datahoraz;
    private Timestamp datahorazMaisrecente;
    private int nropulsos = 0;
    private int hidrometro = 0;
    private int hidrometroMaisRecente = 0;
    private int nropulsosacumuladosMaisRecente = 0;
    private float m3noperiodo = 0F;
    private float custonoperiodo = 0F;
    private int nropulsosacumulados = 0;
    private float m3acumulados = 0F;
    private float custoacumulado = 0F;
    private String mesRef;
    private String anoRef;*/
    
    private String apto = "";
    private Timestamp datahora;
    private int nropulsos;
    private int serialmedidas;
    private int hidrometro;
    private float volnoperiodo;
    private int nropulsosacumulados;
    private float volacumulado;
    private float custoacumulado;
    private float custonoperiodo;
    private String dataRecebida;
    
    

    /*public void calcularColunas(){
        long timestamp = datahora.getTime();
        Calendar cal = Calendar.getInstance();
        cal.setTimeInMillis(timestamp);
        int intMesDatahora = cal.get(Calendar.MONTH);
        
        timestamp = datahoraMaisrecente.getTime();
        cal = Calendar.getInstance();
        cal.setTimeInMillis(timestamp);
        int intMesDatahoraMaisrecente = cal.get(Calendar.MONTH);
        if(intMesDatahora>intMesDatahoraMaisrecente){
            nropulsosacumulados = 0;
        }else{
            nropulsosacumulados = nropulsosacumuladosMaisRecente+nropulsos;
        }
        datahoraz = datahora;
        hidrometro = hidrometroMaisRecente + nropulsos;
        volnoperiodo = COEF_PULSOS * nropulsos;
        custonoperiodo = CUSTO_POR_VOLUME * volnoperiodo;
        volacumulado = COEF_PULSOS * nropulsosacumulados;
        custoacumulado = CUSTO_POR_VOLUME * volacumulado;
    }*/
    
    public JsonObject getObjetoJSON() {
        return objetoJSON;
    }

    public void setObjetoJSON(JsonObject objetoJSON) {
        this.objetoJSON = objetoJSON;
    }

    /*public Timestamp getDatahoraMaisrecente() {
        return datahoraMaisrecente;
    }

    public void setDatahoraMaisrecente(Timestamp datahoraMaisrecente) {
        this.datahoraMaisrecente = datahoraMaisrecente;
    }

    public Timestamp getDatahorazMaisrecente() {
        return datahorazMaisrecente;
    }

    public void setDatahorazMaisrecente(Timestamp datahorazMaisrecente) {
        this.datahorazMaisrecente = datahorazMaisrecente;
    }

    public int getNropulsosacumuladosMaisRecente() {
        return nropulsosacumuladosMaisRecente;
    }

    public void setNropulsosacumuladosMaisRecente(int nropulsosacumuladosMaisRecente) {
        this.nropulsosacumuladosMaisRecente = nropulsosacumuladosMaisRecente;
    }

    public int getHidrometroMaisRecente() {
        return hidrometroMaisRecente;
    }

    public void setHidrometroMaisRecente(int hidrometroMaisRecente) {
        this.hidrometroMaisRecente = hidrometroMaisRecente;
    }*/

    public String getApto() {
        return apto;
    }

    public void setApto(String apto) {
        this.apto = apto;
    }

    /*public String getLognumber() {
        return lognumber;
    }

    public void setLognumber(String lognumber) {
        this.lognumber = lognumber;
    }*/

    public Timestamp getDatahora() {
        return datahora;
    }

    public void setDatahora(Timestamp datahora) {
        this.datahora = datahora;
    }

    /*public Timestamp getDatahoraz() {
        return datahoraz;
    }

    public void setDatahoraz(Timestamp datahoraz) {
        this.datahoraz = datahoraz;
    }*/

    public int getNropulsos() {
        return nropulsos;
    }

    public void setNropulsos(int nropulsos) {
        this.nropulsos = nropulsos;
    }
    
    public float getVolnoperiodo() {
        return volnoperiodo;
    }

    public void setVolnoperiodo(float volnoperiodo) {
        this.volnoperiodo = volnoperiodo;
    }

    public int getSerialmedidas() {
        return serialmedidas;
    }

    public void setSerialmedidas(int serialmedidas) {
        this.serialmedidas = serialmedidas;
    }
    
    
    public int getHidrometro() {
        return hidrometro;
    }

    public void setHidrometro(int hidrometro) {
        this.hidrometro = hidrometro;
    }

    public int getNropulsosacumulados() {
        return nropulsosacumulados;
    }

    public void setNropulsosacumulados(int nropulsosacumulados) {
        this.nropulsosacumulados = nropulsosacumulados;
    }

    public float getVolacumulado() {
        return volacumulado;
    }

    public void setVolacumulado(float volacumulado) {
        this.volacumulado = volacumulado;
    }

    public float getCustoacumulado() {
        return custoacumulado;
    }

    public void setCustoacumulado(float custoacumulado) {
        this.custoacumulado = custoacumulado;
    }
    
    public float getCustonoperiodo() {
        return custonoperiodo;
    }

    public void setCustonoperiodo(float custonoperiodo) {
        this.custonoperiodo = custonoperiodo;
    }
    
    public String getDataRecebida() {
        return dataRecebida;
    }

    public void setDataRecebida(String dataRecebida) {
        this.dataRecebida = dataRecebida;
    }
    
    JsonObject objetoJSON;
    
    public JsonObject toJSON(){

        objetoJSON = Json.createObjectBuilder()
                .add("dataRef", dataRecebida)
                
                .build();
        
        return objetoJSON;
    }
    
    @Override
    public String toString(){
        return toJSON().toString();
    }
    
}