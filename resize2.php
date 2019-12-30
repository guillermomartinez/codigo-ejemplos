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
$width_max = 1400;
$height = null;
$typeImage = null;
$i = $n = 0;
$calidad = 83;
foreach (glob("{$images}/*") as $key => $filename) {
  $n++;
  echo basename($filename).": ";
  $image_size = getimagesize($filename);
  $filesize = filesize($filename); // bytes
  $filesize = round($filesize / 1024, 2);
  if (count($image_size)>0) {
    echo $image_size[0]."x".$image_size[1]." ".$filesize."KB | ";
    $path_original = $filename;
    $imagen_ext = getExtension($filename);
    $path_imagen_new = str_replace($images, $result, $filename);
    if($typeImage){
      $path_imagen_new = removeExtension($path_imagen_new).'.'.$typeImage;
      $imagen_ext = $typeImage;
    }
    if ($image_size[0] > $width_max) {
      Imagen::open($path_original)
      ->scaleResize($width_max,$height)
      ->save($path_imagen_new,$imagen_ext,$calidad);
      $image_size_new = getimagesize($path_imagen_new);
    }else{
      Imagen::open($path_original)
      ->scaleResize($image_size[0],$height)
      ->save($path_imagen_new,$imagen_ext,$calidad);
      $image_size_new = getimagesize($path_imagen_new);
    }
    if (count($image_size_new)>0) {
      $i++;
      $filesize_new = filesize($path_imagen_new); // bytes
      $filesize_new = round($filesize_new / 1024, 2);
      echo $image_size_new[0]."x".$image_size_new[1]." ".$filesize_new."KB";
    }
  }
  echo "\n";
}
echo "Procesadas: $i/$n";
?>
