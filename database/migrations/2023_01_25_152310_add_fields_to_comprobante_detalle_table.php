<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddFieldsToComprobanteDetalleTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('comprobantes_detalles', function (Blueprint $table) {
            $table->tinyInteger("item_type")->nullable()->after("codigo_item"); 
            $table->unsignedInteger("id_unidad_medida")->nullable()->after("item_type");
            /*
                null => Ninguno
                1 => Producto
                2 => Precio Lentes
                3 => Servicios
            */
            $table->foreign('id_unidad_medida')
                ->references('id_unidad_medida')->on('unidades_medida')
                ->onDelete('no action')
                ->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('comprobantes_detalles', function (Blueprint $table) {
            $table->dropColumn("item_type");
        });
    }
}
