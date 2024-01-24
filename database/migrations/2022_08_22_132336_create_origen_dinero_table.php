<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOrigenDineroTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $tableName = 'origen_dinero';

    /**
     * Run the migrations.
     * @table origen_dinero
     *
     * @return void
     */
    public function up()
    {
        Schema::create($this->tableName, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->increments('id_origen_dinero');
            $table->string('nombre_origen', 45)->nullable();
            $table->string('descripcion_origen', 250)->nullable();
            $table->unsignedInteger('id_sucursal')->nullable();
            $table->timestamps();

            $table->index(["id_sucursal"], 'FK_origen_dinero_sucursal_idx');


            $table->foreign('id_sucursal', 'FK_origen_dinero_sucursal_idx')
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
        Schema::dropIfExists($this->tableName);
    }
}
