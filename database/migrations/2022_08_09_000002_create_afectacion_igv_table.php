<?php


use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAfectacionIgvTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $tableName = 'afectacion_igv';

    /**
     * Run the migrations.
     * @table afectacion_igv
     *
     * @return void
     */
    public function up()
    {
        Schema::create($this->tableName, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->increments('cod_afectacion');
            $table->string('descripcion', 150)->nullable();
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
