<hotspot-item class={ getClass() }>

  <header class="{ getClass('header') } { -active: opts.active }" onclick={ onClick }>
    <span class={ getClass('state')}>{ opts.data.state }</span>
    <h4 class={ getClass('title') }>{ opts.data.gen }</h4>
  </header>
  <section class="{ getClass('section') } { -active: opts.active }">
    <p><strong>Einwohner:</strong> { opts.data.t }<br>
        <strong>Minijobber:</strong> { opts.data.ai } ({ _f(opts.data.pai) } %)
    </p>
    <p>{ opts.data.story }</p>
  </section>

  this.onClick = ({item}) => {
    this.opts.action(item.hotspot)
  }
</hotspot-item>
