package br.com.consumoagua.jdbc;


import java.sql.Connection;
import java.sql.PreparedStatement;

import br.com.consumoagua.bens.Medidas;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MedidasDAO {
    
    private Connection con = Conexao.getConnection();
    
    public List<Medidas> buscarTodos(Medidas medidas/*,String npagina*/){
        
        /*Integer inicio = 40777;
        Integer numero = Integer.parseInt(npagina);
        
        String limite1 = Integer.toString(inicio+21*numero);
        String limite2 = Integer.toString(inicio+21*numero+20);*/
      
        String sql = "SELECT row_to_json(medidas) FROM medidas";
        List<Medidas> lista = new ArrayList<Medidas>();
        try {
            PreparedStatement preparador = con.prepareStatement(sql);
            //preparador.setString(5,medidas.getDataRecebida());
            ResultSet resultados = preparador.executeQuery();
            //preparador.setString(2, medidas.getApto());
            
            while(resultados.next()){
                Medidas med = new Medidas();
                
                med.setApto(resultados.getString("apto"));
                med.setDatahora(resultados.getTimestamp("datahora"));
                //med.setDatahoraz(resultados.getTimestamp("datahoraz"));
                med.setNropulsos(resultados.getInt("nropulsos"));
                med.setSerialmedidas(resultados.getInt("serialmedidas"));
                med.setHidrometro(resultados.getInt("hidrometro"));
                med.setVolnoperiodo(resultados.getFloat("volnoperiodo"));
                med.setNropulsosacumulados(resultados.getInt("nropulsosacumulados"));
                med.setVolacumulado(resultados.getFloat("volacumulado"));
                med.setCustoacumulado(resultados.getFloat("custoacumulado"));
                med.setCustonoperiodo(resultados.getFloat("custonoperiodo"));
                
                lista.add(med);
            }
        } catch (SQLException e) {
            System.out.println("Erro - "+e.getMessage());
        } return lista;
        
    }
    
}