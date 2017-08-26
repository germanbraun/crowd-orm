# ormfactory.coffee --
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
erd = joint.shapes.erd

exports = exports ? this
exports.model = exports.model ? {}

# *Abstract class.*
#
# Factory class for defining common behaviour of all JointJS plugins primitives.
#
# @namespace model
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
#
# @namespace model
class UMLFactory extends model.Factory
   
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

        newclass = new model.Class( params )
            
        return newclass

    # Create an association links.
    # 
    # @param mult [array] The multiplicity strings.
    # @param roles [array] An array of two strings with the roles names.
    # 
    # @return [joint.dia.Link]
    create_association: (class_a_id, class_b_id, name = null, css_links = null, mult = null, roles = null) ->
        link = new joint.dia.Link(
            source: {id: class_a_id}
            target: {id: class_b_id}
            attrs: css_links
        )

        # Format the strings for the labels.
        str_labels = [null, null, null]
        if roles isnt null
            if roles[0] isnt null
                str_labels[0] = roles[0]
            if roles[1] isnt null
                str_labels[2] = roles[1]

        if mult isnt null
            if mult[0] isnt null
                if str_labels[0] isnt null
                    str_labels[0] += "\n" + mult[0]
                else
                    str_labels[0] = mult[0]
            if mult[1] isnt null
                if str_labels[2] isnt null
                    str_labels[2] += "\n" + mult[1]
                else
                    str_labels[2] = mult[1]

        str_labels[1] = name

        # Create the labels objects.

        labels = []
        # name
        if str_labels[1] isnt null
            labels[1] =
                position: 0.5
                attrs: 
                    text: {text: str_labels[1], fill: '#0000ff'}
                    rect: {fill: '#ffffff'} 

        # from and to association roles and mult
        if str_labels[0] isnt null
            labels[0] =
                position: 0.1,
                attrs:
                    text: {text: str_labels[0], fill: '#0000ff'},
                    rect: {fill: '#ffffff'}
        if str_labels[2] isnt null
            labels[2]=
                position: 0.9,
                attrs:
                    text: {text: str_labels[2], fill: '#0000ff'},
                    rect: {fill: '#ffffff'}                

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
 #                )


    # Create an association class.
    # 
    # 
    # @see #create_class
    create_association_class: (class_name, css_class = null) ->
        return this.create_class(class_name, css_class)

    # Create an association link only (the one dashed one that appears between
    # the UML association and the UML association class).
    #
    # @return [joint.dia.Link] a Joint Link object.
    create_association_link: (css_assoc_links = {"stroke-dasharray": "5,5"}) ->
        # For some misterious reason, you have to add some joint elements ids
        # on source and target. If not it will not associate the link with the
        # Element provided, instead it will still points to (10,10) coordinates.
        
        link = new joint.dia.Link(
            source: {x: 10, y: 10},
            target: {x: 100, y: 100},
            attrs: css_assoc_links
        )

        return link


# @todo ERDFactory is not yet implemented. This factory is beyond the scope for this prototype.
# 
# @namespace model
class ERDFactory extends model.Factory
    
    constructor: () ->
    
    # @overload create_class(class_name, css_class=null)
    #     @param [hash] css_class A CSS class definition in a
    #     Javascript hash. See the JointJS documentation and demos.
    # 
    # @return [joint.shapes.erd.Entity] 
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

        newentity = new model.Entity( params )
            
        return newentity
        


exports.model.Factory = Factory
exports.model.UMLFactory = UMLFactory
exports.model.ERDFactory = ERDFactory

