import mapboxgl from 'mapbox-gl'
import './mapbox-map/mapbox-map.tag'
import './map-infobox/map-infobox.tag'
import './map-searchbox/map-searchbox.tag'
import './fallback-static-map/fallback-static-map.tag'

<cor-mj-munis-map class={ getClass('app-wrapper') }>
  <map-searchbox ref='searchbox' />
  <mapbox-map if={ supported } class={ getClass('mapbox-wrapper') } config={ opts.config } />
  <fallback-static-map if={ !supported } ref='fallback-static-map' />
  <map-infobox ref='infobox' config={ opts.config } />

  this.supported = false

  this.on('before-mount', () => {
    this.supported = riot.STORE.supported = mapboxgl.supported()
    !this.supported && riot.control.trigger(riot.EVT.unsupported)
  })

  this.on('mount', () => {
    !this.supported && riot.control.trigger(riot.EVT.loaded) // otherwise wait for mapbox gl data loaded
  })

  riot.control.on(riot.EVT.loaded, () => {
    // remove loading spinner
    const spinner = document.querySelector('.mjmm-loading-spinner')
    spinner.className = 'mjmm-loading-spinner mjmm-loading-spinner--loaded'
  })

</cor-mj-munis-map>
