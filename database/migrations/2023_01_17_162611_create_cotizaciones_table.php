<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCotizacionesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */

     /*
            protected $table = 'cotizaciones';
    protected $primaryKey = 'id_cotización';
    protected $fillable = [
        'id_serie',
        'refraccion_lejos',
        'refraccion_cerca',
        'id_anamnesis',
        'estado'
    ];
     */
    public function up()
    {
        Schema::create('cotizaciones', function (Blueprint $table) {
            $table->increments('id_cotizacion');
            $table->unsignedInteger('id_serie')->nullable(false);
            $table->unsignedInteger('id_anamnesis')->nullable(false);
            $table->unsignedBigInteger('correlativo')->nullable(false);
            $table->text('refraccion_lejos')->nullable(false);
            $table->text('refraccion_cerca')->nullable(false);
            $table->tinyInteger('estado')->default(1)->nullable(false);
            $table->timestamps();

            $table->foreign('id_serie')
                ->references('id_serie')->on('comprobantes_series')
                ->onDelete('no action')
                ->onUpdate('cascade');

            $table->foreign('id_anamnesis')
                ->references('id_anamnesis')->on('anamnesis')
                ->onDelete('no action')
                ->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('cotizaciones');
    }
}
