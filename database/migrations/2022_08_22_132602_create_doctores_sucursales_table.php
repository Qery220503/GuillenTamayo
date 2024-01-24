<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDoctoresSucursalesTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $tableName = 'doctores_sucursales';

    /**
     * Run the migrations.
     * @table doctores_sucursales
     *
     * @return void
     */
    public function up()
    {
        Schema::create($this->tableName, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->increments('id_empresa_sucursal');
            $table->unsignedInteger('id_doctor')->nullable();
            $table->unsignedInteger('id_sucursal')->nullable();
            $table->tinyInteger('status')->default(1);

            $table->index(["id_doctor"], 'FK_sucursal_doctor_idx');

            $table->index(["id_sucursal"], 'FK_sucursal_idsucursal_idx');


            $table->foreign('id_doctor', 'FK_sucursal_doctor_idx')
                ->references('id_doctor')->on('doctores')
                ->onDelete('no action')
                ->onUpdate('no action');

            $table->foreign('id_sucursal', 'FK_sucursal_idsucursal_idx')
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
