<?php 

$timezone = "PRC";
////////////////////////////////////////////////////
if(function_exists('date_default_timezone_set')){
    date_default_timezone_set($timezone);
}
 //校正时间
 ////////////////////////////////////////////////////
ini_set("display_errors", 0);
function _get($str){
	$val = !empty($_GET[$str]) ? $_GET[$str] : null;
	//或isset($_GET['你的变量'])?$_GET['你的变量']:'';
	return $val;
}

/**
 * 发送post请求
 * @param string $url 请求地址
 * @param array $post_data post键值对数据
 * @return string
 */
function send_get($url) {
 
  $options = array(
    'http' => array(
      'method' => 'GET',
      'header' => 'Content-type:application/x-www-form-urlencoded',
      'timeout' => 15 * 60 // 超时时间（单位:s）
    )
  );
  $context = stream_context_create($options);
  $result = file_get_contents($url, false, $context);
 
  return $result;
}

$domain = _get('dn');//获取数据
$ttl = _get('ttl');//获取数据
if($domain==''){
	exit(" <head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /></head><center>HttpDns服务V1.0<br/>BY:ShenHuo      请传递dn和ttl的值<br/>-|".date("Y-m-d H:i:s")."|-</center>");
}
echo send_get("http://119.29.29.29/d?dn=".$domain."&ttl=".$ttl);

exit;
?>