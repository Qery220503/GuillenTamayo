<?php


use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateSucursalesTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $tableName = 'sucursales';

    /**
     * Run the migrations.
     * @table sucursales
     *
     * @return void
     */
    public function up()
    {
        Schema::create($this->tableName, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->increments('id_sucursal');
            $table->string('nombre_sucursal', 70)->nullable();
            $table->string('nro_ruc', 11)->nullable();
            $table->string('razon_social', 100)->nullable();
            $table->string('url_api', 200)->nullable();
            $table->string('token_api', 100)->nullable();
            $table->string('theme', 45)->nullable();
            $table->string('url_logo', 100)->nullable();
            $table->tinyInteger('status')->default(1);
            $table->nullableTimestamps();
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
