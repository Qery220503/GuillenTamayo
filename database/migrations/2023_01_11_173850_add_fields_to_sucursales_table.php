<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddFieldsToSucursalesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */

    public function up()
    {
        Schema::table('sucursales', function (Blueprint $table) {
            $table->after('razon_social', function (Blueprint $table){
                $table->string('cod_domicilio_fiscal')->nullable(false)->default("-");
                $table->string('direccion_fiscal')->nullable(false)->default("-");
                $table->string('direccion_comercial')->nullable(false)->default("-");
                $table->string('email')->nullable(false)->default("-");
                $table->string('departamento')->nullable(false)->default("-");
                $table->string('provincia')->nullable(false)->default("-");
                $table->string('distrito')->nullable(false)->default("-");
                $table->string('direccion_web')->nullable(false)->default("-");
                $table->string('nro_cuenta_bancario')->nullable(false)->default("-");
                $table->string('cci_bancario')->nullable(false)->default("-");
                $table->string('telefono')->nullable(false)->default("-");
            });
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('sucursales', function (Blueprint $table) {
            $table->dropColumn('cod_domicilio_fiscal');
            $table->dropColumn('direccion_fiscal');
            $table->dropColumn('direccion_comercial');
            $table->dropColumn('email');
            $table->dropColumn('departamento');
            $table->dropColumn('provincia');
            $table->dropColumn('distrito');
            $table->dropColumn('direccion_web');
            $table->dropColumn('nro_cuenta_bancario');
            $table->dropColumn('cci_bancario');
            $table->dropColumn('telefono');
        });
    }
}
