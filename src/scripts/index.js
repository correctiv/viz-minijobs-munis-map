'use strict'

if (module.hot) {
  module.hot.accept()
}

// import 'babel-polyfill'
import '../styles/index.scss'

// load config
const config = require('json!../config.json')

// event bus
import './riot_event_bus.js'

// setup responsiveness
import {getWindowWidth, getActiveBreakpointFunc} from './responsive.js'
const getActiveBreakpoint = getActiveBreakpointFunc(config.global.breakpoints)
riot.STORE.breakpoint = getActiveBreakpoint(getWindowWidth())
riot.STORE.getActiveBreakpoint = getActiveBreakpoint

// mixins
import getClass from './mixins/class_name.js'
riot.mixin(getClass(config.global.cssNamespace))

// mount app
import '../components/app.tag'
import '../components/hotspots.tag'

import * as d3 from './lib/d3.js'

const selector = '[data-riot-mount="cor-mj-munis-map"]'
const container = d3.select(selector)

if (container.node()) {
  const hotspots = !!+container.node().dataset.isHotspots
  riot.STORE.mode.hotspots = hotspots
  riot.STORE.mode.normal = !hotspots
  riot.mount(selector, 'cor-mj-munis-map', {config})
  hotspots && riot.mount('[data-riot-mount="cor-mj-munis-hotspots"]', 'cor-mj-munis-hotspots')
}
