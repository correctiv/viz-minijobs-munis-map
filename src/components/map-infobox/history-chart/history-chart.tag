import initChart from './init_history_chart.js'
import drawLine from './draw_line.js'
import updateLine from './update_line.js'
import transformData from './transform_data.js'

<history-chart class={ opts.getclass('history-chart') }>

  this.drawed = false  // identify if we already drawed a line
  this.ags = null  // remember which city we currently show

  this.on('mount', () => {
    this.chart = initChart({
      element: this.root,
      getclass: this.opts.getclass,
    }, this.opts.config)
  })

  this.on('update', () => {
    if (this._doUpdate(this.opts.data)) {
      const {g, line} = this.chart
      const data = transformData(this.opts.data, this.opts.config.keys)
      if (data) {
        if (this.drawed) {
          updateLine({g, line, data})
        } else {
          drawLine({g, line, data})
          this.drawed = true
        }
      }
    }
  })

  this._doUpdate = ({ags}) => {
    if (this.ags === ags) {
      return false
    } else {
      this.ags = ags
      return true
    }
  }

</history-chart>
