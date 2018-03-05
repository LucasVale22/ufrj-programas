<?php

/*Incluir hora  e tratar zerar*/

$UmidadeSolo = array();
$Temperatura = array();
$Umidade = array();
$Luminosidade = array();

for($i = 0; $i <= 47 ; $i++)
{
	$UmidadeSolo[$i] = $_Post["us".(string)$i];
	$Temperatura[$i] = $_Post["t".(string)$i];
	$Umidade[$i] = $_Post["u".(string)$i];
	$Luminosidade[$i] = $_Post["l".(string)$i];
}


$Write = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\r\n';
$Write .= '<html xmlns="http://www.w3.org/1999/xhtml" lang="en">\r\n';

for($i = 0; $i <=47; $i ++)
{
	$Write = $Write . "<p>Luminosidade" . (string)$i . ": " . $Luminosidade[$i]  	. "% </p> <br>
					   <p>Umidade" 		. (string)$i . ": " . $Umidade1[$i] 	   	. "% </p> <br>
					   <p>Temperatura" 	. (string)$i . ": " . $Temperatura1[$i]  	. " Celsius </p> <br> 
					   <p>UmidadeSolo" 	. (string)$i . ": " . $UmidadeSolo[$i] 		. "% </p> <br>";
}

file_put_contents('index.html', $Write);

?>
