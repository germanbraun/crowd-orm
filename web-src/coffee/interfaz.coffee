# interfaz.coffee --
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


# {Diagrama} = require './diagrama'
# {Class} = require './mymodel'

# Un poco de aliasing para acortar el código.
uml = joint.shapes.uml;

# ---------------------------------------------------------------------- 

graph = new joint.dia.Graph
diag = new Diagrama(graph)

paper = new joint.dia.Paper(
        el: $('#container')
        width: 1000
        height: 1000
        model: graph
        gridSize: 1
)

css_clase = 
        '.uml-class-name-rect' : 
            fill: "#fff"
        '.uml-class-attrs-rect' : 
        	fill: "#fff"
        '.uml-class-methods-rect' : 
        	fill: "#fff"
        
# Interfaz

##
# CrearClaseView proporciona los elementos y eventos necesarios
#   para mostra una interfaz para crear una clase.
CrearClaseView = Backbone.View.extend(    
        initialize: () ->
        	this.render()
    
        render: () ->
            template = _.template( $("#template_crearclase").html(), {} )
            this.$el.html(template)

        events: 
        	"click a#crearclase_button" :
                        "crear_clase"
                "click a#translate_button" :
                        "translate_owllink"

        crear_clase: (event) ->
            alert("Creando: " + $("#crearclase_input").val() + "...")
            nueva = new Class($("#crearclase_input").val(), [], [])
            diag.agregar_clase(nueva)

        ##
        # Event handler for translate diagram to OWLlink using Ajax
        # and the translator/calvanesse.php translator URL.
        translate_owllink: (event) ->
                json = JSON.stringify(diag.to_json())
                $.post(
                        "translator/calvanesse.php",
                        "json":
                                json
                        (data) ->
                                $("#owllink_source").text(data)
                                console.log(data)
                )
                
);

EditClassView = Backbone.View.extend(
    initialize: () ->
        this.render()

    render: () ->
        template = _.template( $("#template_editclass").html())
        this.$el.html(template({classid: @classid}))

    events:
        "click a#editclass_button" : "edit_class"

    # Set this class ID and position the form onto the
    # 
    # Class diagram.
    set_classid : (@classid) ->
        viewpos = graph.getCell(@classid).findView(paper).getBBox()

        this.$el.css(
            top: viewpos.y,
            left: viewpos.x,
            position: 'absolute',
            'z-index': 1
            )
        this.$el.show()

    get_classid : () ->
        return @classid
    
    edit_class: (event) ->
        # Set the model name
        cell = graph.getCell(@classid)
        cell.set("name", $("#editclass_input").val())
        
        # Update the view
        v = cell.findView(paper)
        v.update()

        # Hide the form.
        this.$el.hide()
)

ClassOptionsView = Backbone.View.extend(
    initialize: () ->
        this.render()

    render: () ->
        template = _.template( $("#template_classoptions").html() )
        this.$el.html(template({classid: @classid}))

    events:
        "click a#deleteclass_button" : "delete_class",
        "click a#editclass_button" : "edit_class"

    set_classid: (@classid) ->
        viewpos = graph.getCell(@classid).findView(paper).getBBox()

        this.$el.css(
            top: viewpos.y,
            left: viewpos.x,
            position: 'absolute',
            'z-index': 1
            )
        this.$el.show()

    get_classid: () ->
        return @classid
        
    delete_class: (event) ->
        model = graph.getCell(@classid)
        model.remove()
        this.hide()

    edit_class: (event) ->
        # editclass = new EditClassView({el: $("#editclass")})
        editclass.set_classid(@classid)        
        this.hide()

    hide: () ->
        this.$el.hide()
)

# Events for the Paper

# A Cell was clicked: select it.
paper.on("cell:pointerclick",
    (cellView, evt, x, y) ->
        if (cellView.highlighted == undefined or cellView.highlighted == false) 
            cellView.highlight()
            cellView.highlighted = true

            # classoptions = new ClassOptionsView({el: $("#classoptions")})
            classoptions.set_classid(cellView.model.id)
        else
            cellView.unhighlight()
            cellView.highlighted = false
            classoptions.hide()
)

# paper.on("cell:pointerdblclick",
#     (cellView, evt, x, y) ->
#         if classoptions != null then classoptions.hide()
#         editclass = new EditClassView({el: $("#editclass")})
#         editclass.set_classid(cellView.model.id)

# )
        
# Instancia de CrearClaseView.
# 
crearclase = new CrearClaseView({el: $("#crearclase")});
editclass = new EditClassView({el: $("#editclass")})
classoptions = new ClassOptionsView({el: $("#classoptions")})

exports = exports ? this

exports.graph = graph
exports.diag = diag
exports.paper = paper
exports.CrearClaseView = CrearClaseView
exports.editclass = editclass
exports.ClassOptionsView = ClassOptionsView
exports.editclass = editclass
exports.classoptions = classoptions

# Presentamos una inicial clase de ejemplo
nueva = new Class("Test Class", [], [])
diag.agregar_clase(nueva)
