'use strict'

if (module.hot) {
  module.hot.accept()
}

// import 'babel-polyfill'
import '../styles/index.scss'

// load config
import config from './config.js'

// event bus
import './riot_event_bus.js'

// setup responsiveness
import {getWindowWidth, getActiveBreakpointFunc} from './responsive.js'
const getActiveBreakpoint = getActiveBreakpointFunc(config.global.breakpoints)
riot.STORE.breakpoint = getActiveBreakpoint(getWindowWidth())
riot.STORE.getActiveBreakpoint = getActiveBreakpoint


// mount app
import '../components/app.tag'
riot.mount('[data-riot-mount="cor-mj-munis-map"]', 'cor-mj-munis-map', {config})
