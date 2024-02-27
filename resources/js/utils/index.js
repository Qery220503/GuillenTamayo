const UTILS = {
    filters: {
        only_numbers($event) {
            let keyCode = $event.keyCode ? $event.keyCode : $event.which;
            if ((keyCode < 48 || keyCode > 57) && keyCode !== 46) {
                $event.preventDefault();
            }
        }
    },

    toastr: {
        success(message, vm) {
            vm.$swal({
                icon: "success",
                title: message,
                showCancelButton: false,
                confirmButtonColor: '#3085d6',
                confirmButtonText: 'Aceptar',

                // toast: true,
                // showConfirmButton: false,
                // timerProgressBar: true,
                // timer: 2500
            });
        },
        error(message, vm) {
            vm.$swal({
                icon: "error",
                title: message,
                showCancelButton: false,
                confirmButtonColor: '#3085d6',
                confirmButtonText: 'Aceptar',
            });
        },
        info(message, vm) {
            vm.$swal({
                icon: "info",
                title: message,
                showCancelButton: false,
                confirmButtonColor: '#3085d6',
                confirmButtonText: 'Aceptar',
            });
        }
    },
    rules: {
        required: [value => !!value || "Campo es requerido"],
        file_size_200kb: [
            value =>
                !value ||
                value.size < 200000 ||
                "El archivo debe pesar menos de 200 kb!"
        ],
        file_size_400kb: [
            value =>
                !value ||
                value.size < 400000 ||
                "El archivo debe pesar menos de 400 kb!"
        ],
        phoneNumberOptional: (value) => {
            if (!value || (value.length === 9 && /^\d+$/.test(value))) {
                return true;  // El valor es válido o el campo es opcional y está vacío
            }
            return 'El valor debe tener una longitud de 9 caracteres y contener solo números';
        },
        only_numbers: [
            value => !!value || "Campo es requerido",
            value => {
                const pattern = /^\d+$/;
                return pattern.test(value) || "Este campo solo admite numeros";
            }
        ],
        required_email: [
            v => !!v || "Campo es requerido",
            v => /.+@.+\..+/.test(v) || "Correo electrónico debe ser válido"
        ],
        fail: [value => false || "El campo es invalido"],
        dni: [v => v.length <= 8 || "Max 8 dígitos"],
        ruc: [v => v.length <= 11 || "Max 11 dígitos"]
    },
    nRules: {
        required: value => !!value || "Este campo es requerido",
        only_numbers: value => {
            const pattern = /^\d+$/;

            return pattern.test(value) || "Este campo solo admite numeros";
        },
        min6: value => {
            return (value && value.length > 6) || "Mínimo 6 caracteres";
        },
        fail: value => value === false || "El campo es invalido",
        url: value => {
            //eslint-disable-next-line
            const pattern = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;

            return (
                pattern.test(value) || "Debes ingresar una url correcta (https://...)"
            );
        },
        password: value => {
            const pattern = /^(?=.*[A-Z]).{8,}$/;

            return (
                pattern.test(value) ||
                "La contraseña debe tener min. 8 caracteres y al menos una mayúscula"
            );
        },
        email: value => {
            const pattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            return pattern.test(value) || "Email no valido";
        },
        min8: value => {
            return (value && value.length > 7) || "Mínimo 8 caracteres";
        },
        min811: value => {
            return (value && value.length > 10) || "Mínimo 11 caracteres";
        },
        maxLength: value => {
            return (value && value.length <= 255) || "Máximo 255 caracteres";
        },
        phoneLength: value => {
          return (value && value.length == 9) || "Se necesitan 9 caracteres";
        },
    },
    const: {
        TIMEOUT: 1000,
        REFRESH: 100
    },
    colors: {
        TEAL: "#22bbd2", //'#167b8a',
        DARK_TEAL: "#0090b2", //'#004f62',
        DEEP_PURPLE: "#a283fd", //'#6546bf',
        DARK_DEEP_PURPLE: "#7f5fd7", //'#433272',
        AMBER: "#ddba67", //'#d6a32b',
        DARK_AMBER: "#f0aa52", //'#ac7b3d',
        DARK_AMBER_1: "#e08c4e", //'#ac6c3d',
        GREEN_ACCENT: "#4fc4a9", //'#039f7b',
        DARK_GREEN_ACCENT: "#4ba997", //'#19705f',

        LIGHT_GREEN: "#A3B867",
        MEDIUM_GREEN: "#8AB379",
        LIGHT_YELLOW: "#E5BE4B"
    },
    formats: {
        formatDate(date) {
            if (!date) return null;

            const [year, month, day] = date.split("-");
            return `${month}/${day}/${year}`;
        }
    }
};
export default UTILS;
