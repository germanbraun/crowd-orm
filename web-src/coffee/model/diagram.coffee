# diagram.coffee --
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


# Abastract class for diagrams.
class Diagram

    #
    # @param graph [joint.Graph]. A joint Graph where all the diagram develops.
    # 
    constructor: (@graph = null) ->
        @factory = null

    # Reset the current diagram to start over empty.
    reset: () ->

    # Get the factory used for creating the joint.dia elements.
    #
    # @return [Factory] A factory subclass instance.
    get_factory: () ->
        return @factory

    # @param factory [Factory] Used for creating the joint.dia elements.
    set_factory: (@factory) ->
  
    #
    # @return [joint.graph]
    get_graph: () ->
        return @graph

    # @param graph [joint.graph]
    set_graph: (@graph) ->

    # Update the joint.Graph instance with the new cells.
    actualizar_graph: () ->

    # Return a JSON representing the Diagram.
    #
    # We want to send only some things not all the JSON the object
    # has. So, we drop some things, like JointJS graph objects.
    #
    # Use JSON.stringify(json_object) to translate a JSON object to
    # string.
    #
    # @return [object] A JSON object.
    to_json: () ->

    # Import the diagram in JSON format.
    #
    # @param json [object] A JSON object.
    import_json: (json) ->


exports = exports ? this

exports.Diagram = Diagram
