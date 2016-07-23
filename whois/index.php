<?php
require('vendor/autoload.php');

set_time_limit(0);
$PASS_LENGTH = '3';
// $charset = '0123456789abcdefghijklmnopqrstuvwxyz';

$charset = 'abcdefghijklmnopqrstuvwxyz';
//$charset .= '0123456789';
//$charset .= 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
//$charset .= '~`!@#$%^&*()-_\/\'";:,.+=<>? ';
$domains = array();
function recurse($width, $position, $base_string)
{
    global $charset,$domains;
     
    for ($i = 0; $i < strlen($charset); ++$i) {
        if ($position  < $width - 1) {
            recurse($width, $position + 1, $base_string . $charset[$i]);
        }
        if(strlen($base_string . $charset[$i])==$width){
	        //Checando de que el pass tenga la longitud adecuada y no repetir
            $domains[]= $base_string . $charset[$i].'.com';
            // echo $base_string . $charset[$i] . "\n";            
        } 

    }
}
 
for ($i = 1; $i < $PASS_LENGTH + 1; ++$i) {
    recurse($i, 0, '');
}
// die();
$dominios_save = array();
if (($gestor = fopen("domains.txt", "r")) !== FALSE) {
    while (($datos = fgetcsv($gestor, 1000, ",")) !== FALSE) {
        $numero = count($datos);
        if($numero>0 && $datos[0]!=""){
        	$d = $datos[0];
        	$ini = strpos($d,"-")+2;
        	$size = strpos($d,":")-1 - $ini;
        	$r = substr($d,$ini,$size);
        	// echo $r."\n";
        	$dominios_save[] = $r;
        }
    }
    fclose($gestor);
}
asort($dominios_save);

// echo '<pre>';
// die(var_dump($dominios_save));
// $whois = new whois();
// $result = $whois->lookup("az.com",false);
// echo '<pre>';
// die(var_dump($result));

$whois = new whois();
// $domains  = array("az.com");
$total = count($domains);
$count = count($dominios_save);
$fichero = 'domains.txt';
// file_put_contents($fichero, date("d-m-Y H:i:s")."\n", FILE_APPEND | LOCK_EX);
foreach ($domains as $key => $query) {
	if(array_search($query,$dominios_save)!==false) {
		echo $query." - existe\n";
		continue;
	}
	// usleep(1000000);
	$count++;
	// echo $count.'/'.$total.' - '.$query."\n";
	$result = $whois->lookup($query,false);
	$res = $count.'/'.$total.' - '.$query." : null\n";
	if($result){
		$res = $count.'/'.$total.' - '.$query.' : '.$result['regrinfo']['registered']."\n";
	}
	echo $res;
	file_put_contents($fichero, $res, FILE_APPEND | LOCK_EX);
}