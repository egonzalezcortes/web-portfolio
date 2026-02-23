<template>
  <section id="expertise">
    <h1 class="section-title">My Expertise</h1>

    <div class="exp-container">
      <div class="exp-element">
        <h2>
          Software Engineering
          <span class="chonky-underline" />
        </h2>
        <p>Skilled in developing robust and scalable software solutions across various domains.</p>
      </div>

      <div class="exp-element">
        <h2>
          Frontend Development
          <span class="chonky-underline" />
        </h2>
        <p>Expertise in modern frontend technologies including React and Vue.
        </p>
      </div>

      <div class="exp-element">
        <h2>
          Backend Systems Development
          <span class="chonky-underline" />
        </h2>
        <p>Experienced in building and maintaining robust backend systems using Node.js, Python and Golang.</p>
      </div>
    </div>
  </section>
</template>

<script setup>

</script>

<style scoped>
#expertise {
  background-color: #181818;
  color: #fff;
}

.section-title {
  font-size: 75px;
  text-align: center;
  padding-top: 75px;
}

.exp-container {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
  border: 1px solid #fff;
}

.exp-element {
  margin: 2em;
  width: 300px;
  padding: 40px 30px;
}

.exp-element h2 {
  position: relative;
  display: inline-block;
  z-index: 0;
  font-weight: 600;
  font-size: 2em;
  line-height: 1.2em;
  color: #fff;
  text-shadow: 1px 3px 11px rgba(0, 0, 0, .5);
}

.chonky-underline {
  position: absolute;
  left: 0;
  right: 0;
  bottom: .05em;
  height: .45em;
  background-color: #4af626;
  z-index: -1;
}

@media (max-width: 562px) {
  .section-title {
    font-size: 50px;
    padding-top: 50px;
  }

  .exp-element {
    width: 100%;
    margin: 0;
    padding: 20px;
  }

  .exp-element h2 {
    font-size: 1.5em;
  }

  .exp-element p {
    font-size: 1em;
  }
}
</style>