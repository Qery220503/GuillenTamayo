<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Carbon;
use App\Models\Comprobante;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class ReceiptsSync extends Command
{
  /**
   * The name and signature of the console command.
   *
   * @var string
   */
  protected $signature = 'command:receipt-sync';

  /**
   * The console command description.
   *
   * @var string
   */
  protected $description = 'Se sincronizaran los comprobantes con el facturador en producción';

  /**
   * Create a new command instance.
   *
   * @return void
   */
  public function __construct()
  {
    parent::__construct();
  }

  /**
   * Execute the console command.
   *
   * @return int
   */
  public function handle()
  {
    DB::beginTransaction();
    try {
      $fecha_actual = Carbon::now()->format('Y-m-d H:i:s');
      $fecha_anterior = Carbon::now()->subDay()->format('Y-m-d H:i:s');
      $comprobantes = Comprobante::with(['sucursal'])->whereIn('id_estado_comprobante', [4, 6])->get();
      foreach ($comprobantes as $comprobante) {

        $token = $comprobante->sucursal['token_api'];
        $ruta = $comprobante->sucursal['url_api'];

        $data = [
          "externail_id" => $comprobante->external_id
        ];
        $data = json_encode($data);
        $ch = curl_init();
        $estados = [
          ['id' => '01', 'description' => 'Registrado', 'estado' => 4],
          ['id' => '03', 'description' => 'Enviado', 'estado' => 6],
          ['id' => '05', 'description' => 'Aceptado', 'estado' => 1],
          ['id' => '07', 'description' => 'Observado', 'estado' => 7],
          ['id' => '09', 'description' => 'Rechazado', 'estado' => 3],
          ['id' => '11', 'description' => 'Anulado', 'estado' => 2],
          ['id' => '13', 'description' => 'Por anular', 'estado' => 5],
        ];
        curl_setopt($ch, CURLOPT_URL, $ruta . "/api/document_status");
        curl_setopt(
          $ch,
          CURLOPT_HTTPHEADER,
          array(
            'Content-Type: application/json',
            'Authorization: Bearer ' . $token
          )
        );
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        $respuesta = curl_exec($ch);
        curl_close($ch);

        Log::info('Fact response: ' . $respuesta);
        $res_decode = json_decode($respuesta, true);

        if ($res_decode['success']) {
          foreach ($estados as $estado) {
            if ($estado['id'] == $res_decode['status_id']) {
              Comprobante::where('id_comprobante', $comprobante->id_comprobante)
                ->update(['id_estado_comprobante' => $estado['estado']]);
              break;
            }
          }
        }
      }
      DB::commit();

      $this->info('Sincronización de comprobantes completada correctamente.');
    } catch (Exception $e) {
      DB::rollBack();
      Log::error('Error wihle syncing billings [' . $e->getLine() . ']: ' . $e->getMessage());
      $this->error('Error sincronizando los comprobantes');
    }
  }
}
