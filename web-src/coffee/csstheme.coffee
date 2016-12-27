# csstheme.coffee --
# Copyright (C) 2016 Giménez, Christian

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.

# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# [JointJS special
# attributes](http://jointjs.com/api#SpecialAttributes) 
# [SVG
# attributes](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute)  
#
# Class style.
css_class = 
    '.uml-class-name-rect' : 
        fill: "#fff"
        stroke: "#000"
        'stroke-width': 0.5
    '.uml-class-attrs-rect' : 
        fill: "#ddf"
        stroke: "#000"
        'stroke-width': 0.5
        visibility: 'collapse'
        display: 'none'
    '.uml-class-methods-rect' : 
        fill: "#ddf"
        stroke: "#000"
        'stroke-width': 0.5
        visibility: 'collapse'
        display: 'none'
    '.uml-class-name-text' :
        fill: "#000"
    '.uml-class-attrs-text': 
        ref: '.uml-class-attrs-rect',
        'ref-y': 0.5
        'y-alignment': 'middle'
        visibility: 'collapse'
        display: 'none'
    '.uml-class-methods-text':
        ref: '.uml-class-methods-rect',
        'ref-y': 0.5
        'y-alignment': 'middle'
        visibility: 'collapse'
        display: 'none'

# [JointJS special
# attributes](http://jointjs.com/api#SpecialAttributes) 
# [SVG
# attributes](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute)  
#
# Unsatisfiable Class style.
css_class_unsatisfiable = 
    '.uml-class-name-rect' : 
        fill: "#faa"
        stroke: "#000"
        'stroke-width': 0.5
    '.uml-class-attrs-rect' : 
        fill: "#fdd"
        stroke: "#000"
        'stroke-width': 0.5
        visibility: 'collapse'
        display: 'none'
    '.uml-class-methods-rect' : 
        fill: "#fdd"
        stroke: "#000"
        'stroke-width': 0.5
        visibility: 'collapse'
        display: 'none'
    '.uml-class-name-text' :
        fill: "#00f"
    '.uml-class-attrs-text': 
        ref: '.uml-class-attrs-rect',
        'ref-y': 0.5
        'y-alignment': 'middle'
        visibility: 'collapse'
        display: 'none'
    '.uml-class-methods-text':
        ref: '.uml-class-methods-rect',
        'ref-y': 0.5
        'y-alignment': 'middle'
        visibility: 'collapse'
        display: 'none'



# [JointJS special
# attributes](http://jointjs.com/api#SpecialAttributes) 
# [SVG
# attributes](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute)  
#
# Links Style
css_links =
    '.connection' :
        'stroke': '#000',
        'stroke-width': 2


exports = exports ? this
exports.csstheme = {}
exports.csstheme.css_class = css_class
exports.csstheme.css_class_unsatisfiable = css_class_unsatisfiable
exports.csstheme.css_links = css_links
