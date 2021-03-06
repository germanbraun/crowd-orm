# eerfactory.coffee --
# Copyright (C) 2016 GILIA

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
erd = joint.shapes.erd

exports = exports ? this
exports.model = exports.model ? {}
exports.model.eer = exports.model.eer ? {}

# ERD Factory for creating JointJS shapes representing a primitive in
# its plugins.
#
# @namespace model.eer
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
            attrs: {
            	text: {
            		fill: "#000000",
            		text: class_name,
            		'letter-spacing': 0,
            	#	style: { 'text-shadow': '1px 0 1px #000000' }
            	},
            	'.outer, .inner': {
            		fill: '#31d0c6',
            		stroke: 'none',
            		filter: { name: 'dropShadow',  args: { dx: 0.5, dy: 2, blur: 2, color: '#333333' }}
            		}
            }

#       	if css_class?
#       		params.attrs = css_class

       	newclass = new erd.Entity( params )

        return newclass

    create_attribute: (attr_name, attr_type, css_class=null) ->

    	if attr_type == 'key'
    		   newattribute = new erd.Key({position: {x:200, y:10}, attrs: {text: {fill: '#ffffff', text: attr_name}}})
        else
       	      newattribute = new erd.Normal({position: {x:150, y:150}, attrs: {text: {fill: '#ffffff', text: attr_name,  style: { 'text-shadow': '1px 0 1px #333333' }}}})


        return newattribute

    # @param class_entity
    # @param attr_name
    create_link_attribute: (class_name, attr_name) ->

        markup_style = ['<path class="connection" stroke="black" d="M 0 0 0 0"/>','<path class="connection-wrap" d="M 0 0 0 0"/>','<g class="labels"/>','<g class="marker-vertices"/>','<g class="marker-arrowheads"/>']

        myLink = new erd.Line({
          markup: markup_style.join(''),
          source: {id: attr_name},
          target: {id: class_name}
          })

        return myLink

    # @param mult {Array} only for class_name and rel_name playing only one role
    create_link_relationship: (class_name, rel_name, css_links = null, mult = null, roles = null)  ->
        markup_style = ['<path class="connection" stroke="black" d="M 0 0 0 0"/>','<path class="connection-wrap" d="M 0 0 0 0"/>','<g class="labels"/>','<g class="marker-vertices"/>','<g class="marker-arrowheads"/>']

        link = new erd.Line({
          markup: markup_style.join(''),
          source: {id: rel_name},
          target: {id: class_name}
          })

        # Format the strings for the labels.
        str_labels = [null, null]
        if roles isnt null
            str_labels[0] = roles

        if mult isnt null
            str_labels[1] = mult

        labels = ["",""]

        # from and to association roles and mult
        if str_labels == null
            labels =
                position: 0.5,
                attrs:
                    text: {text: "", fill: '#000000'},
                    rect: {fill: '#f9f9f9'}

        else if str_labels isnt null
          if (str_labels[0] == null) and (str_labels[1] isnt null)
            labels[0] =
                position: 0.9,
                attrs:
                    text: {text: "", fill: '#000000'},
                    rect: {fill: '#f9f9f9'}
            labels[1] =
                position: 0.5,
                attrs:
                    text: {text: str_labels[1], fill: '#000000'},
                    rect: {fill: '#f9f9f9'}

          else if (str_labels[0] isnt null) and (str_labels[1] == null)
            labels[0] =
                position: 0.9,
                attrs:
                    text: {text: str_labels[0], fill: '#000000'},
                    rect: {fill: '#f9f9f9'}
            labels[1] =
                position: 0.5,
                attrs:
                    text: {text: "", fill: '#000000'},
                    rect: {fill: '#f9f9f9'}
          else
                  labels[0] =
                      position: 0.9,
                      attrs:
                          text: {text: str_labels[0], fill: '#000000'},
                          rect: {fill: '#f9f9f9'}
                  labels[1] =
                      position: 0.5,
                      attrs:
                          text: {text: str_labels[1], fill: '#000000'},
                          rect: {fill: '#f9f9f9'}

        link.set({labels: labels})
        return link


    # @param label {String} label for link between entities and relationships
    # @todo refactoring attrs
    create_label: (label) ->
      return {
        labels: [{
          position: -20,
          attrs:{
            text: { dy: -8, text: label, fill: '#ffffff' },
            rect: { fill: 'none' }
          }
          }]
      }

    # @param css_links {Hash} A Hash representing the CSS. See JointJS documentation for the attrs attribute.
    # @param disjoint {Boolean} Draw a "disjoint" legend.
    # @param covering {Boolean} Draw a "covering" legend.
    # @return [joint.shapes.uml.Generalization]
    create_generalization: (class_a_id, class_b_id, css_links = null, disjoint=false, covering=false) ->
        labels = []

        isaattr = { text: {text: 'ISA', fill: '#ffffff','letter-spacing': 0,style: { 'text-shadow': '1px 0 1px #333333' }}, polygon: {fill: '#fdb664',stroke: 'none',filter: { name: 'dropShadow',  args: { dx: 0, dy: 2, blur: 1, color: '#333333' }}}}

        link = new erd.ISA({position: { x: 125, y: 200 },attrs: isaattr})

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


    # Create a relationship link.
    #
    # @param mult [array] The multiplicity strings.
    # @param roles [array] An array of two strings with the roles names.
    #
    # @return [joint.dia.Link]
    # @todo refactoring relationship styles
    create_association: (class_a_id, class_b_id, name, css_links = null, mult = null, roles = null) ->

      rel = new erd.Relationship({
        attrs: {
          text: {
            fill: "#ffffff",
            text: name,
            'letter-spacing': 0,
            style: {'text-shadow': '1px 0 1px #333333'}
          },
          '.outer': {
            fill: '#797d9a',
            stroke: 'none',
            filter: {name: 'dropShadow', args: {dx: 0, dy: 2, blur: 1, color: '#333333'}}
          }
        }
        })

      return rel


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


exports.model.eer.ERDFactory = ERDFactory
