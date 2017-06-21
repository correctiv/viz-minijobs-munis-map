import './mapbox-map/mapbox-map.tag'
import './map-infobox/map-infobox.tag'
import './map-searchbox/map-searchbox.tag'

<cor-mj-munis-map class={ getClass('app-wrapper') }>
  <map-searchbox ref='searchbox' />
  <mapbox-map class={ getClass('mapbox-wrapper') } config={ opts.config } />
  <map-infobox ref='infobox' config={ opts.config } />
</cor-mj-munis-map>
