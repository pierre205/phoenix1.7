
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
  
    const chart = Highcharts.chart('container', {
      chart: {
        type: 'area',
        width: 800,
        height: 600
      },
      xAxis: {
        type: 'category',
        categories: data.map(item => item.x), // Utilisez les valeurs x comme catégories de l'axe des x
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
          text: 'Nombre de nouvreau inscrits'
        }
      },
      series: [{
        name: 'Date',
        data: data.map(item => item.y) // Utilisez les valeurs y comme données de la série
      }]
    });
  });
  


