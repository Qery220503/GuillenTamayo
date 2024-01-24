<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateComprasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('compras', function (Blueprint $table) {
            $table->increments('id_compra');
            $table->unsignedInteger('id_proveedor')->nullable();
            $table->string('nombre_proveedor', 255)->nullable();
            $table->string('guia_factura', 255)->nullable();
            $table->string('fecha', 255)->nullable();
            $table->unsignedInteger('id_origen_dinero')->nullable();
            $table->unsignedInteger('id_sucursal')->nullable();
            $table->decimal('total', 11, 2)->default(0.00);
            $table->decimal('subtotal', 11, 2)->default(0.00);
            $table->decimal('igv', 11, 2)->default(0.00);
            $table->tinyInteger('condicion_pago')->default(0);
            $table->enum('deuda_tipo', ['total', 'saldo'])->default('total');
            $table->decimal('deuda_total_abonado', 11, 2)->default(0.00);
            $table->decimal('deuda_saldo', 11, 2)->default(0.00);
            $table->timestamps();

        
            $table->foreign('id_proveedor', 'FK_compras_proveedor_idx')
                ->references('id_proveedor')->on('proveedores')
                ->onDelete('no action')
                ->onUpdate('no action');

            $table->foreign('id_origen_dinero', 'FK_compras_origen_dinero_idx')
                ->references('id_origen_dinero')->on('origen_dinero')
                ->onDelete('no action')
                ->onUpdate('no action');

            $table->foreign('id_sucursal', 'FK_compras_sucursal_idx')
                ->references('id_sucursal')->on('sucursales')
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
        Schema::dropIfExists('compras');
    }
}
