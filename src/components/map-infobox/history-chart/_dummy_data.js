import {toDate} from './date.js'

const data = {
  years: [
    "2005",
    "2006",
    "2007",
    "2008",
    "2009",
    "2010",
    "2011",
    "2012",
    "2013",
    "2014",
    "2015",
    "2016"
  ],
  t: [
    10,
    9,
    8,
    9.5,
    10,
    11,
    12,
    11,
    10,
    10,
    10.5,
    9
  ],
  e: [
    10,
    9,
    8,
    9.5,
    10,
    11,
    12,
    11,
    10,
    10,
    10.5,
    9
  ].reverse(),
  i: [
    10,
    9,
    8,
    9.5,
    10,
    11,
    12,
    11,
    10,
    10,
    10.5,
    9
  ].map(x => x*.9)
}

export default Object.keys(data).slice(1).map(k => {
  return {
    id: k,
    values: data[k].map((d, i) => {
      return {
        year: toDate(data.years[i]),
        value: +d
      }
    })
  }
})
