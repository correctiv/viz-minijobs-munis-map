import dummyData from './_dummy_data.js'
import initChart from './init_history_chart.js'

<history-chart class={ opts.getclass('history-chart') }>

  this.on('mount', () => {
    this.chart = initChart({
      element: this.root,
      getclass: this.opts.getclass,
      data: dummyData
    }, this.opts.config)
  })

</history-chart>
