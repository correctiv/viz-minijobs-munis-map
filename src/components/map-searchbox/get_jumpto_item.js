/*
 * create item to jump to, it needs container point and latlng for broadcasting to infobox and leaflet map
 */

export default item => {
  const {lat, lon} = item
  return {
    data: item,
    lat,
    lon,
    // wait for move end
    getContainerPoint: () => riot.STORE.leaflet.map.latLngToContainerPoint({lat, lon})
  }
}
