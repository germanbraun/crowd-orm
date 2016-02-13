# factories.coffee --
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

# If exports doesn't exists, use "this".
exports ? this 

uml = joint.shapes.uml

css_classes =
        '.uml-class-name-rect' : 
        	fill: "#fff"
        '.uml-class-attrs-rect' : 
        	fill: "#fff"
        '.uml-class-methods-rect' : 
        	fill: "#fff"

class Factory
        constructor: () ->

        # Create a class representation.
        create_class: (name) ->
                
class UMLFactory
        constructor: () ->

        create_class: (name) ->
                nueva = new uml.Class
                        position: {x: 20, y: 20}
                        size: {width: 220, height: 100}
                        name: name
                        attributes: []
                        methods: []
                        attr: css_clases
                
                return nueva

class ERDFactory
        constructor: () ->
        
        create_class: () ->
        

exports.Factory = Factory
exports.UMLFactory = UMLFactory
exports.ERDFactory = ERDFactory
