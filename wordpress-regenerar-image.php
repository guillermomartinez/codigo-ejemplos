<?php
ini_set("display_errors", "1");
ini_set("memory_limit", "-1");
ini_set('max_execution_time', 0);
error_reporting(E_ALL);
require_once('../../wp-blog-header.php');
require_once('../../wp-includes/registration.php');
require_once('../../wp-admin/includes/post.php');
require_once('../../wp-admin/includes/taxonomy.php');
require_once('../../wp-admin/includes/image.php');
global $wpdb;
$init = time();
$thumbnails = get_intermediate_image_sizes();
$attachments = get_children( array(
    'post_type' => 'attachment',
    'post_mime_type' => 'image',
    'numberposts' => -1,
    'post_status' => null,
    'post_parent' => null,
    'output' => 'object',
    ) );
echo "Total al inicio: ".count($attachments)."<br>";
$limit = 0;
$i=0;
$count=0;
foreach ($attachments as $key => $attachment) {
    $count++;
    if( $limit > 0 && $count > $limit ) break;
    $id = $attachment->ID;
    $fullsizepath = get_attached_file( $id );
    $msg = "$fullsizepath";
    if ( FALSE !== $fullsizepath && @file_exists($fullsizepath) ) {
        set_time_limit( 30 );
        wp_update_attachment_metadata( $id, wp_generate_attachment_metadata_custom( $id, $fullsizepath, $thumbnails ) );
        $msg .= " | OK";
        $i++;
        // if(wp_get_attachment_thumb_url( $id )){
        //     $msg .= " | OK";
        //     $i++;
        // }
    }else{
        $msg .= " | NO";
    }
    echo "$msg <br>";
}
echo "Total al fin: $i<br>";
$tiempo = time() - $init;
$tiempo = gmdate("H:i:s", $tiempo);
echo 'Tiempo total: '.$tiempo;
?>
