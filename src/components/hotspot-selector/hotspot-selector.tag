import {hotspots} from '../../data/entry.js'
import './hotspot-item.tag'

<hotspot-selector class={ getClass() }>

  <hotspot-item
    each={ hotspot in hotspots }
    data={ hotspot }
    css='hotspot-item'
    active={ parent.hotspots.indexOf(hotspot) === parent.active }
    action={ parent.select }
  />

  this.active = null
  this.hotspots = hotspots
  this.select = hotspot => {
    const index = this.hotspots.indexOf(hotspot)
    const active = index === this.active ? null : index
    this.update({active})
    riot.control.trigger(riot.EVT.mapJumpTo, hotspot)
  }
</hotspot-selector>
