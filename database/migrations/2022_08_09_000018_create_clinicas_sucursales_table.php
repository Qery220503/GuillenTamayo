
<?php


use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateClinicasSucursalesTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $tableName = 'clinicas_sucursales';

    /**
     * Run the migrations.
     * @table clinicas_sucursales
     *
     * @return void
     */
    public function up()
    {
        Schema::create($this->tableName, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->increments('id_clini_suc');
            $table->unsignedInteger('id_clinica')->nullable();
            $table->unsignedInteger('id_sucursal')->nullable();
            $table->tinyInteger('status')->default(1);

            $table->index(["id_sucursal"], 'FK_sucursal_clinica_idx');

            $table->index(["id_clinica"], 'FK_sucuresal_idclinica_idx');


            $table->foreign('id_sucursal', 'FK_sucursal_clinica_idx')
                ->references('id_sucursal')->on('sucursales')
                ->onDelete('no action')
                ->onUpdate('no action');

            $table->foreign('id_clinica', 'FK_sucuresal_idclinica_idx')
                ->references('id_clinica')->on('clinicas')
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