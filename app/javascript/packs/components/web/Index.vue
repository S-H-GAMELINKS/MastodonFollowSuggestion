<template>
<div class="container">
    <div v-if="user_login">
        <div v-for="(user, key, index) in recoUsers" :key=index>
            <img :src="user.avatar" :size="'50x50'">
            <p>アカウント名：{{user.display_name}} アカウントID：{{user.acct}}</p>
            <p>フォロー数：{{user.following_count}} フォロワー数：{{user.followers_count}}</p>
            <p>Toot数：{{user.statuses_count}}</p>
            <p v-if="user.locked">鍵垢</p>
            <p v-if="user.bot">Bot</p>
            <a :href="user.url">{{user.display_name}} さんをフォローする</a>
            <br><br><br>
        </div>
        <button v-on:click="recFollow">おすすめユーザーを見てみる</button>
    </div>
    <div v-else>
        <h1><p>Mastodon Follow Suggestion へようこそ！</p></h1>
        <p>このサービスではあなたへオススメのユーザーを紹介します！</p>
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
                if(response.data === null) {
                    this.user_login = false;
                } else {
                    this.user_login = true;
                    this.userName = response.data.uid;
                    this.userIcon = response.data.icon;
                    this.userDomain = response.data.domain;
                    this.userToken = response.data.token;
                }
            }, (error) => {
                console.log(error);
            })
        }
    }

}
</script>