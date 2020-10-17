<template>
    <b-container fluid>
        <b-row class="justify-content-md-center mt-3">
            <b-col col md="5" lg="7">
                <b-form-input v-model="query"/>
            </b-col>
        </b-row>

        <b-row class="justify-content-md-center mt-3">
            <b-col col>
                <div v-if="(results == null || results.data == null)">
                    <b-spinner
                    v-if="results === 'Searching...'" 
                    type="grow" 
                    label="Searching...">
                    </b-spinner>
                    <p>
                        {{ results }}
                    </p>
                </div>

                <div
                    v-else 
                    v-for="series in results.data"
                    :key="series.id">
                    <SeriesResult v-bind="series" />
                </div>
            </b-col>
        </b-row>
    </b-container>
</template>

<script>
import _ from 'lodash';
import SeriesResult from './SeriesResult.vue';

export default {
    name: 'SeriesSearch',
    components: {
        SeriesResult
    },
    props: {
        token: String
    },
    data: function() {
        return {
            query: '',
            results: null
        }
    },
    watch: {
        /*eslint no-unused-vars: ["error", { "args": "none" }]*/
        query: function(newQuery, oldQuery) {
            this.results = 'Waiting for you to stop typing...';
            this.debouncedSeriesSearch();
        }
    },
    created: function() {
        this.debouncedSeriesSearch = _.debounce(this.getResults, 500);
    },
    methods: {
        getResults: function() {
            const MIN_QUERY_LENGTH = 2;
            if (this.query.length < MIN_QUERY_LENGTH) {
                this.results = `Query must be ${MIN_QUERY_LENGTH} characters or more.`;
                return
            }
            this.results = "Searching...";
            fetch('/function/tvdb-series-search', {
                method: 'POST',
                body: JSON.stringify({token: {token: this.token}, query: {name: this.query}})
            })
            .then(response => response.json())
            .then(results => {
                if (Object.entries(results.results).length === 0) {
                    this.results = `No results found for: "${this.query}"`
                } else {
                    this.results = results.results
                }
            })
        },
        hover: function(item, v) {
            item.hovered = v;
        }
    }
}
</script>