import './lib/leaflet.utfgrid.js'

const _getLayer = (url, opts) => {
  return L.tileLayer(url, opts)
}

export default (mapId, {
  labelUrl,
  gridUrl,
  useJsonP,
  bBox,
  maxZoom,
  minZoom,
  attribution,
  tileLayers
}) => {

  const grid = new L.UtfGrid(gridUrl, {useJsonP})
    .on('mouseover', e => riot.control.trigger(riot.EVT.mapMouseOver, e))

  const labels = {
    'Ortsnamen': _getLayer(labelUrl, {maxZoom, minZoom})
  }

  const layers = {}
  let initLayer
  Object.keys(tileLayers).map((k, i) => {
    layers[k] = _getLayer(tileLayers[k], {maxZoom, minZoom})
    if (!i) initLayer = layers[k]
  })


  const map = L.map(mapId, {
    maxBounds: bBox,
    layers: [grid, initLayer, labels['Ortsnamen']]
  })

  L.control.layers(layers, labels, {
    collapsed: false,
    position: 'topleft'
  }).addTo(map)

  map.on('zoomend', e => riot.control.trigger(riot.EVT.mapZoomEnd, e))
  map.on('moveend', e => riot.control.trigger(riot.EVT.mapMoveEnd, e))

  return map
}
