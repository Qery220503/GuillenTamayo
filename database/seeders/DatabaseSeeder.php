<?php

namespace Database\Seeders;

use App\Models\TipoComprobante;
use App\Models\UnidadMedida;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        /*
        TipoComprobante::insert(
            [
                ['nombre_tipo_documento' => 'COTIZACIÓN'],
                ['nombre_tipo_documento' => 'GUÍA DE REMISIÓN'],
                ['nombre_tipo_documento' => 'NOTA DE CREDITO'],
            ]
        );
        */
        UnidadMedida::insert([
            ['nombre_unidad_medida' => 'UND', 'codigo_sunat' => 'NIU'],
            ['nombre_unidad_medida' => 'PAR', 'codigo_sunat' => 'PR'],
            ['nombre_unidad_medida' => 'SERVICIO', 'codigo_sunat' => 'ZZ'],

        ]);
        
    }
}
