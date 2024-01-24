<?php


use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateClinicasTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $tableName = 'clinicas';

    /**
     * Run the migrations.
     * @table clinicas
     *
     * @return void
     */
    public function up()
    {
        Schema::create($this->tableName, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->increments('id_clinica');
            $table->string('nombre_clinica', 120)->nullable();
            $table->string('telefono_clinica', 100)->nullable();
            $table->string('email_clinica', 100)->nullable();
            $table->integer('enviar_correos')->nullable()->default('1')->comment('Clinica desea recibir correos informativos? 1=SI, 0=NO');
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
