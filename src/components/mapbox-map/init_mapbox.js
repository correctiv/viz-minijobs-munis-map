import mapboxgl from 'mapbox-gl'

export default ({
  mapId,
  accessToken,
  labelUrl,
  bBox,
  center,
  initZoom,
  maxZoom,
  minZoom,
  layers
}) => {

  const style = layers[Object.keys(layers)[0]]

  mapboxgl.accessToken = accessToken
  const map = new mapboxgl.Map({
    container: mapId,
    center,
    zoom: initZoom,
    style
  })
    .setMaxZoom(maxZoom)
    .setMinZoom(minZoom)
    .setMaxBounds(bBox)

  // add label layer
  // map.addLayer({
  //   'id': 'labels',
  //   'source': {
  //     'type': 'vector',
  //     'url': labelUrl
  //   }
  // })

  const triggerMouseOver = ({point}) => {
    const feature = map.queryRenderedFeatures(point)[0]
    feature && riot.control.trigger(riot.EVT.mapMouseOver, {
      point,
      data: feature.properties,
    })
  }

  map.on('mousemove', e => triggerMouseOver(e))

  // controls
  map.addControl(new mapboxgl.NavigationControl(), 'top-left')

  return map
}
