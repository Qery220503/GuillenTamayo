<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUbigeoDistritosTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $tableName = 'ubigeo_distritos';

    /**
     * Run the migrations.
     * @table ubigeo_distritos
     *
     * @return void
     */
    public function up()
    {
        Schema::create($this->tableName, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->increments('id_distrito');
            $table->string('nombre_distrito', 45)->nullable();
            $table->unsignedInteger('id_provincia')->nullable();
            $table->unsignedInteger('id_departamento')->nullable();

            $table->index(["id_departamento"], 'FK_id_departamento_distrito_idx');

            $table->index(["id_provincia"], 'FK_id_provincia_distrito_idx');


            $table->foreign('id_departamento', 'FK_id_departamento_distrito_idx')
                ->references('id_departamento')->on('ubigeo_departamentos')
                ->onDelete('no action')
                ->onUpdate('no action');

            $table->foreign('id_provincia', 'FK_id_provincia_distrito_idx')
                ->references('id_provincia')->on('ubigeo_provincias')
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
