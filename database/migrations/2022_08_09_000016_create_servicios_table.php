
<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateServiciosTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $tableName = 'servicios';

    /**
     * Run the migrations.
     * @table servicios
     *
     * @return void
     */
    public function up()
    {
        Schema::create($this->tableName, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->increments('id_servicio');
            $table->string('nombre_servicio', 150)->nullable();
            $table->decimal('precio_compra', 11, 2)->nullable();
            $table->decimal('precio_venta', 11, 2)->nullable();
            $table->unsignedInteger('cod_afectacion_igv')->nullable();
            $table->unsignedInteger('id_sucursal')->nullable();
            $table->tinyInteger('estado')->default(1);

            $table->index(["id_sucursal"], 'FK_servicio_id_sucursal_idx');

            $table->index(["cod_afectacion_igv"], 'FK_cod_igv_servicio_idx');
            $table->nullableTimestamps();


            $table->foreign('id_sucursal', 'FK_servicio_id_sucursal_idx')
                ->references('id_sucursal')->on('sucursales')
                ->onDelete('no action')
                ->onUpdate('no action');

            $table->foreign('cod_afectacion_igv', 'FK_cod_igv_servicio_idx')
                ->references('cod_afectacion')->on('afectacion_igv')
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
