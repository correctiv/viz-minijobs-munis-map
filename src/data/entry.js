import * as d3 from '../scripts/lib/d3.js'

const states = require('json!./states.json')

const searchData = d3.csvParse(require('raw!./searchdata.csv'))
const search = str => searchData.filter(d => d.search.indexOf(str) > -1 || d.plz.indexOf(str) === 0)

module.exports = {
  search,
  states
}
