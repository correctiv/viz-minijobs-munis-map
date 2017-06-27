import {search, states} from '../../data/entry.js'

<map-searchbox class={ getClass() }>

  <input type="text"
    oninput={ doSearch } class={ getClass('input') }
    placeholder="Suche nach Deiner Stadt oder Postleitzahl..."
  />
  <ul if={ results.length } class={ getClass('result-list') }>
    <li each={ results }
      class={ parent.getClass('result-list__item') }
      onclick={ handleClick }>
      { name }
      <span>{ plz }, { states[state] }</span>
    </li>
  </ul>

  this.results = []
  this.states = states

  this.doSearch = e => {
    riot.control.trigger(riot.EVT.hideInfobox)
    const str = e.target.value.toLowerCase()
    if (str.length > 2) {
      const results = search(str)
      if (results.length === 1) {
        this.clearResults()
        this._jumpTo(results[0])
      } else {
        this.update({results})
      }
    } else {
      this.clearResults()
    }
  }

  this.handleClick = e => {
    this.clearResults()
    this._jumpTo(e.item)
  }

  this.clearResults = () => {
    this.update({results: []})
  }

  riot.control.on(riot.EVT.clearResults, () => {
    this.clearResults()
  })

  this._jumpTo = data => {
    riot.control.trigger(riot.EVT.mapJumpTo, data)
  }

</map-searchbox>
