import './mapbox-map/mapbox-map.tag'
import './map-infobox/map-infobox.tag'
import './map-searchbox/map-searchbox.tag'


<cor-mj-munis-map class={ opts.config.util.getClass('app-wrapper') }>

  <map-searchbox getclass={ opts.config.util.getClass } />

  <mapbox-map
    class={ opts.config.util.getClass('mapbox-wrapper') }
    config={ opts.config }
  />

  <map-infobox getclass={ opts.config.util.getClass } config={ opts.config } />

</cor-mj-munis-map>
