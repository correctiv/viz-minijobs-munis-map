import {states} from '../../data/entry.js'
import './history-chart/history-chart.tag'

<map-infobox if={ data } class="{ getClass() } { -visible: visible }" style={ position }>

  <button class={ getClass('close-btn') } aria-label='Close' onclick={ close }></button>

  <header class={ getClass('header') }>
    <section class={ getClass('header__section') }>
      <span class={ getClass('state') }>{ states[data.s] }</span>
      <h3 class={ getClass('title') }>{ data.gen }</h3>
    </section>
    <section if={ data.available } class={ getClass('header__section') }>
      <span class={ getClass('population') }><strong>{ data.t }</strong>&nbsp;Einwohner</span>
      <span class={ getClass('f-ratio') }>davon <strong>{ _f(data.fRatio) }&nbsp;%</strong>&nbsp;Frauen</span>
    </section>
    <span class="-clear-"></span>
  </header>

  <section if={ !data.available } class={ getClass('section', 'unavailable') }>
    <p>Leider keine Daten für { data.gen }</p>
  </section>

  <section if={ data.available } class={ getClass('section') }>
    <h4 class={ getClass('section__title') }>Anteil der Minijobber</h4>
    <span class={ getClass('section__subtitle') }>{ locationName }</span>
    <dl>
      <dt>{ _f(data.pa) }&nbsp;%</dt>
      <dt class="-small">{ data.a }</dt>
      <dd class="badge badge--e">ausschließlich</dd>
    </dl>
    <dl>
      <dt>{ _f(data.pn) }&nbsp;%</dt>
      <dt class="-small">{ data.n }</dt>
      <dd class="badge badge--i">Nebenjob</dd>
    </dl>
    <dl>
      <dt>{ _f(data.pi) }&nbsp;%</dt>
      <dt class="-small">{ data.i }</dt>
      <dd class="badge badge--t">Gesamt</dd>
    </dl>
    <span class="-clear-"></span>
  </section>

  <section if={ supported && data.available } class={ getClass('section') + ' ' + getClass('section--last') }>
    <h4 class={ getClass('section__title') }>Entwicklung seit 2003</h4>
    <history-chart ref='history-chart' config={ opts.config.historyChart } data={ data } />
  </section>
  <span class="-clear-"></span>

  this.supported = riot.STORE.supported  // disable history chart on no mapbox gl
  this.visible = false
  this.data = {}
  this.states = states
  this.ags = null  // remember which city we currently show
  this.locationName = riot.STORE.mode.normal ? 'nach Wohnort' : 'nach Arbeitsort'

  riot.control.on(riot.EVT.updateInfobox, ({data, point}) => {
    if (this._doUpdate(data, this)) {
      const _data = this._getData(data)
      _data.available = !+data.empty
      // update position & data
      _data.fRatio = Math.round(data.f / data.t * 1000) / 10
      this.update({
        point,
        data: _data,
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

  this._getData = d => {
    const _ = riot.STORE.mode.normal
    d.a = _ ? d.wa : d.aa
    d.pa = _ ? d.pwa : d.paa
    d.n = _ ? d.wn : d.an
    d.pn = _ ? d.pwn : d.pan
    d.i = _ ? d.wi : d.ai
    d.pi = _ ? d.pwi : d.pai
    return d
  }

</map-infobox>
