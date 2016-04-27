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

uml = joint.shapes.uml

class Factory
    constructor: () ->

    # Create a class representation.
    create_class: (name) ->

    create_association: (class_a_id, class_b_id, name = null ) ->
        
                
class UMLFactory
   
    constructor: () ->
    
    create_class: (class_name, css_class=null) ->
        params =
            position: {x: 20, y: 20}
            size: {width: 220, height: 100}
            name: class_name
            attributes: []
            methods: []

        if css_class != null
            params.attrs = css_class

        nueva = new uml.Class( params )
            
        return nueva

    create_association: (class_a_id, class_b_id, name = null) ->
        link = new joint.dia.Link(
                source: {id: class_a_id},
                target: {id: class_b_id}
                )
                
        if name != null
            link.set(
                labels: [
                    position: -20,
                    attrs: 
                        text: {dy: -y , text: name, fill: '#ffffff'},
                        rect: {fill: 'none'} 
                ]
            )
            
        return link


class ERDFactory
    constructor: () ->
    
    create_class: () ->
        

# If exports doesn't exists, use "this".
exports = exports ? this

exports.Factory = Factory
exports.UMLFactory = UMLFactory
exports.ERDFactory = ERDFactory

