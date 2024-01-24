
<?php


use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateEmpresasConvenioSucursalesTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $tableName = 'empresas_convenio_sucursales';

    /**
     * Run the migrations.
     * @table empresas_convenio_sucursales
     *
     * @return void
     */
    public function up()
    {
        Schema::create($this->tableName, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->increments('id_empresa_sucursal');
            $table->unsignedInteger('id_empresa_convenio')->nullable();
            $table->unsignedInteger('id_sucursal')->nullable();
            $table->tinyInteger('status')->default(1);

            $table->index(["id_sucursal"], 'FK_empresa_sucursal_idx');

            $table->index(["id_empresa_convenio"], 'FK_empresa_empresaid_idx');


            $table->foreign('id_sucursal', 'FK_empresa_sucursal_idx')
                ->references('id_sucursal')->on('sucursales')
                ->onDelete('no action')
                ->onUpdate('no action');

            $table->foreign('id_empresa_convenio', 'FK_empresa_empresaid_idx')
                ->references('id_empresa_convenio')->on('empresas_convenio')
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