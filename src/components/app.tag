import mapboxgl from 'mapbox-gl'
import * as d3 from '../scripts/lib/d3.js'
import './mapbox-map/mapbox-map.tag'
import './map-infobox/map-infobox.tag'
import './map-searchbox/map-searchbox.tag'
import './map-legend/map-legend.tag'
import './fallback-static-map/fallback-static-map.tag'

<cor-mj-munis-map class={ getClass('app-wrapper') }>
  <map-searchbox ref='searchbox' />
  <mapbox-map if={ supported } class={ getClass('mapbox-wrapper') } config={ opts.config } />
  <fallback-static-map if={ !supported } ref='fallback-static-map' />
  <map-legend ref='legend' config={ opts.config } />
  <map-infobox ref='infobox' config={ opts.config } />

  this.supported = false

  this.on('before-mount', () => {
    // this.supported = riot.STORE.supported = false
    this.supported = riot.STORE.supported = mapboxgl.supported()
    !this.supported && riot.control.trigger(riot.EVT.unsupported)
  })

  this.on('mount', () => {
    !this.supported && riot.control.trigger(riot.EVT.loaded) // otherwise wait for mapbox gl data loaded
  })

  riot.control.on(riot.EVT.loaded, () => {
    // remove loading spinner
    d3.select(`.${this.getClass('loading-spinner')}`)
      .classed(this.getClass('loading-spinner', 'loaded'), true)
  })

</cor-mj-munis-map>
