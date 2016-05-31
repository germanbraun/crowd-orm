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

# *Abstract class.*
#
# Factory class for defining common behaviour of all JointJS plugins primitives.
class Factory
    constructor: () ->

    # Create a class representation.
    #
    # @param [String] name the class name.
    # @return A JointJS class model.
    create_class: (name) ->

    # Create an association between two classes.
    #
    # @param [String] class_a_id the JointJS id of the first class.
    # @param [String] class_b_id the JointJS id of the second class.
    # @param [String] name the association name or tag.
    #
    # @return A JointJS link model.
    create_association: (class_a_id, class_b_id, name = null ) ->
        

# UML Factory for creating JointJS shapes representing a primitive in
# its plugins.
class UMLFactory extends Factory
   
    constructor: () ->

    # @overload create_class(class_name, css_class=null)
    #     @param [hash] css_class A CSS class definition in a
    #     Javascript hash. See the JointJS documentation and demos.
    # 
    # @return [joint.shapes.uml.Class] 
    create_class: (class_name, css_class=null) ->
        params =
            position: {x: 20, y: 20}
            size: {width: 100, height: 100}
            name: class_name
            attributes: []
            methods: []
            attrs: css_class

        if css_class != null
            params.attrs = css_class

        newclass = new uml.Class( params )
            
        return newclass

    # @return [joint.dia.Link]
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

# @todo ERDFactory is not yet implemented. This factory is beyond the scope for this prototype.
class ERDFactory extends Factory
    constructor: () ->
    
    create_class: () ->
        

# If exports doesn't exists, use "this".
exports = exports ? this

exports.Factory = Factory
exports.UMLFactory = UMLFactory
exports.ERDFactory = ERDFactory

