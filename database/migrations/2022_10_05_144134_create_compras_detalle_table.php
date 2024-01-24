<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateComprasDetalleTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('compras_detalle', function (Blueprint $table) {
            $table->increments('id_compra_detalle');
            $table->unsignedInteger('id_compra')->nullable();
            $table->string('codigo_producto', 255)->nullable();
            $table->string('nombre_producto', 255)->nullable();
            $table->string('unidad_medida', 255)->nullable();
            $table->decimal('cantidad', 11, 2)->default(0.00);
            $table->decimal('precio_compra', 11, 2)->default(0.00);
            $table->decimal('precio_total', 11, 2)->default(0.00);
            $table->timestamps();            
        
            $table->foreign('id_compra', 'FK_compras_detalle_compra_idx')
                ->references('id_compra')->on('compras')
                ->onDelete('no action')
                ->onUpdate('no action');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('compras_detalle');
    }
}
