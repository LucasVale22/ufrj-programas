<?php

/*Incluir hora  e tratar zerar*/
$UmidadeSolo = array();
$Temperatura = array();
$Umidade = array();
$Luminosidade = array();

for($i = 0; $i <= 47 ; $i++)
{
	$UmidadeSolo[$i] = $_POST["us".(string)$i];
	$Temperatura[$i] = $_POST["t".(string)$i];
	$Umidade[$i] = $_POST["u".(string)$i];
	$Luminosidade[$i] = $_POST["l".(string)$i];
}

$Write = '<!DOCTYPE html>';
$Write .= '<html><head><title>piPlanta</title></head><body>';

for($i = 0; $i <=47; $i ++)
{
	$Write = $Write . "<p>Luminosidade" . (string)$i . ": " . $Luminosidade[$i]  	. "% </p> <br>
					   <p>Umidade" 		. (string)$i . ": " . $Umidade1[$i] 	   	. "% </p> <br>
					   <p>Temperatura" 	. (string)$i . ": " . $Temperatura1[$i]  	. " Celsius </p> <br>
					   <p>UmidadeSolo" 	. (string)$i . ": " . $UmidadeSolo[$i] 		. "% </p> <br>";
}
$Write .= "</body></html>";

file_put_contents('/public_html/index.html', $Write);

?>
