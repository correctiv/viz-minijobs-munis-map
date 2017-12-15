# viz-minijobs-munis-map

Show minijobs data on municipality level with mapbox-gl.

[See in action at correctiv.org](https://correctiv.org/a/1868)

[Preview via gh-pages](https://correctiv.github.io/viz-minijobs-munis-map/dist/)

[Preview "hotspots view"](https://correctiv.github.io/viz-minijobs-munis-map/dist/hotspots)

Based on [wbkd/yet-another-webpack-es6-starterkit](https://github.com/wbkd/yet-another-webpack-es6-starterkit)

Uses [mapbox-gl](https://www.mapbox.com/mapbox-gl-js/), [d3](https://d3js.org) and [riotjs](https://riotjs.com)

There are two "views" of this map – the *normal* mode and a *hotspot*-mode, that shows some handpicked cities and some information about them. See below how to embed both versions.

There is also a "loading spinner" overlay on page loading. If all js is set up, it sets a `--loaded`-modifier to the overlay.

## base visualization setup for correctiv cms

### javascript

```
dist/bundle.js
```

### styles

```
dist/styles/bundle.css
```

## for use in correctiv cms plugins:

### normal mode

```html
<figure class="figure -full-width">
  <h2>So viele Leute arbeiten in Deiner Stadt in Minijobs</h2>
  <div class="mjmm-loading-spinner"></div>
  <div data-riot-mount="cor-mj-munis-map"></div>
  <div class="figure__credits">
    <strong>Daten:</strong> <a href="">Beschäftigungsstatistik der Bundesagentur für Arbeit: "Arbeitsmarkt in Zahlen"</a>,<br>
    eigene Berechnungen, aufgeschlüsselt nach Kreisen und Gemeinden, Stand: 31.12.2015
  </div>
</figure>
```

### hotspot mode

```html
<figure class="figure -full-width">
  <h2>So viele Leute arbeiten in Deiner Stadt in Minijobs</h2>

  <div class="figure__container">
    <div class="mjmm-loading-spinner"></div>
    <div class="mjmm-hotspots-container">
      <div data-riot-mount="cor-mj-munis-hotspots"></div>
    </div>
    <div class="mjmm-map-container">
      <div data-riot-mount="cor-mj-munis-map" data-is-hotspots="1"></div>
    </div>
  </div>

  <div class="figure__credits">
      <strong>Daten:</strong> <a href="">Beschäftigungsstatistik der Bundesagentur für Arbeit: "Arbeitsmarkt in Zahlen"</a>,<br>
      eigene Berechnungen, aufgeschlüsselt nach Kreisen und Gemeinden, Stand: 31.12.2015
  </div>
</figure>
```

## Development

### Installation

```
npm install
```

### Start Dev Server

```
npm run dev
```

### Build Prod Version

```
npm run build
```

### Features:

* ES6 Support via [babel-loader](https://github.com/babel/babel-loader)
* SASS Support via [sass-loader](https://github.com/jtangelder/sass-loader)
* Linting via [eslint-loader](https://github.com/MoOx/eslint-loader)
* Hot Module Replacement

When you run `npm run build` we use the [extract-text-webpack-plugin](https://github.com/webpack/extract-text-webpack-plugin) to move the css to a separate file and included in the head of your `index.html`, so that the styles are applied before any javascript gets loaded. We disabled this function for the dev version, because the loader doesn't support hot module replacement.

## Development

### Installation

```
npm install
```

### Start Dev Server

```
npm run dev
```

### Build Prod Version

```
npm run build
```

### Features:

* ES6 Support via [babel-loader](https://github.com/babel/babel-loader)
* SASS Support via [sass-loader](https://github.com/jtangelder/sass-loader)
* Linting via [eslint-loader](https://github.com/MoOx/eslint-loader)
* Hot Module Replacement

When you run `npm run build` we use the [extract-text-webpack-plugin](https://github.com/webpack/extract-text-webpack-plugin) to move the css to a separate file and included in the head of your `index.html`, so that the styles are applied before any javascript gets loaded. We disabled this function for the dev version, because the loader doesn't support hot module replacement.
