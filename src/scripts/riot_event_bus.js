import * as d3 from './lib/d3.js'

// store
const S = {
  isHotspots: false,
  supported: false,
  mapbox: {
    map: null,
    containerWidth: null
  },
  breakpoint: null,
  getActiveBreakpoint: null
}

// event names
const E = {
  mapMouseOver: 'mmo',
  mapJumpTo: 'mjt',
  mapClearMarker: 'mcm',
  updateInfobox: 'uib',
  hideInfobox: 'hib',
  clearResults: 'cr',
  windowResize: 'wr',
  breakpointChanged: 'bc',
  loaded: 'l',
  unsupported: 'us'
}

// event bus
const C = riot.observable()

// mouseover event chaining
C.on(E.mapMouseOver, data => {
  // C.trigger(E.clearResults)  FIXME
  C.trigger(E.updateInfobox, data)
  C.trigger(E.mapClearMarker)
})

// trigger actual breakpoint
C.on(E.windowResize, width => {
  const bp = S.getActiveBreakpoint(width)
  if (S.breakpoint !== bp) {
    S.breakpoint = bp
    C.trigger(E.breakpointChanged, bp)
  }
})

// unsupported extra data loading
C.on(E.unsupported, () => {
  d3.csv('./data/unsupported_data.csv', data => {
    S.unsupportedData = {}
    data.map(d => {
      S.unsupportedData[d.ags] = d
    })
    C.trigger(E.unsupportedDataLoaded)
  })

  // forward jumpto event to infobox
  C.on(E.mapJumpTo, ({data}) => {
    const _data = S.unsupportedData[data.ags]
    _data.gen = data.name
    _data.s = data.state
    C.trigger(E.updateInfobox, {
      data: _data,
      point: {}
    })
   })
})

// make available
riot.STORE = S
riot.EVT = E
riot.control = C
