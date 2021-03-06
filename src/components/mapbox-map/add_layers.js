import getColorStops from './get_color_stops.js'

// add layers from sources
export default ({
  map,
  sources,
  domain,
  colors,
  extraStops,
  property,
  maxZoom
}) => {

  const zooms = Object.keys(sources)
  const stops = getColorStops(colors, domain, extraStops)
  const addedLayers = []

  zooms.map((zoom, i) => {

    const source = sources[zoom]
    const sourceId = `mj-${property}-${zoom}-source`
    const layerId = `mj-${property}-${zoom}-layer`

    map.addSource(sourceId, {
      type: 'vector',
      url: `mapbox://${source.mapId}`
    })

    map.addLayer({
      id: layerId,
      source: sourceId,
      'source-layer': source.layer,
      minzoom: +zoom,
      maxzoom: +zooms[i+1] || maxZoom,
      type: 'fill',
      paint: {
        'fill-color': {
          default: 'white',
          property,
          type: 'interval',
          stops
        },
        'fill-outline-color': 'white',
        'fill-opacity': .75
      }
    }, 'admin-3-4-boundaries-bg')


    addedLayers.push(layerId)
  })

  return addedLayers
}
