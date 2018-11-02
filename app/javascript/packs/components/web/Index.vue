<template>
<div class="container">
    <div v-if="user_login">
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
            recoUsers: [],
        }
    },
    mounted: function() {
        this.userLogin()
    },
    methods: {
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
                }
                console.log(this.userDomain);
            }, (error) => {
                console.log(error);
            })
        }
    }

}
</script>