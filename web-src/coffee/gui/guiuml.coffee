# guiuml.coffee --
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

exports = exports ? this
exports.gui = exports.gui ? {}


# @namespace gui
#
# Central GUI *do-it-all* class...
#
class GUIUML extends gui.GUIIMPL

    # Create a GUIUML instance.
    #
    # @param {JointJS.Graph } graph The JointJS Graph used for drawing models.
    # @param {JointJS.Paper} paper The JointJS Paper used for drawing views.
    constructor: (@graph = null, @paper = null) ->
        # @property [String] The URL prefix.
        @urlprefix = ""
        # @property [UMLDiagram] The user model diagram representation.
        @diag = new model.uml.UMLDiagram(@graph)

        @state = gui.get_state().selection_state()

        @crearclase = new views.CreateClassView({el: $("#crearclase")});
        @editclass = new views.EditClassView({el: $("#editclass")})
        @classoptions = new views.ClassOptionsView({el: $("#classoptions")})
        @relationoptions = new views.RelationOptionsView({el: $("#relationoptions")})
        @isaoptions = new views.IsaOptionsView({el: $("#isaoptions")})
        @toolbar = new views.ToolsUML({el: $("#lang_tools")})

        @trafficlight = new views.TrafficLightsView({el: $("#trafficlight")})

        @serverconn = new ServerConnection( (jqXHR, status, text) ->
            exports.gui.gui_instance.show_error(status + ": " + text , jqXHR.responseText)
        )

        $("#diagram-page").enhanceWithin()


    set_urlprefix: (str) -> @urlprefix = str

    # What to do when the user clicked on a cellView.
    on_cell_clicked: (cellview, event, x, y) ->
        @state.on_cell_clicked(cellview, event, x, y, this)

    ##
    # Set the class Id of the class options GUI.
    set_options_classid: (model_id) ->
        @relationoptions.set_classid(model_id)
        @classoptions.set_classid(model_id)
        @isaoptions.set_classid(model_id)

    ##
    # Hide the class options GUI.
    hide_options: () ->
        @classoptions.hide()
        @relationoptions.hide()
        @editclass.hide()
        @isaoptions.hide()

    set_editclass_classid: (model_id) ->
        # editclass = new EditClassView({el: $("#editclass")})
        @editclass.set_classid(model_id)

    #
    # Add a class to the diagram.
    #
    # @param hash_data {Hash} data information for creating the Class. Use `name`, `attribs` and `methods` keys.
    # @see Class
    # @see Diagram#add_class
    add_object_type: (hash_data) ->
        gui.gui_instance.hide_toolbar()
        @diag.add_class(hash_data)

    add_attribute: (hash_data) ->

    #
    # Delete a class from the diagram.
    #
    # @param class_id {string} a String with the class Id.
    delete_class: (class_id) ->
        @diag.delete_class_by_classid(class_id)

    # Change a class name identified by its classid.
    #
    # @example Getting a classid
    #   < graph.getCells()[0].id
    #   > "5777cd89-45b6-407e-9994-5d681c0717c1"
    #
    # @param class_id {string}
    # @param name {string}
    edit_class_name: (class_id, name) ->
        # Set the model name
        # cell = @graph.getCell(class_id)
        # cell.set("name", name)
        @diag.rename_class(class_id, name)

        # Update the view
        @diag.update_view(class_id, @paper)

    #
    # Add a simple association from A to B.
    # Then, set the selection state for restoring the interface.
    #
    # @example Getting a classid
    #   < graph.getCells()[0].id
    #   > "5777cd89-45b6-407e-9994-5d681c0717c1"
    #
    # @param class_a_id {string}
    # @param class_b_id {string}
    # @param name {string} optional. The association name.
    # @param mult {array} optional. An array of two string with the cardinality from class and to class b.
    add_relationship: (class_a_id, class_b_id, name=null, mult=null) ->
        @diag.add_association(class_a_id, class_b_id, name, mult)
        this.set_selection_state()

    add_relationship_attr: () ->

    # Add a Generalization link and then set the selection state.
    #
    # @param class_parent_id {string} The parent class Id.
    # @param class_child_id {string} The child class Id.
    #
    # @todo Support various children on parameter class_child_id.
    add_subsumption: (class_parent_id, class_child_id, disjoint=false, covering=false) ->
        @diag.add_generalization(class_parent_id, class_child_id, disjoint, covering)

    #
    # Put the traffic light on green.
    traffic_light_green: () ->
        @trafficlight.turn_green()

    #
    # Put the traffic light on red.
    traffic_light_red: () ->
        @trafficlight.turn_red()

    # Update the interface with satisfiable information.
    #
    # @param data {string} is a JSON string with the server response.
    update_satisfiable: (data) ->
        console.log(data)
        obj = JSON.parse(data);

        this.set_trafficlight(obj)
        $("#reasoner_input").html(obj.reasoner.input)
        $("#reasoner_output").html(obj.reasoner.output)
        $.mobile.loading("hide")
        this.set_unsatisfiable(obj.unsatisfiable.classes)
        this.set_satisfiable(obj.satisfiable.classes)
        # this.change_to_details_page()

    # Set the traffic-light according to the JSON object recived by the server.
    #
    # @param obj {JSON} The JSON object parsed from the recieved data.
    set_trafficlight: (obj) ->
        if (obj.satisfiable.kb)
            if (obj.unsatisfiable.classes.length == 0)
                @trafficlight.turn_green()
            else
                @trafficlight.turn_yellow()
        else
            @trafficlight.turn_red()

    # Show these classes as unsatisifable.
    #
    # @param classes_list {Array<String>} a list of classes names.
    set_unsatisfiable: (classes_list) ->
        @diag.set_unsatisfiable(classes_list)

    # Show these classes as satisifable.
    #
    # @param classes_list {Array<String>} a list of classes names.
    set_satisfiable: (classes_list) ->
        @diag.set_satisfiable(classes_list)

    # Send a POST to the server for checking if the diagram is
    # satisfiable.
    check_satisfiable: () ->
        $.mobile.loading("show",
            text: "Consulting server...",
            textVisible: true,
            textonly: false
        )
        @serverconn.request_satisfiable(
            this.diag_to_json(),
            (data) =>
                exports.gui.gui_instance.update_satisfiable(data) # Be careful with the context
            # change! this will have another object...
            )

    # Update the translation information on the GUI and show it to the
    # user.
    #
    # Depending on the format selected by the user show it as HTML or
    # inside a textarea tag.
    #
    # @param data {string} The HTML, OWLlink or the translation
    # string.
    # @see CreateClassView#get_translation_format
    update_translation: (data) ->
        console.log(data)
        format = @crearclase.get_translation_format()
        if format == "html"
            $("#html-output").html(data)
            $("#html-output").show()
            $("#owllink_source").hide()
        else
            $("#owllink_source").text(data)
            $("#owllink_source").show()
            $("#html-output").hide()
        $.mobile.loading("hide")
        gui.gui_instance.change_to_details_page()

    update_metamodel: (data) ->
    	console.log(data)
    	$("#owllink_source").text(data)
    	$("#owllink_source").show()
    	$("#html-output").hide()
    	$.mobile.loading("hide")
    	gui.gui_instance.change_to_details_page()

    # Translate the current model into a formalization.
    #
    # Show the user a "wait" message while the server process the model.
    #
    # @param strategy {String} The strategy name to use for formalize the model.
    # @param syntax {String} The output sintax format.
    translate_formal: (strategy, syntax) ->
        $.mobile.loading("show",
            text: "Consulting server...",
            textVisible: true,
            textonly: false
        )
        json = JSON.stringify(@diag.to_json())
        @serverconn.request_translation(json, syntax, strategy, (data) ->
            gui.gui_instance.update_translation(data)
        )

    # Event handler for translate diagram to OWLlink using Ajax
    # and the api/translate/berardi.php translator URL.
    #
    # @deprecated Use translate_formal() instead.
    translate_owllink: (gui_instance) ->
        format = @crearclase.get_translation_format()
        strat = @crearclase.get_translation_strategy()
        this.translate_formal(strat, format)

    hide_umldiagram_page: () -> $("#diagram-page").css("display","none")

    show_umldiagram_page: () -> $("#diagram-page").css("display","block")

    # Change the interface into a "new association" state.
    #
    # @param class_id {string} The id of the class that triggered it and thus,
    #   the starting class of the association.
    # @param mult {array} An array of two strings representing the cardinality from and to.
    set_association_state: (class_id, mult) ->
        @hide_options()
        @state = gui.state_inst.association_state()
        @state.set_cellStarter(class_id)
        @state.set_cardinality(mult)

    # Change to the IsA GUI State so the user can select the child for the parent.
    #
    # @param class_id {String} The JointJS.Cell id for the parent class.
    # @param disjoint {Boolean} optional. If the relation has the disjoint constraint.
    # @param covering {Boolean} optional. If the relation has the disjoint constraint.
    set_isa_state: (class_id, disjoint=false, covering=false) ->
        @hide_options()
        gui.gui_instance.show_donewidget(class_id, () =>
            @set_selection_state())
        @state = gui.state_inst.isa_state()
        @state.set_cellStarter(class_id)
        @state.set_constraint(disjoint, covering)

    # Change the interface into a "selection" state.
    set_selection_state: () ->
        @state = gui.state_inst.selection_state()

    # Generate a JSON string representation of the current diagram.
    #
    # @return {string} A JSON string.
    diag_to_json: () ->
        json = @diag.to_json()
        return JSON.stringify(json)

    # Import a JSON object.
    #
    # This will not reset the current diagram, just add more elements.
    #
    # Same as import_jsonstr, but it accept a JSON object as parameter.
    #
    # @param json_obj {JSON object} A JSON object.
    import_json: (json_obj) ->
        @diag.import_json(json_obj)

    # Reset all the diagram and the input forms.
    reset_all: () ->
        @diag.reset()
        gui.gui_instance.hide_toolbar()

    to_metamodel: () ->
        $.mobile.loading("show", text: "Metamodelling...", textVisible: true, textonly: false)
        json = JSON.stringify(@diag.to_json())
        @serverconn.request_metamodel_translation(json,this.update_metamodel)

    to_erd: (gui_instance) ->
        $.mobile.loading("show", text: "Generating ER Diagram...", textVisible: true, textonly: false)
        gui_instance.hide_toolbar()
        gui_instance.switch_to_erd()
        json = JSON.stringify(@diag.to_json())
        @serverconn.request_meta2erd_translation(json,(data)->
            gui_instance.import_jsonstr(data)
        )
        $.mobile.loading("hide")



exports.gui.GUIUML = GUIUML
