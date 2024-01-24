<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class CotizacionCreateRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            "id_anamnesis" => [
                "sometimes",
                Rule::exists("anamnesis", "id_anamnesis")->where("estado", 1)
            ],
            "id_cliente" => [
                "required",
                Rule::exists("clientes", "id_cliente")->where("estado", 1)
            ],
            "receta" => "required",
            "detalle.*.id_precio_lente" => [
                "required",
                "min:1",
                Rule::exists("precios_lentes", "id_precio_lente")->where("estado", 1)
            ]
        ];
    }
}
