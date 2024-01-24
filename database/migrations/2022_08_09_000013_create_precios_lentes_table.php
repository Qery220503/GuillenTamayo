
<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePreciosLentesTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $tableName = 'precios_lentes';

    /**
     * Run the migrations.
     * @table precios_lentes
     *
     * @return void
     */
    public function up()
    {
        Schema::create($this->tableName, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->increments('id_precio_lente');
            $table->string('modelo', 60)->nullable();
            $table->string('fabricacion', 60)->nullable();
            $table->string('material', 60)->nullable();
            $table->string('serie', 60)->nullable();
            $table->string('tratamiento', 60)->nullable();
            $table->string('fotocromatico', 60)->nullable();
            $table->string('color_fotocromatico', 60)->nullable();
            $table->string('laboratorio', 60)->nullable();
            $table->string('nombre_propio', 250)->nullable();
            $table->string('nombre_laboratorio', 250)->nullable();
            $table->decimal('precio_compra', 11, 2)->nullable();
            $table->decimal('precio_venta', 11, 2)->nullable();
            $table->unsignedInteger('id_sucursal')->nullable();
            $table->tinyInteger('es_trio')->nullable()->default('0')->comment('lente pertenece a los contabilizados como trio? 1= SI, 0 = no');
            $table->tinyInteger('estado')->nullable()->default('1');

            $table->index(["id_sucursal"], 'FK_sucursal_preciolente_idx');
            $table->nullableTimestamps();


            $table->foreign('id_sucursal', 'FK_sucursal_preciolente_idx')
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