<?php
namespace App\Traits;

trait DatabaseRowsTrait {
    public function SetUpperCase($string){
        return mb_strtoupper($string);
    }
}