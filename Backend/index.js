const express = require('express')

const series = require('./data/series.json')
const characters = require('./data/characters.json')
const characters_detail = require('./data/characters_detail.json')
const quotes = require('./data/quotes.json')

const app = express()
const port = 3000

app.use('/images', express.static(`${__dirname}/images`))

app.get('/series', (req, res) => {
  res.json(series)
})

app.get('/characters', (req, res) => {
  res.json(characters)
})

app.get('/characters/detail', (req, res) => {
  const id = req.query.id

  const character = characters_detail.find(character => character.id == id)
  res.json(character)
})

app.get('/quotes', (req, res) => {
  res.json(quotes)
})

app.listen(port, () => {
  console.log(`AtomlesApp listening at http://localhost:${port}`)
})