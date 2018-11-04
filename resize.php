<?php
include 'vendor/autoload.php';
use Gregwar\Image\Image as Imagen;
function getExtension($nameFile){
    $extension = substr( $nameFile, ( strrpos($nameFile, '.') + 1 ) ) ;
    $extension = strtolower( $extension ) ;
    return $extension;
}
function removeExtension($filename)
{
    return substr($filename,0,strrpos( $filename, '.' ) ) ;
}
$images = "./images";
$result = "./result";
$width = 1024;
$height = 1024;
$typeImage = null;

foreach (glob("{$images}/*") as $key => $filename) {
    echo $filename;
    echo "\n";
    $filename_original = $filename;
    $filename = strtolower($filename);
    $imagen_ext = getExtension($filename);
    $path_imagen_new = str_replace($images, $result, $filename);
    if($typeImage){
        $path_imagen_new = removeExtension($path_imagen_new).'.'.$typeImage;
        $imagen_ext = $typeImage;
    }
    Imagen::open($filename_original)
    ->scaleResize($width,$height)
    ->save($path_imagen_new,$imagen_ext,90);
    echo $path_imagen_new;
    echo "\n";
}
?>
