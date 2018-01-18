<?php
function columnas_size($data=[])
{
    $columnas_size = [];
    foreach ($data as $key => $value) {
        foreach ($value as $key2 => $value2) {
            if(!array_key_exists($key2, $columnas_size)){
                $columnas_size[$key2] = 0;
            }
            if ( $columnas_size[$key2] < strlen($value2)) {
                $columnas_size[$key2] = strlen($value2);
            }
        }
    }
    return $columnas_size;
}
function print_table($csv)
{
    if (is_array($csv) && count($csv)>0) {
        $columnas = $csv[0];
        $data = array_slice($csv,1);
        $columnas_size = columnas_size($csv);
        foreach ($columnas as $key => $value) {
            $columnas[$key] = str_pad(trim($value),$columnas_size[$key],' ');
        }
        $fila = implode("|", $columnas);
        echo "|{$fila}|\n";
        echo str_repeat("-", strlen($fila))."--\n";
        foreach ($data as $key => $value) {
            $tr = [];
            foreach ($value as $key2 => $value2) {
                $tr[$key2] = str_pad($value2,$columnas_size[$key2],' ');
            }
            $fila = implode("|", $tr);
            echo "|{$fila}|\n";
        }
    }
}
// $csv = array_map('str_getcsv', file('paises.csv'));
$csv = [
    ["N","NOMBRES"],
    ["1","carlos"],
    ["2","dario"],
    ["3","rodrigo silva"],
    ["4","miguel juan"],
    ["5","maria"],
    ["55","Mario Navarra"]
];
print_table($csv);
