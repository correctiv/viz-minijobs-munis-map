export default point => {
  const {map, layers} = riot.STORE.mapbox
  return map.queryRenderedFeatures(point, {layers})[0]
}
