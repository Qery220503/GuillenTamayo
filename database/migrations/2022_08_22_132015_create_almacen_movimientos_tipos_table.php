<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAlmacenMovimientosTiposTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $tableName = 'almacen_movimientos_tipos';

    /**
     * Run the migrations.
     * @table almacen_movimientos_tipos
     *
     * @return void
     */
    public function up()
    {
        Schema::create($this->tableName, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->increments('id_tipo_movimiento');
            $table->string('tipo_movimiento', 45)->nullable();
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
