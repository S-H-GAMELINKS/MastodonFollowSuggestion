<template>
<div class="container">
    <div v-if="user_login">
        <button v-on:click="recFollow">Follow reco</button>
    </div>
    <div v-else>
        <h1>Index</h1>
    </div>
</div>
</template>

<script>
import axios from 'axios';

export default {
    data: function() {
        return {
            user_login: false,
            userName: "",
            userIcon: "",
            userDomain: "",
            userToken: "",
            recoUsers: [],
        }
    },
    mounted: function() {
        this.userLogin()
    },
    methods: {
        recFollow: function() {
            const url = "https://".concat(this.userDomain).concat("/api/v1/suggestions");

            const token = 'Bearer '.concat(this.userToken);

            axios.get(url, {headers: {Authorization : token}}).then((response) => {

                for(var i = 0; i < response.data.length; i++) {
                    this.recoUsers.push(response.data[i]);
                }
            }, (error) => {
                console.log(error);
            })
        },
        userLogin: function() {
            axios.get('/api/sessions/login').then((response) => {
                console.log(response);
                if(response.data === null) {
                    this.user_login = false;
                } else {
                    this.user_login = true;
                    this.userName = response.data.uid;
                    this.userIcon = response.data.icon;
                    this.userDomain = response.data.domain;
                    this.userToken = response.data.token;
                }
                console.log(this.userDomain);
            }, (error) => {
                console.log(error);
            })
        }
    }

}
</script>