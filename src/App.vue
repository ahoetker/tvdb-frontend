<template>
  <div id="app">
    <b-container>
      <h1>Search for a TV Series</h1>

        <template v-if="loading">
          <b-spinner type="grow" label="Loading token"></b-spinner>
          <p>
            Loading TVDB auth token...
          </p>
        </template>

        <template v-else>
            <SeriesSearch v-bind:token="token"/>
        </template>
    </b-container>
  </div>
</template>

<script>

import SeriesSearch from './components/SeriesSearch.vue';

export default {
  name: 'App',
  components: {
    SeriesSearch
  },
  data: function() {
        return {
            loading: false,
            token: null
        }
    },
  created: function() {
      this.fetchToken()
  },
  methods: {
      fetchToken() {
          this.loading = true;
          fetch('/function/tvdb-auth-token', {
              method: 'POST',
              body: JSON.stringify({})
          })
          .then(response => response.json())
          .then(result => {
              this.loading = false;
              this.token = result.token;
          })
      }
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
