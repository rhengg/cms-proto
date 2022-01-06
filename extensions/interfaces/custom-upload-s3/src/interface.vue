<template>
  <div>
    <h1>Custom heading</h1>
    <v-upload></v-upload>
  </div>
</template>

<script>
export default {
  name: "Custom S3 upload",
  props: {
    value: {
      type: String,
      default: null
    }
  },
  emits: ["input"],
  data() {
    return {
      content: ""
    };
  },
  setup(props, { emit }) {
    return { handleChange };

    function handleChange(value) {
      emit("input", value);
    }
  }
};
</script>
