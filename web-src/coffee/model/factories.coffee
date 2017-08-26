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
erd = joint.shapes.erd
orm = joint.shapes.orm

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
        

exports.model.Factory = Factory


