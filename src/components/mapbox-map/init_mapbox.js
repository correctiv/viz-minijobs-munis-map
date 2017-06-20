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

  // map.on('zoomend', e => riot.control.trigger(riot.EVT.mapZoomEnd, e))
  // map.on('moveend', e => riot.control.trigger(riot.EVT.mapMoveEnd, e))
  const triggerMouseOver = ({point}) => {
    const feature = map.queryRenderedFeatures(point)[0]
    feature && riot.control.trigger(riot.EVT.mapMouseOver, {
      point,
      data: feature.properties,
    })
  }

  map.on('mousemove', e => triggerMouseOver(e))
  // map.on('click', e => triggerMouseOver(e))

  // controls
  // map.addControl(new mapboxgl.FullscreenControl(), 'bottom-right')
  map.addControl(new mapboxgl.NavigationControl(), 'top-left')

  return map
}
