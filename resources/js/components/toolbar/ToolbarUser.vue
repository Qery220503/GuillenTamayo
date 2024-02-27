<template>
    <v-menu offset-y left transition="slide-y-transition">
        <template v-slot:activator="{ on }">
            <v-btn icon class="elevation-2" v-on="on">
                <v-badge
                    color="success"
                    dot
                    bordered
                    offset-x="10"
                    offset-y="10"
                >
                    <v-avatar size="40" style="background: #dd9e3a;">
                        <v-img src="/images/avatars/avatar-ozzy-01.png"></v-img>
                    </v-avatar>
                </v-badge>
            </v-btn>
        </template>

        <!-- user menu list -->
        <v-list dense nav>
            <v-list-item @click="LogoutSession">
                <v-list-item-icon>
                    <v-icon small>mdi-logout-variant</v-icon>
                </v-list-item-icon>
                <v-list-item-content>
                    <v-list-item-title>{{ $t('menu.logout') }}</v-list-item-title>
                </v-list-item-content>
            </v-list-item>
        </v-list>
    </v-menu>
</template>

<script>
import config from '../../configs'
/*
|---------------------------------------------------------------------
| Toolbar User Component
|---------------------------------------------------------------------
|
| Quickmenu for user menu shortcuts on the toolbar
|
*/
import axios from "axios";

export default {
    components:{
        axios,
    },
    data() {
        return {
            menu: config.toolbar.user
        }
    },
    created() {
        this.auth();
    },
    methods: {
        async auth(){
            try{
                await API.users.auth();
            }
            catch(error){
                this.redirectLoginPage();
            }
        },
        LogoutSession(){
            axios.post('/api/logout').then(response => {
                this.clearStorage();
                window.location.href = "login";
            });
        },

        clearStorage (){
            localStorage.removeItem('user_id');
            localStorage.removeItem('user_data');
            localStorage.removeItem('user_permissions');
            localStorage.removeItem('user_roles');
        },
        redirectLoginPage(){
            this.clearStorage();
            window.location.replace('/login');
        },
    },
}
</script>
