import mapboxgl from 'mapbox-gl'
import addLayers from './add_layers.js'

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
  stops,
  colors,
  property
}) => {

  mapboxgl.accessToken = accessToken

  const map = new mapboxgl.Map({
    container: mapId,
    center,
    zoom: initZoom,
    // style: labels
    style: 'mapbox://styles/mapbox/light-v9'
  })
    .setMaxZoom(maxZoom)
    .setMinZoom(minZoom)
    .setMaxBounds(bBox)

  // add data source & events
  map.on('load', () => {

    const layers = addLayers({
      map,
      sources,
      stops,
      colors,
      property,
      maxZoom
    })

    const triggerMouseOver = ({point}) => {
      const feature = map.queryRenderedFeatures(point, {layers})[0]
      feature && riot.control.trigger(riot.EVT.mapMouseOver, {
        point,
        data: feature.properties,
      })
    }

    map.on('mousemove', e => triggerMouseOver(e))

    // hide infobox if we are in hotspots mode
    riot.STORE.isHotspots && map.on('mouseout', () => riot.control.trigger(riot.EVT.hideInfobox))
  })


  // controls
  map.addControl(new mapboxgl.NavigationControl(), 'top-left')

  return map
}
