<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePagoDeudaTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('deuda_compra_pagos', function (Blueprint $table) {
            $table->increments('id_pago_deuda');
            $table->unsignedInteger('id_compra')->nullable();
            $table->decimal('monto_abonado', 11, 2)->default(0.00);
            $table->decimal('saldo', 11, 2)->default(0.00);
            $table->string('fecha', 255)->nullable();
            $table->string('descripcion', 255)->nullable();
            $table->string('nro_operacion', 255)->nullable();
            $table->unsignedInteger('id_origen_dinero')->nullable();

            $table->timestamps();
            
            $table->foreign('id_compra', 'FK_pago_deuda_compra_idx')
                ->references('id_compra')->on('compras')
                ->onDelete('no action')
                ->onUpdate('no action');
                
            $table->foreign('id_origen_dinero', 'FK_pago_deuda_origen_dinero_idx')
                ->references('id_origen_dinero')->on('origen_dinero')
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
        Schema::dropIfExists('deuda_compra_pagos');
    }
}
