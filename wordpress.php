<?php
add_filter('manage_edit-dir_proyectos_columns', 'add_new_dir_proyectos_columns');
function add_new_dir_proyectos_columns($dir_proyectos_columns) {
    $new_columns['cb'] = '<input type="checkbox" />';
    $new_columns['title'] = _x('Titulo', 'column name');
    $new_columns['fecha_inicio'] = __('Fecha Inicio'); 
    $new_columns['date'] = _x('Fecha', 'column name');
    return $new_columns;
}

add_action('manage_dir_proyectos_posts_custom_column', 'manage_dir_proyectos_columns', 10, 2);
function manage_dir_proyectos_columns($column_name, $id) {
    global $wpdb;
    switch ($column_name) {
    case 'fecha_inicio':
    	$fecha_inicio = get_field('fecha_inicio', $post_id,false);
    	if( strlen($fecha_inicio)>0){	    	
	    	$date = DateTime::createFromFormat('Ymd', $fecha_inicio);
	    	if($date){
	    		echo $date->format('d/m/Y');	    		
	    	}    		
    	}
      	// echo  date( _x( 'F d, Y', 'Event date format', 'textdomain' ), strtotime( $fecha_inicio ) );
        break;
    default:
        break;
    } // end switch
} 
