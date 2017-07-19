import mapboxgl from 'mapbox-gl'
import addLayers from './add_layers.js'
import getFeature from './get_feature.js'

export default ({
  mapId,
  accessToken,
  bBox,
  center,
  initZoom,
  maxZoom,
  minZoom,
  labels,
  sources,
  views
}) => {

  mapboxgl.accessToken = accessToken

  const normal = riot.STORE.mode.normal
  const {
    property,
    colors,
    domain,
    extraStops
  } = normal ? views.normal : views.hotspots

  const map = new mapboxgl.Map({
    container: mapId,
    center,
    zoom: initZoom,
    style: labels
  })
    .setMaxZoom(maxZoom)
    .setMinZoom(minZoom)
    .setMaxBounds(bBox)

  // add data source & events
  map.on('load', () => {

    riot.STORE.mapbox.layers = addLayers({
      map,
      sources: normal ? sources.normal : sources.hotspots,
      domain,
      colors,
      extraStops,
      property,
      maxZoom
    })

    const triggerMouseOver = ({point}) => {
      const feature = getFeature(point)
      feature && riot.control.trigger(riot.EVT.mapMouseOver, {
        point,
        data: feature.properties,
      })
    }

    map.scrollZoom.disable()
    map.on('mousemove', e => triggerMouseOver(e))

    // hide infobox if we are in hotspots mode
    // FIXME
    // riot.STORE.mode.hotspots && map.on('mouseout', () => riot.control.trigger(riot.EVT.hideInfobox))
  })


  // controls
  map.addControl(new mapboxgl.NavigationControl(), 'top-left')

  return map
}
