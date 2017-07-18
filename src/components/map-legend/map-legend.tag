import getColorStops from '../mapbox-map/get_color_stops.js'

<map-legend class={ getClass() }>

  <span class={ getClass('annotation') }>
    <strong>Ausschließlich geringfügig Beschäftigte</strong><br>{ locationName }
  </span>
  <ul class={ getClass('list')}>
    <li each={ stop in stops } class={ parent.getClass('list-item') }>
      { Math.round(stop[0]) }&nbsp;%<span style="background-color:{ stop[1] };" />
    </li>
  </ul>

  const normal = riot.STORE.mode.normal
  const views = this.opts.config.mapbox.views
  const {colors, domain, extraStops} = normal ? views.normal : views.hotspots
  this.stops = getColorStops(colors, domain, extraStops)
  this.locationName = normal ? 'nach Wohnort' : 'nach Arbeitsort'

</map-legend>
