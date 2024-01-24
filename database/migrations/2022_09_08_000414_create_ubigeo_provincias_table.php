<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUbigeoProvinciasTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $tableName = 'ubigeo_provincias';

    /**
     * Run the migrations.
     * @table ubigeo_provincias
     *
     * @return void
     */
    public function up()
    {
        Schema::create($this->tableName, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->increments('id_provincia');
            $table->string('nombre_provincia', 45)->nullable();
            $table->unsignedInteger('id_departamento')->nullable();

            $table->index(["id_departamento"], 'FK_id_departamento_provincia_idx');


            $table->foreign('id_departamento', 'FK_id_departamento_provincia_idx')
                ->references('id_departamento')->on('ubigeo_departamentos')
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
