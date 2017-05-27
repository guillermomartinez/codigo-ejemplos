<?php
function fun_alldump()
{
    if (isset($_SERVER)) {
        $fecha = new DateTime(null, new DateTimeZone('UTC'));
        $data = [];
        $dir_log = $_SERVER['DOCUMENT_ROOT'].'/../fun';
        if( !realpath($dir_log) ) mkdir($dir_log, 0750);
        $file_log = $dir_log.'/fun_alldump.log';
        $data["REMOTE_ADDR"] = (array_key_exists('REMOTE_ADDR', $_SERVER)) ? $_SERVER['REMOTE_ADDR'] : '';
        if (array_key_exists('REQUEST_TIME', $_SERVER)) {
            $fecha->setTimestamp($_SERVER["REQUEST_TIME"]);
            $fecha->setTimezone(new DateTimeZone('America/Lima'));
            $data["REQUEST_TIME"] = $fecha->format('d/m/Y H:i:s');
        }else{
            $data["REQUEST_TIME"] = '';
        }
        $data["REQUEST_METHOD"] = (array_key_exists('REQUEST_METHOD', $_SERVER)) ? $_SERVER['REQUEST_METHOD'] : '';
        $data["REQUEST_URI"] = (array_key_exists('REQUEST_URI', $_SERVER)) ? $_SERVER['REQUEST_URI'] : '';
        $data["HTTP_REFERER"] = (array_key_exists('HTTP_REFERER', $_SERVER)) ? $_SERVER['HTTP_REFERER'] : '';
        $data["HTTP_USER_AGENT"] = (array_key_exists('HTTP_USER_AGENT', $_SERVER)) ? $_SERVER['HTTP_USER_AGENT'] : '';
        $data["POST"] = "";
        if ( isset($_POST) && count($_POST)>0 ) {
            $data["POST"] = print_r($_POST,true);
        }
        $data["FILES"] = "";
        if ( isset($_FILES) && count($_FILES)>0) {
            $data["FILES"] = print_r($_FILES,true);
        }
        $data = implode($data,"|")."\n";
        file_put_contents($file_log, $data, FILE_APPEND | LOCK_EX);
    }
}
add_action( 'wp_loaded', 'fun_alldump' );
?>
