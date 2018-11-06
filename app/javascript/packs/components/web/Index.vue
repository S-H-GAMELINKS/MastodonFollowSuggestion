<template>
<div class="container">
    <div v-if="user_login">
        <div v-for="(user, key, index) in recoUsers" :key=index>
            <p>アカウントID：{{user.acct}}</p>
            <img :src="user.avatar" size="50x50">
            <p>アカウント名：{{user.display_name}}</p>
            <p>フォロー数：{{user.following_count}}</p>
            <p>フォロワー数：{{user.followers_count}}</p>
            <p>Toot数：{{user.statues_count}}</p>
            <p v-if="user.locked">鍵垢</p>
            <p v-if="user.bot">Bot</p>
            <a :href="user.url">フォロー</a>
        </div>
        <button v-on:click="recFollow">おすすめユーザーを見てみる</button>
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

                console.log(this.recoUsers);
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