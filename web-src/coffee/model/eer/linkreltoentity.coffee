# linkisatoentity.coffee --
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
exports.model.eer = exports.model.eer ? {}


# @namespace model.eer
class LinkRelToEntity extends model.eer.LinkAttrToEntity

    constructor: (@classes, name=null) ->
        super(@classes, name)
        @mult = [null]
        @roles = [null]

    get_name: () ->
    	return @name

    get_mult: () ->
      return @mult

    get_role: () ->
      return @roles

    # Set the multiplicity.
    #
    # For example:
    # `[null, null]` or `["0..*", "0..*"]` means from 0..* to 0..*.
    # `[1..*, null]` means from 1..* to 0..*.
    #
    # @param [array] mult An array that describes the multiplicity in strings.
    set_mult : (@mult) ->
        this.change_to_null(m) for m in @mult

    # Change the from and to roles.
    #
    # @param [array] roles An array with two strings, the from and to roles.
    set_roles: (@role) ->

    change_to_null : (mult) ->
        if (mult == "0..*") or (mult == "0..n")
            @mult[0] = null

    # @see MyModel#create_joint
    create_joint: (factory, csstheme = null) ->
        if @joint == null
            @joint = []
            if csstheme != null
                @joint.push(factory.create_link_relationship(
                	@classes[0].get_classid(),
                	@classes[1].get_relid()
                    @name,
                    @mult,
                    @roles,
                    csstheme.css_links,
                    ))
            else
                @joint.push(factory.create_link_relationship(
                	@classes[0].get_classid(),
                	@classes[1].get_relid()
                    @name
                    @mult,
                    @roles,
                    null
                    ))


    to_json: () ->
        json = super()
        json.type = "relationship"

        return json


LinkRelToEntity.get_new_name = () ->
    if LinkRelToEntity.name_number == undefined
        LinkRelToEntity.name_number = 0
    LinkRelToEntity.name_number = LinkRelToEntity.name_number + 1
    return "r" + LinkRelToEntity.name_number

exports.model.eer.LinkRelToEntity = LinkRelToEntity
