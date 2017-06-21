import {states} from '../../data/entry.js'
import './history-chart/history-chart.tag'

<map-infobox if={ data } class="{ getClass() } { -visible: visible }" style={ position }>

  <button class={ getClass('close-btn') } aria-label='Close' onclick={ close }>x</button>

  <h3 class={ getClass('title') }>{ data.gen }</h3>
  <span class={ getClass('state') }>{ states[data.s] }</span>

  <section class={ getClass('section') }>
    <p>Anteil der Minijobber</p>
    <dl>
      <dt>{ data.pwi }&nbsp;%</dt>
      <dd class="badge badge--t">Gesamt</dd>
    </dl>
    <dl>
      <dt>{ data.pwa }&nbsp;%</dt>
      <dd class="badge badge--e">ausschließlich</dd>
    </dl>
    <dl>
      <dt>{ data.pwn }&nbsp;%</dt>
      <dd class="badge badge--i">im Nebenjob</dd>
    </dl>
  </section>

  <section class={ getClass('section') }>
    <history-chart ref='history-chart' config={ opts.config.historyChart } data={ data } />
  </section>

  this.visible = false
  this.data = {}
  this.states = states

  riot.control.on(riot.EVT.updateInfobox, ({data, point}) => {
    this.update({
      point,
      data,
      visible: true,
      position: this._getPosition(point)
    })
  })

  riot.control.on(riot.EVT.hideInfobox, () => {
    this.update({visible: false})
  })

  riot.control.on(riot.EVT.breakpointChanged, () => {
    if (this.visible) {
      const position = this._getPosition(this.point)
      this.update({position})
    }
  })

  this.close = () => this.update({visible: false})

  this._getPosition = ({x, y}) => {
    const width = riot.STORE.mapbox.containerWidth
    const bigger = riot.STORE.breakpoint !== 'small'
    return bigger ?
      `top:${y < 350 ? y + 30 : y - 330}px;left:${width - 350 < x ? x - 330 : x + 30}px;` :
      'bottom:10px;right:10px;left:10px;'
  }

</map-infobox>
