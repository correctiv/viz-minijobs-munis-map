import {states} from '../../data/entry.js'
import './history-chart/history-chart.tag'

<map-infobox if={ data } class="{ getClass() } { -visible: visible }" style={ position }>

  <button class={ getClass('close-btn') } aria-label='Close' onclick={ close }></button>

  <header class={ getClass('header') }>
    <section class={ getClass('header__section') }>
      <span class={ getClass('state') }>{ states[data.s] }</span>
      <h3 class={ getClass('title') }>{ data.gen }</h3>
    </section>
    <section class={ getClass('header__section') }>
      <span class={ getClass('population') }><strong>{ data.t }</strong>&nbsp;Einwohner</span>
      <span class={ getClass('f-ratio') }><strong>{ data.fRatio }&nbsp;%</strong>&nbsp;Frauenanteil</span>
    </section>
    <span class="-clear-"></span>
  </header>

  <section class={ getClass('section') }>
    <h4 class={ getClass('section__title') }>Anteil der Minijobber</h4>
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
      <dd class="badge badge--i">Nebenjob</dd>
    </dl>
    <span class="-clear-"></span>
  </section>

  <section if={ supported } class={ getClass('section') + ' ' + getClass('section--last') }>
    <h4 class={ getClass('section__title') }>Entwicklung seit 2003</h4>
    <history-chart ref='history-chart' config={ opts.config.historyChart } data={ data } />
  </section>
  <span class="-clear-"></span>

  this.supported = riot.STORE.supported  // disable history chart on no mapbox gl
  this.visible = false
  this.data = {}
  this.states = states
  this.ags = null  // remember which city we currently show

  riot.control.on(riot.EVT.updateInfobox, ({data, point}) => {
    if (this._doUpdate(data, this)) {
      // update position & data
      data.fRatio = Math.round(data.f / data.t * 1000) / 10
      this.update({
        point,
        data,
        visible: true,
        position: this._getPosition(point)
      })
    } else {
      // only update position
      this.update({
        point,
        position: this._getPosition(point)
      })
    }
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
    [x, y] = [Math.round(x), Math.round(y)]
    const width = riot.STORE.mapbox.containerWidth
    const bigger = riot.STORE.breakpoint !== 'small'
    return bigger && this.supported ?
      `top:${y < 360 ? y + 30 : y - 460}px;left:${width - 320 < x ? x - 320 : x + 20}px;` :
        !bigger ?  'top:50px;bottom:10px;right:10px;left:10px;' : null
  }

  this._doUpdate = ({ags}, that) => {
    if (that.ags === ags) {
      return false
    } else {
      that.ags = ags
      return true
    }
  }

</map-infobox>
