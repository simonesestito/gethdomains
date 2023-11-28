<script setup>
import {RouterView} from 'vue-router'
</script>

<template>
  <header>
    <ui-top-app-bar class="demo-app-bar" fixed nav-id="main-menu">GethDomains</ui-top-app-bar>
  </header>

  <ui-drawer nav-id="main-menu" type="dismissible" viewport-height>
    <ui-drawer-header/>
    <ui-drawer-content>
      <ui-nav>
        <ui-nav-item active href="javascript:void(0)" onclick="alert(1)">Back</ui-nav-item>
        <ui-nav-item active href="javascript:void(0)">Item {{ 0 }}</ui-nav-item>
        <ui-nav-item v-for="i in 12" :key="i" href="javascript:void(0)">
          Item {{ i }}
        </ui-nav-item>
      </ui-nav>
    </ui-drawer-content>
  </ui-drawer>

  <!-- Content -->
  <ui-drawer-app-content class="container">
    <!-- App content -->
    <RouterView/>
  </ui-drawer-app-content>
</template>

<style scoped>
.container {
  padding: 86px 24px 24px;
}

.demo-app-bar {
  z-index: 7;
}
</style>
