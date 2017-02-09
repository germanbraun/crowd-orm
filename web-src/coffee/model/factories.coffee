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
            size: {width: 100, height: 50}
            name: class_name
            attributes: []
            methods: []
            attrs:
                '.uml-class-name-rect':
                    fill: '#ffffff'
                    stroke: '#000000'
                '.uml-class-name-text':
                    fill: '#000000'                    

        if css_class?
            params.attrs = css_class

        newclass = new uml.Class( params )
            
        return newclass

    # Create an association links.
    # 
    # @param [array] mult The multiplicity strings.
    # @return [joint.dia.Link]
    create_association: (class_a_id, class_b_id, name = null, css_links = null, mult = null) ->
        link = new joint.dia.Link(
            source: {id: class_a_id}
            target: {id: class_b_id}
            attrs: css_links
        )

        labels = []
        if name != null
            labels = labels.concat([
                position: 0.5
                attrs: 
                    text: {text: name, fill: '#0000ff'}
                    rect: {fill: '#ffffff'} 
                ])
        if mult != null
            if mult[0] != null
                labels = labels.concat([
                    position: 0.1,
                    attrs:
                        text: {text: mult[0], fill: '#0000ff'},
                        rect: {fill: '#ffffff'}
                ])
            if mult[1] != null
                labels = labels.concat([
                    position: 0.9,
                    attrs:
                        text: {text: mult[1], fill: '#0000ff'},
                        rect: {fill: '#ffffff'}
                ])

        link.set({labels: labels})
        return link

    # @param css_links {Hash} A Hash representing the CSS. See JointJS documentation for the attrs attribute.
    # @param disjoint {Boolean} Draw a "disjoint" legend.
    # @param covering {Boolean} Draw a "covering" legend.
    # @return [joint.shapes.uml.Generalization]
    create_generalization: (class_a_id, class_b_id, css_links = null, disjoint=false, covering=false) ->
        labels = []
        
        link = new joint.shapes.uml.Generalization(
            source: {id: class_b_id}
            target: {id: class_a_id}
            attrs: css_links
        )

        if disjoint || covering
            legend = "{"
            if disjoint then legend = legend + "disjoint"
            if covering
                if legend != ""
                    legend = legend + ","
                legend = legend + "covering"
            legend = legend + "}"

        labels = labels.concat([
            position: 0.8
            attrs:
                text:
                    text: legend
                    fill: '#0000ff'
                rect: 	
                    fill: '#ffffff'
                    
        ])

        link.set({labels: labels})
        return link

 #       link.set(
 #               labels: ([
 #                   position: 0.8,
 #                   attrs:
 #                       text: {text: legend, fill: '#0000ff'},
 #                       rect: {fill: "#ffffff"}])
 #				)


    # Create an association link with it association class.
    # 
    # @param [array] mult The multiplicity strings.
    # @return [joint.dia.Link]
    create_association_class: (class_a_id, class_b_id, name, css_links = null, mult = null) ->
        link = new joint.dia.Link(
            source: {id: class_a_id}
            target: {id: class_b_id}
            attrs: css_links
        )

        labels = []
        # labels = labels.concat([
        #     position: 0.5
        #     attrs: 
        #         text: {text: name, fill: '#0000ff'}
        #         rect: {fill: '#ffffff'} 
        #     ])
        if mult != null
            if mult[0] != null
                labels = labels.concat([
                    position: 0.1,
                    attrs:
                        text: {text: mult[0], fill: '#0000ff'},
                        rect: {fill: '#ffffff'}
                ])
            if mult[1] != null
                labels = labels.concat([
                    position: 0.9,
                    attrs:
                        text: {text: mult[1], fill: '#0000ff'},
                        rect: {fill: '#ffffff'}
                ])

        link.set({labels: labels})

        # I'm sorry! But I have to use graph for this.
        # getSourceElement() and getTargetElement()
        # doesn't work if the link is not associated with a graph!
        target_pos = graph.getCell(class_b_id).position()
        source_pos = graph.getCell(class_a_id).position()

        x = Math.abs(target_pos.x - source_pos.x) / 2
        y = Math.abs(target_pos.y - source_pos.y) / 2

        assoc_class = create_class(name)
        assoc_class.position(x,y)
        link.assoc_class = assoc_class

        link.on('change', () ->
            target_pos = link.getTargetElement().position()
            source_pos = link.getSourceElement().position()

            x = Math.abs(target_pos.x - source_pos.x) / 2
            y = Math.abs(target_pos.y - source_pos.y) / 2

            this.assoc_class.position(x,y)
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

