import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"


export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {

      mapboxgl.accessToken = this.apiKeyValue

      this.map = new mapboxgl.Map({
        container: this.element,
        style: "mapbox://styles/mapbox/streets-v10"
      })
      this.#addMarkersToMap()
      this.#fitMapToMarkers()
      this.#addPopup()
      this.map.addControl(new mapboxgl.FullscreenControl());
      this.map.addControl(new mapboxgl.NavigationControl());

  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  #addPopup() {
    const popup = new mapboxgl.Popup({
      closeButton: false,
      closeOnClick: false
    })

    this.map.on('click',  (e) => {

      if (e.lngLat.lng.toFixed(2) === this.markersValue[0].lng.toFixed(2) && e.lngLat.lat.toFixed(2) === this.markersValue[0].lat.toFixed(2)) {
        const marker = this.markersValue[0]
        const popup = new mapboxgl.Popup({ closeOnClick: true })
        .setLngLat([ marker.lng, marker.lat ])
        .setHTML(marker.info_window_html)
        .addTo(this.map);
      }
      });
  }


}
