<?php
namespace App\Utils;

use Illuminate\Support\Facades\Crypt;


class EToolBox {
    public static $key = "BS2022";
    public static function randomStr($length) {
        return substr(str_shuffle(str_repeat($x='0123456789', ceil($length/strlen($x)) )),1,$length);
    }
    public static function encode64($str)
    {
        return base64_encode(self::randomStr(3).$str);
    }

    
    public static function decode64($hash)
    {
        $code = base64_decode($hash);
        return substr($code,3,strlen($code));
    }

    public static function is_alpha($str){
        return preg_match('/^[\w-]+$/', $str)?true:false;
    }

    public static function aes_encode($str){
        return Crypt::encryptString(self::randomStr(3).$str);
    }
    public static function aes_decode($hash){
        $text = Crypt::decryptString($hash);
        return substr($text,3,strlen($text));
    }

    public static function get_local_time(){
  
        $ip = file_get_contents("http://ipecho.net/plain");
        $url = 'http://ip-api.com/json/'.$ip;
        $tz = file_get_contents($url);
        $tz = json_decode($tz,true)['timezone'];
    
        return $tz;
    }
}