import initLeaflet from './init_leaflet.js'

<leaflet-map>

  <div id={ mapId } ref={ mapId } class={ opts.config.util.getClass('leaflet-container') }></div>

  this.config = this.opts.config.leaflet
  this.mapId = this.config.mapId
  this.currentMarker = null

  this.on('mount', () => {
    this.map = initLeaflet(this.mapId, this.config)
    this.map.fitBounds(this.config.bBox)

    // have map stuff available
    riot.STORE.leaflet.containerWidth = this._getContainerWidth()
    riot.STORE.leaflet.map = this.map
  })

  riot.control.on(riot.EVT.mapJumpTo, ({lat, lon, data}) => {
    this.map.setView({lat, lon}, 9)
    this._setMarker({lat, lon}, data.name)
  })

  riot.control.on(riot.EVT.windowResize, () => {
    riot.STORE.leaflet.containerWidth = this._getContainerWidth()
  })

  riot.control.on(riot.EVT.mapClearMarker, () => this._clearMarker())

  this._setMarker = ({lat, lon}, name) => {
    const m = this.currentMarker
    if (m) m.setLatLng({lat, lon})
    else this.currentMarker = L.marker({lat, lon}).addTo(this.map)
    this.currentMarker.bindPopup(name).openPopup()
  }

  this._clearMarker = () => {
    const m = this.currentMarker
    m && this.map.removeLayer(m)
    this.currentMarker = null
  }

  this._getContainerWidth = () => this.refs[this.mapId].clientWidth

</leaflet-map>
