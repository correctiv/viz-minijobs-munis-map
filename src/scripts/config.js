const config = require('json!../config.json')

config.util = {
  getClass: name => `${config.global.cssNamespace}-${name}`
}

export default config
