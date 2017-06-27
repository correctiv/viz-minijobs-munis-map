import mapboxgl from 'mapbox-gl'
import initMapbox from './init_mapbox.js'

<mapbox-map>

  <div id={ config.mapId } ref={ config.mapId } class={ getClass('mapbox-container') }></div>

  this.config = this.opts.config.mapbox
  this.currentMarker = null

  this.on('mount', () => {
    this.map = initMapbox(this.config)

    // have map stuff available
    riot.STORE.mapbox.containerWidth = this._getContainerWidth()
    riot.STORE.mapbox.map = this.map

    // trigger 'loaded'
    this.map.on('load', () => riot.control.trigger(riot.EVT.loaded))
  })

  riot.control.on(riot.EVT.mapJumpTo, ({lat, lon}) => {
    this.map.easeTo({center: [lat, lon], zoom: 8})
    this._setMarker({lat, lon})
  })

  riot.control.on(riot.EVT.windowResize, () => {
    riot.STORE.mapbox.containerWidth = this._getContainerWidth()
  })

  riot.control.on(riot.EVT.mapClearMarker, () => this._clearMarker())

  this._setMarker = ({lat, lon}) => {
    const m = this.currentMarker
    if (m) m.setLngLat([lat, lon])
    else this.currentMarker = new mapboxgl.Marker().setLngLat([lat, lon]).addTo(this.map)
  }

  this._clearMarker = () => {
    const m = this.currentMarker
    m && m.remove()
    this.currentMarker = null
  }

  this._getContainerWidth = () => this.refs[this.config.mapId].clientWidth

</mapbox-map>
