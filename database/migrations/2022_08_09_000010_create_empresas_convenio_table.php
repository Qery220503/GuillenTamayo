<?php


use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateEmpresasConvenioTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $tableName = 'empresas_convenio';

    /**
     * Run the migrations.
     * @table empresas_convenio
     *
     * @return void
     */
    public function up()
    {
        Schema::create($this->tableName, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->increments('id_empresa_convenio');
            $table->string('nombre_empresa', 80)->nullable();
            $table->string('direccion_empresa', 250)->nullable();
            $table->string('ruc_empresa', 11)->nullable();
            $table->string('telefono_empresa', 150)->nullable();
            $table->string('email_empresa', 45)->nullable();
            $table->tinyInteger('enviar_correos')->nullable()->default('1')->comment('Empresa desea recibir correos informativos? 1=SI, 0=NO');
            $table->tinyInteger('estado')->default(1);
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
