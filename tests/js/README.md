# QUnit: A JavaScript Unit Testing framework

# Usage (Executing Tests)

Make available all the wicom directory (root directory of this project). Then, compile CoffeeScripts into Javascript using `scripts/compile-coffee.sh`.

Open your browser at this directory and visit the index.html file (http://localhost/wicom/tests/js/index.html if you configured the Apache/Nginx server with http://localhost/wicom virtual path at the wicom main directory).

# Writing Test Units

1. Create a new `{ModuleName}TestSuite.html` in this folder and
code a test for each module function.

```html
<html>
<head>
  <meta charset="utf-8">
  <title>Tests suite</title>
 
  <link rel="stylesheet" href="./qunit-1.22.0.css">
  <script src="./qunit-1.22.0.js"></script>
  <script src="../web-src/js/{ModuleName}.js"></script>
 
  <script>
  QUnit.test("{featureName}Test", function( assert ) {
    var now = "";
    assert.equal({functionName}(), now);

  });
  </script>
</head>
<body>
 
<div id="qunit"></div>
 
</body>
</html>

```

## CoffeeScript Template
A template is provided at `./coffee/template.coffee`.
