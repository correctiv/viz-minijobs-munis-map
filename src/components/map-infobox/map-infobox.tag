import './history-chart/history-chart.tag'

<map-infobox class="{ opts.getclass('infobox') } { -visible: visible }" style={ position }>

  <button class="btn { opts.getclass('infobox__close-btn') }" onclick={ close }>[x]</button>

  <h3 class={ opts.getclass('infobox__title') }>{ name }</h3>

  <section class={ opts.getclass('infobox__section') } onclick={ close }>
    <p>Anteil der Minijobber</p>
    <dl>
      <dt>{ value }&nbsp;%</dt>
      <dd class="badge badge--t">Gesamt</dd>
    </dl>
    <dl>
      <dt>{ value + 1 }&nbsp;%</dt>
      <dd class="badge badge--e">ausschließlich</dd>
    </dl>
    <dl>
      <dt>{ value - 1 }&nbsp;%</dt>
      <dd class="badge badge--i">im Nebenjob</dd>
    </dl>
  </section>

  <section class={ opts.getclass('infobox__section') } onclick={ close }>
    <p>Entwicklung seit 2003</p>
    <history-chart getclass={ opts.getclass } config={ opts.config.historyChart } />
  </section>

  this.visible = false

  riot.control.on(riot.EVT.updateInfobox, ({data, containerPoint}) => {
    this.update({
      containerPoint,
      visible: true,
      position: this._getPosition(containerPoint),
      name: data.GEN,
      value: Math.round(data.y2015 * 1000) / 10
    })
  })

  riot.control.on(riot.EVT.hideInfobox, () => {
    this.update({visible: false})
  })

  riot.control.on(riot.EVT.breakpointChanged, () => {
    if (this.visible) {
      const position = this._getPosition(this.containerPoint)
      this.update({position})
    }
  })

  this.close = () => this.update({visible: false})

  this._getPosition = ({x, y}) => {
    const width = riot.STORE.leaflet.containerWidth
    const bigger = riot.STORE.breakpoint !== 'small'
    return bigger ?
      `top:${y < 350 ? y + 40 : y - 340}px;left:${width - 350 < x ? x - 340 : x + 40}px;` :
      'bottom:10px;right:10px;left:10px;'
  }

</map-infobox>
