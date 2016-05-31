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
        fill: "#aaf"
        stroke: "#000"
        'stroke-width': 0.5
    '.uml-class-attrs-rect' : 
        fill: "#ddf"
        stroke: "#000"
        'stroke-width': 0.5
        visibility: 'collapse'
    '.uml-class-methods-rect' : 
        fill: "#ddf"
        stroke: "#000"
        'stroke-width': 0.5
        visibility: 'collapse'
    '.uml-class-name-text' :
        fill: "#00f"
    '.uml-class-attrs-text': 
        ref: '.uml-class-attrs-rect',
        'ref-y': 0.5
        'y-alignment': 'middle'
        visibility: 'collapse'
    '.uml-class-methods-text':
        ref: '.uml-class-methods-rect',
        'ref-y': 0.5
        'y-alignment': 'middle'
        visibility: 'collapse'

    


exports = exports ? this
exports.csstheme = {}
exports.csstheme.css_class = css_class
