import Vue from 'vue/dist/vue.esm';
import Header from './components/layouts/Header.vue';

const app = new Vue({
    el: '#app',
    data: function() {
        return {
            mes: "hello"
        }
    }
})