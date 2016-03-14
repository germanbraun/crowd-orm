# diagrama.coffee --
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

# {UMLFactory} = require './factories'

class Diagrama
    ##
    # Params.:
    # * graph: Una instancia de joint.Graph.
    constructor: (@graph = null) ->
        @clases = []
        @links = []
        @cells_nuevas = []
        @factory = new UMLFactory()

    get_factory: () ->
        return @factory

    set_factory: (@factory) ->
        
    get_graph: () ->
        return @graph

    set_graph: (@graph) ->

    get_clases: () ->
        return @clases

    get_links: () ->
        return @links

    get_clase: (nombre) ->
        
    agregar_clase: (clase) ->
        @clases.push(clase)
        @cells_nuevas.push(clase.get_joint(@factory))
        this.actualizar_graph()
    
    agregar_link: (link) ->
        @links.push(link)
        @cells_nuevas.push(link.get_joint(@factory));
        this.actualizar_graph()

    # Actualizar una instancia de joint.Graph con las nuevas celdas.
    actualizar_graph: () ->
        @graph.addCell(@cells_nuevas)
        @cells_nuevas = []

    ##
    # Return a JSON representing the Diagram.
    #
    # We want to send only some things not all the JSON the object
    # has. So, we drop some things, like JointJS graph objects.
    #
    # Use JSON.stringify(json_object) to translate a JSON object to
    # string.
    to_json : () ->
        classes_json = []
        $.each @clases, (myclass) ->
            classes_json.push(myclass.to_json())

        links_json = []
        $.each @links, (mylink) ->
            links_json.push( mylink.to_json())

        classes: classes_json
        links: links_json
                
        
exports = exports ? this

exports.Diagrama = Diagrama



