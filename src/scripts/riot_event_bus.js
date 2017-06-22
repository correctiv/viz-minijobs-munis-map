// store
const S = {
  supported: false,
  mapbox: {
    map: null,
    containerWidth: null
  },
  infoboxQueue: null,
  breakpoint: null,
  getActiveBreakpoint: null
}

// event names
const E = {
  mapMouseOver: 'mmo',
  mapJumpTo: 'mjt',
  mapZoomEnd: 'mze',
  mapMoveEnd: 'mme',
  mapClearMarker: 'mcm',
  updateInfobox: 'uib',
  hideInfobox: 'hib',
  clearResults: 'cr',
  windowResize: 'wr',
  breakpointChanged: 'bc',
}

// event bus
const C = riot.observable()

// event chaining
C.on(E.mapMouseOver, data => {
  // C.trigger(E.clearResults)  FIXME
  C.trigger(E.updateInfobox, data)
  C.trigger(E.mapClearMarker)
})

// on jumpTo, wait for map to move end
C.on(E.mapJumpTo, data => {
  S.infoboxQueue = data
})

C.on(E.mapMoveEnd, () => {
  if (S.infoboxQueue) {
    const data = S.infoboxQueue
    data.containerPoint = data.getContainerPoint()
    C.trigger(E.updateInfobox, data)
    S.infoboxQueue = null
  }
})

// trigger actual breakpoint
C.on(E.windowResize, width => {
  const bp = S.getActiveBreakpoint(width)
  if (S.breakpoint !== bp) {
    S.breakpoint = bp
    C.trigger(E.breakpointChanged, bp)
  }
})

// make available
riot.STORE = S
riot.EVT = E
riot.control = C
