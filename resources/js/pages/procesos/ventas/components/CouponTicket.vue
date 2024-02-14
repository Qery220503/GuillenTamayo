<template>
  <div class="container">
    <div class="coupon-card">
      <div style="display: flex; justify-content: center; align-items: center;">
        <div class="logo-container">
          <img src="/images/illustrations/logo.png" class="logo" />
        </div>
      </div>
      <h3>
        20% de descuento en tu próxima compra<br />presentando este cupon.
      </h3>
      <div class="coupon-row">
        <span id="cpnCode">{{ coupon.codigo_cupon }}</span>
        <!--
        <span id="cpnBtn">Copiar Código</span>
          -->
      </div>
      <p>Valido hasta: {{ formatDate(coupon.fecha_vencimiento) }}</p>
      <div class="circle1"></div>
      <div class="circle2"></div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    coupon: {
      type: Object,
      required: true,
    }
  },
  methods: {
    formatDate(dateString) {
      var dateObj = new Date(dateString);
      var meses = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'];
      var dia = dateObj.getDate();
      var mes = meses[dateObj.getMonth()];
      var año = dateObj.getFullYear();
      var fechaFormateada = dia + ' de ' + mes + ', ' + año;
      return fechaFormateada;
    },
  }
}
</script>
<style scoped>
.container {
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}
.coupon-card {
  /*
  043c77
   */
  /*background: linear-gradient(135deg, #4d8fd5, #043c77);*/
  background-color: #043c77;
  color: #fff;
  text-align: center;
  padding: 40px 80px;
  border-radius: 15px;
  box-shadow: 0 10px 10px 0 rgba(0, 0, 0, 0.15);
  position: relative;
}
.logo {
  width: 200px;
  border-radius: 8px;
  /*margin-bottom: 20px;*/
}
.logo-container{
  background-color: white;
  justify-content: center;
  align-items: center;
  display: flex;
  align-content: center;
  margin-bottom: 20px;
  border-radius: 10px;
  padding: 15px;
}
.coupon-card h3 {
  font-size: 28px;
  font-weight: 400;
  line-height: 40px;
}
.coupon-card p {
  font-size: 15px;
}
.coupon-row {
  display: flex;
  align-items: center;
  margin: 25px auto;
  width: fit-content;
}
#cpnCode {
  border: 1px dashed #fff;
  padding: 10px 20px;
  font-size: 2rem;
  /*border-right: 0;*/
}
#cpnBtn {
  border: 1px solid #fff;
  background: #fff;
  padding: 10px 20px;
  color: #7158fe;
  cursor: pointer;
}
.circle1,
.circle2 {
  background: #f0fff3;
  width: 50px;
  height: 50px;
  border-radius: 50%;
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
}
.circle1 {
  left: -25px;
}
.circle2 {
  right: -25px;
}
</style>
