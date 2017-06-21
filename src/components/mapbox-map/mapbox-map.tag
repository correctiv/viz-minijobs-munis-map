import initMapbox from './init_mapbox.js'

<mapbox-map>

  <div id={ config.mapId } ref={ config.mapId } class={ getClass('mapbox-container') }></div>

  this.config = this.opts.config.mapbox
  this.currentMarker = null

  this.on('mount', () => {
    this.map = initMapbox(this.config)
    // this.map.fitBounds(this.config.bBox)

    // have map stuff available
    riot.STORE.mapbox.containerWidth = this._getContainerWidth()
    riot.STORE.mapbox.map = this.map
  })

  riot.control.on(riot.EVT.mapJumpTo, ({lat, lon, data}) => {
    this.map.easeTo({center: [lon, lat], zoom: 8})
    // this._setMarker({lat, lon}, data.name)
  })

  riot.control.on(riot.EVT.windowResize, () => {
    riot.STORE.mapbox.containerWidth = this._getContainerWidth()
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

  this._getContainerWidth = () => this.refs[this.config.mapId].clientWidth

</mapbox-map>
