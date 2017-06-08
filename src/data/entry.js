const states = require('json!./states.json')

const searchData = require('dsv!./searchdata.csv')
const search = str => searchData.filter(d => d.search.indexOf(str) > -1 || d.plz.indexOf(str) === 0)

module.exports = {
  search,
  states
}
