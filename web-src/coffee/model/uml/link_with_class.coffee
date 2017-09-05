# link_with_class.coffee --
# Copyright (C) 2017 Giménez, Christian

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

exports = exports ? this
exports.model = exports.model ? {}
exports.model.uml = exports.model.uml ? {}

# A link with association class.
#
# Also manage the association link, wich is the link that goes through the
# middle of the link with to the association class; the association class, which
# represent the association and is at the middle of the association link.
#
# @namespace model.uml
class LinkWithClass extends model.uml.Link
   
    constructor: (@classes, name) ->
        super(@classes, name)
        @mult = [null,null]

        @assoc_class = new model.uml.Class(name)
        @j_assoc_link = null
        # Easy access to the assoc_class.get_joint().
        @j_assoc_class = null

    # As {Link#create_joint}, but it also creates the association link and class.
    #
    # Also, inherit the same parameters.
    #
    # @return [Array] A list of joint objects created by the factory given.
    # @see MyModel#create_joint
    create_joint: (factory, csstheme = null) ->
        super(factory, csstheme)

        # Easy access to the Joint of associated class.
        #
        # A better approach has to be used instead of this, but for now it should work.
        # 
        # @todo craete a Class subclass "AssociateClass" and delegate some methods instead of asking for the joint.
        @j_assoc_class = @assoc_class.get_joint(factory, csstheme)[0]
        
        @j_assoc_link = factory.create_association_link(csstheme.css_assoc_links)
        # @j_assoc_class = factory.create_association_class(@name, csstheme.css_class)

        @joint.push(@j_assoc_link)
        @joint.push(@j_assoc_class)

        # It doesn't work. It is the scope of "this" or maybe another problem.
        # @joint[0].on('change:attrs', this.update_position)
        # @classes[0].get_joint()[0].on('change:position', this.update_position)
        # @classes[1].get_joint()[0].on('change:position', this.update_position)
        @classes[0].attach_on_change_position(this)
        @classes[1].attach_on_change_position(this)

    # Update position of the association link and association class
    # according tot he target and source classes (it must be half a way).
    update_position: () ->
        if (@j_assoc_link?) and (@j_assoc_class?)
            # For some misterious reason, you have to add some joint elements ids
            # on source and target. If not it will not associate the link with the
            # Element provided, instead it will still points to (10,10) coordinates.
            #
            # For this reason, we have to initialize with some ids that already
            # has been loaded into the graph object.
            @j_assoc_link.set('source',
                id: @classes[0].get_joint()[0].id
            )
            @j_assoc_link.set('target',
                id: @classes[1].get_joint()[0].id
            )

            # Now we can proceed asigning the source and target accordingly
            # Calculate the middle of the association's line, translate the
            # association class to that middle and a bit down.
            # Finally, set it to the source of the dashed line. Its target is
            # the association class.
            target_pos = @classes[1].get_joint()[0].position()            
            source_pos = @classes[0].get_joint()[0].position()
            target_size = @classes[1].get_joint()[0].attributes.size
            source_size = @classes[0].get_joint()[0].attributes.size
            middlex = Math.abs(target_pos.x + source_pos.x + target_size.width/2 + source_size.width/2  ) / 2
            middley = Math.abs(target_pos.y + source_pos.y + target_size.height/2 + source_size.height/2) / 2

            @j_assoc_class.position(middlex, middley + 100)
            @j_assoc_link.set('source',
                x: middlex,
                y: middley
            )
            @j_assoc_link.set('target',
                id: @j_assoc_class.id
            )

    # Exports to JSON
    #
    # Also adds the key "associated_class" and add the JSON of the associated class.
    # 
    # @return [object] The JSON object.
    # 
    # @see MyModel#to_json
    # @see Link#to_json
    to_json: () ->
        json = super()
        json.associated_class = @assoc_class.to_json()

        return json


exports.model.uml.LinkWithClass = LinkWithClass
