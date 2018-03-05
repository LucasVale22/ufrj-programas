package br.com.consumoagua.bens;

public class Medidas {
    
    private String apto;
    private String datahora;
    private Integer nropulsos;
    private Integer serialmedidas;
    
    public String getApto(){
        return apto;
    }
    public void setApto(String apto){
        this.apto = apto;
    }
    public String getDatahora(){
        return datahora;
    }
    public void setDatahora(String datahora){
        this.datahora = datahora;
    }
    public Integer getNropulsos(){
        return nropulsos;
    }
    public void setNropulsos(Integer nropulsos){
        this.nropulsos = nropulsos;
    }
    public Integer getSerialmedidas(){
        return serialmedidas;
    }
    public void setSerialmedidas(Integer serialmedidas){
        this.serialmedidas = serialmedidas;
    }
    
}