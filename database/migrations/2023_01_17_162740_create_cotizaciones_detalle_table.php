<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCotizacionesDetalleTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('cotizaciones_detalle', function (Blueprint $table) {
            $table->increments('id_cotizacion_detalle');
            $table->unsignedInteger('id_cotizacion')->nullable(false);
            $table->unsignedInteger('id_precio_lente')->nullable(false);
            $table->unsignedInteger('id_producto')->nullable(false);
            $table->string('montaje')->nullable(false);
            $table->string('montura')->nullable(false);
            
            $table->foreign('id_precio_lente')
                ->references('id_precio_lente')->on('precios_lentes')
                ->onDelete('no action')
                ->onUpdate('cascade');
            $table->foreign('id_cotizacion')
                ->references('id_cotizacion')->on('cotizaciones')
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
        Schema::dropIfExists('cotizaciones_detalle');
    }
}
