<template>
    <div>
        <v-card class="text-center pa-1">
            <v-card-title class="justify-center display-1 mb-2">Inicia Sesión</v-card-title>
            <v-card-subtitle>Ingresa tu usuario y contraseña para iniciar sesión</v-card-subtitle>

            <!-- sign in form -->
            <v-card-text>
                <v-form ref="form" v-model="isFormValid" lazy-validation>
                    <v-text-field
                        v-model="email"
                        :rules="emailRules"
                        :validate-on-blur="false"
                        :error="error"
                        :label="$t('login.email')"
                        name="email"
                        outlined
                        @keyup.enter.prevent="submit"
                        @change="resetErrors"
                    ></v-text-field>
                    <v-text-field
                        v-model="password"
                        :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
                        :rules="[rules.required]"
                        :type="showPassword ? 'text' : 'password'"
                        :error="error"
                        :error-messages="errorMessages"
                        :label="$t('login.password')"
                        name="password"
                        outlined
                        @change="resetErrors"
                        @keyup.enter.prevent="submit"
                        @click:append="showPassword = !showPassword"
                    ></v-text-field>
                    <v-btn
                        :loading="isLoading"
                        :disabled="isSignInDisabled"
                        block
                        x-large
                        color="secondary"
                        @click="submit">
                        {{ $t('login.button') }}
                    </v-btn>
                    <div v-if="errorProvider" class="error--text">{{ errorProviderMessages }}</div>
                </v-form>
            </v-card-text>
        </v-card>
    </div>
</template>

<script>
/*
|---------------------------------------------------------------------
| Sign In Page Component
|---------------------------------------------------------------------
|
| Sign in template for user authentication into the application
|
*/
export default {
    data() {
        return {
            // sign in buttons
            isLoading: false,
            isSignInDisabled: false,

            // form
            isFormValid: true,
            email: '',
            password: '',

            // form error
            error: false,
            errorMessages: '',

            errorProvider: false,
            errorProviderMessages: '',

            // show password field
            showPassword: false,

            providers: [{
                id: 'google',
                label: 'Google',
                isLoading: false
            }, {
                id: 'facebook',
                label: 'Facebook',
                isLoading: false
            }],

            // input rules
            rules: {
                required: (value) => (value && Boolean(value)) || 'Campo Obligatorio'
            },

            emailRules: [
                (v) => !!v || 'Correo Electrónico es obligatorio',
                (v) => /.+@.+\..+/.test(v) || 'Correo Electrónico debe ser válido'
            ],
        }
    },
    async mounted(){
        //
    },
    methods: {
        submit() {
            if (this.$refs.form.validate()) {
                this.isLoading = true
                this.isSignInDisabled = true
                this.login ({
                    email:this.email,
                    password:this.password
                });
            }
        },
        async login( userCredentials ){
            try{
                const response = await API.users.apiLogin(userCredentials);
                const res_data = response.data;
                console.log(res_data);
                localStorage.setItem('user_token', res_data.user_token);
                localStorage.setItem('user_id',res_data.user_data.id);
                localStorage.setItem('user_data',JSON.stringify(res_data.user_data));
                localStorage.setItem('user_permissions',JSON.stringify(res_data.permissions));
                this.$root.$emit("update_user",res_data.user_data);
                location.reload();

            }catch(e){
                console.error(e);
                let error_messages = e.response.data.errors;
                for (let i in error_messages) {
                    UTILS.toastr.error(error_messages[i][0], this);
                }

            } finally {
                this.isLoading = false;
                this.isSignInDisabled = false;
            }
        },
        resetErrors() {
            this.error = false
            this.errorMessages = ''

            this.errorProvider = false
            this.errorProviderMessages = ''
        }
    },
}
</script>
