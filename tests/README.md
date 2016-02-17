# QUnit: A JavaScript Unit Testing framework

## Usage

1. Create a new `{ModuleName}TestSuite.html` in `test` folder and
code a test for each module function.

<html>
<head>
  <meta charset="utf-8">
  <title>Tests suite</title>
 
  <link rel="stylesheet" href="//code.jquery.com/qunit/qunit-1.21.0.css">
  <script src="//code.jquery.com/qunit/qunit-1.21.0.js"></script>
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


