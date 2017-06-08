import * as d3 from '../../../scripts/lib/d3.js'

const formatDate = d3.timeFormat('%Y')
const parseDate = d3.timeParse('%Y')

module.exports = {
  fromDate: date => formatDate(date),
  toDate: str => parseDate(str),
  convertDate: str => formatDate(parseDate(str))
}
