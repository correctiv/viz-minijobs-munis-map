import * as d3 from '../scripts/lib/d3.js'

const states = require('json!./states.json')

const searchData = d3.csvParse(require('raw!./searchdata.csv'))
const search = str => searchData.filter(d => d.search.indexOf(str) > -1 || d.plz.indexOf(str) === 0)

const hotspotsStories = {}
require('json!./hotspots_stories.json').map(s => hotspotsStories[s.ags] = s)
const hotspots = d3.csvParse(require('raw!./hotspots.csv')).map(d => {
  d.state = states[d.s]
  d.story = hotspotsStories[d.ags].text
  return d
})  // .sort((a, b) => a.pai - b.pai)

module.exports = {
  search,
  states,
  hotspots
}
