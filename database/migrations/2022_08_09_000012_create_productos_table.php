
<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateProductosTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $tableName = 'productos';

    /**
     * Run the migrations.
     * @table productos
     *
     * @return void
     */
    public function up()
    {
        Schema::create($this->tableName, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->increments('id_producto');
            $table->string('nombre_producto', 150)->nullable();
            $table->unsignedInteger('id_marca')->nullable();
            $table->unsignedInteger('id_categoria')->nullable();
            $table->string('codigo_varilla', 50)->nullable();
            $table->string('codigo_sunat', 15)->nullable();
            $table->char('rango', 1)->nullable()->comment('Cara, Intermedia, Económica');
            $table->unsignedInteger('id_material')->nullable();
            $table->unsignedInteger('id_tipo_aro')->nullable();
            $table->unsignedInteger('id_forma_montura')->nullable();
            $table->json('tipo_rostro')->nullable();
            $table->tinyInteger('genero')->nullable()->comment('1=varon, 2=dama, 3=niño, 4=niña, 5=unisex');
            $table->json('adicionales')->nullable();
            $table->string('descripcion', 80)->nullable();
            $table->tinyInteger('producto_reto')->nullable()->comment('1=SI 0=NO');
            $table->tinyInteger('sobrelentes')->nullable()->comment('1=SI, 0=NO');
            $table->string('diagonal', 10)->nullable();
            $table->string('puente', 10)->nullable();
            $table->string('varilla', 10)->nullable();
            $table->unsignedInteger('cod_afectacion_igv')->nullable();
            $table->decimal('precio_compra', 11, 2)->nullable();
            $table->decimal('precio_venta', 11, 2)->nullable();
            $table->integer('stock')->nullable();
            $table->tinyInteger('estado')->default(1);
            $table->unsignedInteger('id_sucursal')->nullable();

            $table->index(["id_marca"], 'FK_producto_marcaid_idx');

            $table->index(["id_categoria"], 'FK_producto_categoriaid_idx');

            $table->index(["id_material"], 'FK_producto_materialid_idx');

            $table->index(["id_tipo_aro"], 'FK_producto_tipoaroid_idx');

            $table->index(["id_forma_montura"], 'FK_producto_formamontura_idx');

            $table->index(["cod_afectacion_igv"], 'FK_producto_afectacionigv_idx');

            $table->index(["id_sucursal"], 'FK_producto_sucursalid_idx');
            $table->nullableTimestamps();


            $table->foreign('id_marca', 'FK_producto_marcaid_idx')
                ->references('id_marca_producto')->on('productos_marcas')
                ->onDelete('no action')
                ->onUpdate('no action');

            $table->foreign('id_categoria', 'FK_producto_categoriaid_idx')
                ->references('id_producto_categoria')->on('productos_categorias')
                ->onDelete('no action')
                ->onUpdate('no action');

            $table->foreign('id_material', 'FK_producto_materialid_idx')
                ->references('id_material')->on('productos_material')
                ->onDelete('no action')
                ->onUpdate('no action');

            $table->foreign('id_tipo_aro', 'FK_producto_tipoaroid_idx')
                ->references('id_tipo_aro')->on('productos_tipo_aro')
                ->onDelete('no action')
                ->onUpdate('no action');

            $table->foreign('id_forma_montura', 'FK_producto_formamontura_idx')
                ->references('id_forma_montura')->on('productos_forma_montura')
                ->onDelete('no action')
                ->onUpdate('no action');

            $table->foreign('cod_afectacion_igv', 'FK_producto_afectacionigv_idx')
                ->references('cod_afectacion')->on('afectacion_igv')
                ->onDelete('no action')
                ->onUpdate('no action');

            $table->foreign('id_sucursal', 'FK_producto_sucursalid_idx')
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
