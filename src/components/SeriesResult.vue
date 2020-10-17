<template>
    <b-card class="mb-2">
        <h3>{{ this.title }}</h3>
        <p>{{ this.overview || 'No overview available.' }}</p>
        <b-button variant="primary">Series Details</b-button>
     </b-card>  
</template>

<script>
export default {
    name: 'SeriesResult',
    props: {
        firstAired: String,
        id: Number,
        overview: String,
        seriesName: String
    },
    computed: {
        title: function() {
            if (this.firstAired) {
                return `${this.seriesName} (${this.firstAired.split("-")[0]})`;
            } else {
                return this.seriesName;
            }
        }
    }
}
</script>