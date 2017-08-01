<fallback-static-map class={ getClass() }>
  <section class="{ getClass('messagebox') } { -visible: visible }">
    <button class={ getClass('messagebox__close-btn') } aria-label='Close' onclick={ close }></button>
    <h3 class={ getClass('messagebox__title') }>Schade,</h3>
    <p>Dein Browser unterstützt unsere interaktive Karte leider nicht.
      Du kannst trotzdem die Suchleiste oben benutzen, um die Daten für Deine
      Stadt oder Gemeinde zu sehen.</p>
  </section>
  <img src="https://correctiv.github.io/viz-minijobs-munis-map/dist/img/germany_placeholder.jpg" class={ getClass('placeholder-img') } />

  this.visible = true
  this.close = () => this.update({visible: false})
</fallback-static-map>
