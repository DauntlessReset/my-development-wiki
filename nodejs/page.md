# Node JS

This page will contain NodeJS documentation.

# Attempting to create charts in markdown using Charty extension TODO


    <!-- Charty -->
    <script src="//unpkg.com/@markbattistella/docsify-charty@latest/dist/docsify-charty.min.js"></script>
    <link rel="stylesheet" href="//unpkg.com/@markbattistella/docsify-charty@latest/dist/docsify-charty.min.css">


```charty
{
  "title":   "Pie chart",
  "caption": "With a caption",
  "type":    "pie",
  "options": {
    "legend":  true,
    "labels":  true,
    "numbers": true
  },
  "data": [
      { "label": "2012", "value": 1024 },
      { "label": "2010", "value": 200 },
      { "label": "2011", "value": 560 }
  ]
}
```