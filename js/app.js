// 🧠 app.js — Versión final para tu estructura de carpetas
// Autor: Luis Miguel Pablos Orge
// Fecha: 2025-11-14

function cargarDatos() {
  const stored = localStorage.getItem('adopciones');
  if (stored) return JSON.parse(stored);
  
  // Cargar desde data/adopciones.xml si existe
  try {
    const req = new XMLHttpRequest();
    req.open("GET", "data/adopciones.xml", false); // síncrono solo en inicialización
    req.send();
    if (req.status === 200) {
      const parser = new DOMParser();
      const xml = parser.parseFromString(req.responseText, "application/xml");
      const data = { usuarios: [], animales: [], adopciones: [] };

      xml.querySelectorAll('usuarios usuario').forEach((u, i) => {
        data.usuarios.push({
          id: u.getAttribute('id') || `u${i + 1}`,
          nombre: u.querySelector('nombre')?.textContent || '',
          apellido: u.querySelector('apellido')?.textContent || '',
          email: u.querySelector('email')?.textContent || ''
        });
      });

      xml.querySelectorAll('animales animal').forEach((a, i) => {
        data.animales.push({
          id: a.getAttribute('id') || `a${i + 1}`,
          estado: a.getAttribute('estado') || 'disponible',
          nombre: a.querySelector('nombre')?.textContent || '',
          especie: a.querySelector('especie')?.textContent || '',
          edad: parseInt(a.querySelector('edad')?.textContent) || 0
        });
      });

      xml.querySelectorAll('adopciones-realizadas adopcion').forEach((ad, i) => {
        const ids = Array.from(ad.querySelectorAll('pareja idUsuario')).map(el => el.textContent);
        data.adopciones.push({
          id: ad.getAttribute('id') || `ad${i + 1}`,
          idAnimal: ad.querySelector('idAnimal')?.textContent || '',
          pareja: ids,
          fecha: ad.querySelector('fecha')?.textContent || ''
        });
      });

      guardarDatos(data);
      return data;
    }
  } catch (e) {
    console.warn("No se pudo cargar data/adopciones.xml → usando plantilla vacía");
  }

  return { usuarios: [], animales: [], adopciones: [] };
}

function guardarDatos(data) {
  localStorage.setItem('adopciones', JSON.stringify(data));
  generarXML(data);
}

function escapeXml(str) {
  return (str || '').toString()
    .replace(/&/g, '&amp;')
    .replace(/</g, '<')
    .replace(/>/g, '>')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&apos;');
}

function generarXML(data) {
  let xml = `<?xml version="1.0" encoding="UTF-8"?>\n<adopciones>\n`;
  
  // Usuarios
  xml += `  <usuarios>\n`;
  data.usuarios.forEach(u => {
    xml += `    <usuario id="${u.id}">\n`;
    xml += `      <nombre>${escapeXml(u.nombre)}</nombre>\n`;
    xml += `      <apellido>${escapeXml(u.apellido)}</apellido>\n`;
    xml += `      <email>${escapeXml(u.email)}</email>\n`;
    xml += `    </usuario>\n`;
  });
  xml += `  </usuarios>\n`;

  // Animales
  xml += `  <animales>\n`;
  data.animales.forEach(a => {
    xml += `    <animal id="${a.id}" estado="${a.estado}">\n`;
    xml += `      <nombre>${escapeXml(a.nombre)}</nombre>\n`;
    xml += `      <especie>${escapeXml(a.especie)}</especie>\n`;
    xml += `      <edad>${a.edad}</edad>\n`;
    xml += `    </animal>\n`;
  });
  xml += `  </animales>\n`;

  // Adopciones
  xml += `  <adopciones-realizadas>\n`;
  data.adopciones.forEach(ad => {
    xml += `    <adopcion id="${ad.id}">\n`;
    xml += `      <idAnimal>${ad.idAnimal}</idAnimal>\n`;
    xml += `      <pareja>\n`;
    ad.pareja.forEach(id => {
      xml += `        <idUsuario>${id}</idUsuario>\n`;
    });
    xml += `      </pareja>\n`;
    xml += `      <fecha>${ad.fecha}</fecha>\n`;
    xml += `    </adopcion>\n`;
  });
  xml += `  </adopciones-realizadas>\n`;
  xml += `</adopciones>`;
  
  localStorage.setItem('adopciones.xml', xml);
}

document.addEventListener('DOMContentLoaded', () => {
  const data = cargarDatos();
  const path = location.pathname.split('/').pop();

  // ▶️ registro-usuario.html
  if (path === 'registro-usuario.html') {
    document.getElementById('formRegistro')?.addEventListener('submit', e => {
      e.preventDefault();
      const fd = new FormData(e.target);
      const u = {
        id: `u${data.usuarios.length + 1}`,
        nombre: fd.get('nombre'),
        apellido: fd.get('apellidos'),
        email: fd.get('email')
      };
      data.usuarios.push(u);
      guardarDatos(data);
      alert(`✅ Usuario registrado: ${u.nombre}`);
      e.target.reset();
    });
  }

  // ▶️ registro-animal.html
  else if (path === 'registro-animal.html') {
    document.getElementById('formAnimal')?.addEventListener('submit', e => {
      e.preventDefault();
      const fd = new FormData(e.target);
      const a = {
        id: `a${data.animales.length + 1}`,
        estado: 'disponible',
        nombre: fd.get('nomAnimal'),
        especie: fd.get('especie'),
        edad: parseInt(fd.get('edad')) || 0
      };
      data.animales.push(a);
      guardarDatos(data);
      alert(`✅ Animal registrado: ${a.nombre} (${a.especie})`);
      e.target.reset();
    });
  }

  // ▶️ adopcion-pareja.html
  else if (path === 'adopcion-pareja.html') {
    const form = document.getElementById('formAdopcion');
    const u1 = document.getElementById('usuario1');
    const u2 = document.getElementById('usuario2');
    const animal = document.getElementById('animalAdoptar');

    if (!form || !u1 || !u2 || !animal) return;

    const actualizarSelectores = () => {
      u1.innerHTML = '<option value="">-- Selecciona --</option>';
      u2.innerHTML = '<option value="">-- Selecciona --</option>';
      animal.innerHTML = '<option value="">-- Selecciona --</option>';

      data.usuarios.forEach(us => {
        const opt = new Option(`${us.nombre} ${us.apellido}`, us.id);
        u1.appendChild(opt.cloneNode(true));
        u2.appendChild(opt);
      });

      data.animales
        .filter(a => a.estado === 'disponible')
        .forEach(a => {
          const opt = new Option(`${a.nombre} (${a.especie})`, a.id);
          animal.appendChild(opt);
        });
    };

    actualizarSelectores();

    form.addEventListener('submit', e => {
      e.preventDefault();
      const id1 = u1.value, id2 = u2.value, idA = animal.value;
      
      if (!id1 || !id2 || !idA) return alert("❌ Completa todos los campos.");
      if (id1 === id2) return alert("❌ Los adoptantes deben ser distintos.");

      const animalData = data.animales.find(a => a.id === idA);
      if (!animalData || animalData.estado !== 'disponible')
        return alert("❌ Animal no disponible.");

      const nuevaAdopcion = {
        id: `ad${data.adopciones.length + 1}`,
        idAnimal: idA,
        pareja: [id1, id2],
        fecha: new Date().toISOString().split('T')[0]
      };

      data.adopciones.push(nuevaAdopcion);
      animalData.estado = 'adoptado';
      guardarDatos(data);

      const nom1 = data.usuarios.find(u => u.id === id1)?.nombre;
      const nom2 = data.usuarios.find(u => u.id === id2)?.nombre;
      alert(`✅ ¡Adopción registrada!\n${animalData.nombre} → ${nom1} & ${nom2}`);
      actualizarSelectores();
      form.reset();
    });
  }

  // ▶️ ver-gestion.html
  else if (path === 'ver-gestion.html') {
    const visor = document.getElementById('visor');
    if (!visor) return;

    let xmlStr = localStorage.getItem('adopciones.xml');

    if (!xmlStr) {
      fetch('data/adopciones.xml')
        .then(r => r.text())
        .then(xml => {
          xmlStr = xml;
          localStorage.setItem('adopciones.xml', xmlStr);
          procesarXML(xmlStr);
        })
        .catch(err => {
          visor.innerHTML = `<p class="nota">❌ Error al cargar XML: ${err.message}</p>`;
        });
    } else {
      procesarXML(xmlStr);
    }

    function procesarXML(xmlStr) {
      const parser = new DOMParser();
      const xml = parser.parseFromString(xmlStr, "application/xml");
      if (xml.querySelector("parsererror")) {
        visor.innerHTML = `<p class="nota">❌ XML inválido</p>`;
        return;
      }

      fetch('xslt/adopciones.xsl')
        .then(r => r.text())
        .then(xslStr => {
          const xsl = parser.parseFromString(xslStr, "application/xml");
          if (xsl.querySelector("parsererror")) throw new Error("XSLT inválido");
          const proc = new XSLTProcessor();
          proc.importStylesheet(xsl);
          visor.innerHTML = '';
          visor.appendChild(proc.transformToFragment(xml, document));
        })
        .catch(err => {
          visor.innerHTML = `<p class="nota">❌ Error XSLT: ${err.message}</p>`;
        });
    }
  }
});