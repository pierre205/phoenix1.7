import "phoenix_html"
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"
import Highcharts, { color } from 'highcharts';


let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})

topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

liveSocket.connect()
window.liveSocket = liveSocket

document.addEventListener('DOMContentLoaded', function() {
  const el = document.getElementById("container");
  const data = JSON.parse(el.dataset.serie);
  // Extraire les années distinctes à partir des données
  const years = [...new Set(data.map(item => new Date(item.x).getFullYear()))];

  const chart = Highcharts.chart('container', {
    chart: {
      type: 'area',
      width: 800,
      height: 600
    },
    xAxis: {
      type: 'category',
      categories: data.map(item => item.x),
      labels: {
        rotation: -45,
        style: {
          fontSize: '13px',
          fontFamily: 'Arial, sans-serif'
        }
      }
    },
    yAxis: {
      title: {
        text: 'Nombre de nouveaux inscrits'
      }
    },
    series: [{
      animation: {
        duration: 1000,
        easing: 'linear'
      },
      name: 'Date',
      data: data.map(item => item.y)
    }]
  });

  // Créer le menu déroulant avec les années
  const yearSelect = document.createElement('select');
  yearSelect.id = 'year-select';

  // Ajouter une option pour chaque année
  years.forEach(year => {
    const option = document.createElement('option');
    option.value = year;
    option.text = year;
    yearSelect.appendChild(option);
  });
  // Ajouter le menu déroulant à la page
  const container = document.getElementById('container');
  container.parentNode.insertBefore(yearSelect, container);

  // Écouter les changements de sélection dans le menu déroulant
  yearSelect.addEventListener('change', function() {
    const selectedYear = yearSelect.value;

    // Filtrer les données en fonction de l'année sélectionnée
    const filteredData = data.filter(item => new Date(item.x).getFullYear() === parseInt(selectedYear));

    // Mettre à jour les catégories de l'axe des x avec les nouvelles données filtrées
    chart.xAxis[0].update({
      categories: filteredData.map(item => item.x)
    });

    // Mettre à jour les données de la série avec les nouvelles données filtrées
    chart.series[0].update({
      data: filteredData.map(item => item.y)
    });
  });
});

document.addEventListener('DOMContentLoaded', function() {
  const el = document.getElementById("container2");
  const data = JSON.parse(el.dataset.serie);
  const chart = Highcharts.chart('container2', {
    chart: {
      type: 'area',
      width: 800,
      height: 600
    },
    xAxis: {
      type: 'category',
      categories: data.map(item => item.x),
      labels: {
        rotation: -45,
        style: {
          fontSize: '13px',
          fontFamily: 'Arial, sans-serif'
        }
      }
    },
    yAxis: {
      title: {
        text: 'Nombre de nouveaux portfolios'
      }
    },
    series: [{
      animation: {
        duration: 1000,
        easing: 'linear'
      },
      name: 'Date',
      data: data.map(item => item.y)
    }]
  });
});

document.addEventListener('DOMContentLoaded', function() {
  const el = document.getElementById("container3");
  const data = JSON.parse(el.dataset.serie);
  const chart = Highcharts.chart('container3', {
    chart: {
      type: 'area',
      width: 800,
      height: 600
    },
    xAxis: {
      type: 'category',
      categories: data.map(item => item.x),
      labels: {
        rotation: -45,
        style: {
          fontSize: '13px',
          fontFamily: 'Arial, sans-serif'
        }
      }
    },
    yAxis: {
      title: {
        text: 'Nombre d utilisateurs suivis'
      }
    },
    series: [{
      animation: {
        duration: 1000,
        easing: 'linear'
      },
      name: 'Date',
      data: data.map(item => item.y)
    }]
  });
});
