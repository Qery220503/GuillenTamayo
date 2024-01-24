
<?php


use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateClientesTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $tableName = 'clientes';

    /**
     * Run the migrations.
     * @table clientes
     *
     * @return void
     */
    public function up()
    {
        Schema::create($this->tableName, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->increments('id_cliente');
            $table->unsignedInteger('cod_tipo_doc')->nullable();
            $table->string('nombre_razon_social')->nullable();
            $table->date('fecha_nacimiento')->nullable();
            $table->string('telefono', 15)->nullable();
            $table->string('telefono_adic', 15)->nullable();
            $table->string('email', 80)->nullable();
            $table->unsignedInteger('id_rubro_trabajo')->nullable();
            $table->unsignedInteger('id_ocupacion')->nullable();
            $table->unsignedInteger('id_departamento')->nullable();
            $table->unsignedInteger('id_provincia')->nullable();
            $table->unsignedInteger('id_distrito')->nullable();
            $table->string('direccion')->nullable();
            $table->tinyInteger('lista_negra')->nullable()->comment('usuario esta en lista ngra? 1=SI, 0=NO');
            $table->tinyInteger('estado')->default(1);
            $table->unsignedInteger('id_sucursal')->nullable();

            $table->index(["cod_tipo_doc"], 'FK_codigo_doc_cliente_idx');

            $table->index(["id_sucursal"], 'FK_sucursal_cliente_idx');

            $table->index(["id_rubro_trabajo"], 'FK_ruburos_cliente_idx');

            $table->index(["id_ocupacion"], 'FK_ocupacion_cliente_idx');
            $table->nullableTimestamps();


            $table->foreign('cod_tipo_doc', 'FK_codigo_doc_cliente_idx')
                ->references('id_tipo_documento')->on('tipos_documentos')
                ->onDelete('no action')
                ->onUpdate('no action');

            $table->foreign('id_sucursal', 'FK_sucursal_cliente_idx')
                ->references('id_sucursal')->on('sucursales')
                ->onDelete('no action')
                ->onUpdate('no action');

            $table->foreign('id_rubro_trabajo', 'FK_ruburos_cliente_idx')
                ->references('id_rubro_trabajo')->on('rubros_trabajo')
                ->onDelete('no action')
                ->onUpdate('no action');

            $table->foreign('id_ocupacion', 'FK_ocupacion_cliente_idx')
                ->references('id_ocupacion')->on('ocupaciones')
                ->onDelete('no action')
                ->onUpdate('no action');

            $table->foreign('id_distrito', 'FK_distrito_cliente_idx')
                ->references('id_distrito')->on('ubigeo_distritos')
                ->onDelete('no action')
                ->onUpdate('no action');

            $table->foreign('id_provincia', 'FK_provincia_cliente_idx')
                ->references('id_provincia')->on('ubigeo_provincias')
                ->onDelete('no action')
                ->onUpdate('no action');

            $table->foreign('id_departamento', 'FK_departamento_cliente_idx')
                ->references('id_departamento')->on('ubigeo_departamentos')
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