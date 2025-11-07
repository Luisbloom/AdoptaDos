document.addEventListener('DOMContentLoaded', () => {
  // 🎯 Filtrar por especie
  const filtro = document.getElementById('filtro-especie');
  if (filtro) {
    filtro.addEventListener('change', () => {
      const valor = filtro.value;
      document.querySelectorAll('.animal-card').forEach(card => {
        card.style.display = (valor === 'todos' || card.dataset.especie === valor) ? 'block' : 'none';
      });
    });
  }

  // 🔍 Buscar por nombre
  const buscador = document.getElementById('buscador-nombre');
  if (buscador) {
    buscador.addEventListener('input', () => {
      const term = buscador.value.toLowerCase();
      document.querySelectorAll('.animal-card').forEach(card => {
        const nombre = card.querySelector('.animal-nombre').textContent.toLowerCase();
        card.style.display = nombre.includes(term) ? 'block' : 'none';
      });
    });
  }

  // 💌 Botón de solicitud
  document.querySelectorAll('.btn-solicitar').forEach(btn => {
    btn.addEventListener('click', function() {
      const nombre = this.closest('.animal-card').querySelector('.animal-nombre').textContent;
      alert(`📩 Solicitud enviada para adoptar a "${nombre}".\n\nPronto nos pondremos en contacto.`);
    });
  });
});