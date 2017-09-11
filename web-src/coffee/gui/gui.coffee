# gui.coffee --
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
class GUI
    constructor: (@graph, @paper) ->
        # Current and active GUIIMP.
        @current_gui = null
        # When changing GUI, this will be the "return" GUI.
        @prev_gui = null
        # List of GUIIMP instance available.
        @lst_guis = {}
        @aux_gui = []

        # Widgets that are the same for all type of GUIImpl.
        # Login
        @loginwidget = new login.LoginWidgetView({el: $("#loginwidget_placer")})
        # Save-Load
        # Error reporting widget
        @errorwidget = new views.ErrorWidgetView({el: $("#errorwidget_placer")})

        # Details page elements
        @owllinkinsert = new views.OWLlinkInsertView({el: $("#owllink_placer")})
        @exportjsonwidget = new views.ExportJSONView({el: $("#exportjson_placer")})
        $("#details-page").enhanceWithin()

    # # GUIIMP management.
    # Messages for manage GUIIMP instances.
    # ---
    #
    # Add the GUIIMP instance as availables GUIs, also make it the current.
    #
    # @param name {string} The GUIIMP name.
    # @param guiimp {GUIIMP} An instance of a GUIIMP subclass.
    add_gui: (name, guiimp) ->
        @lst_guis[name] = guiimp
        guiimp.set_graph(@graph)
        guiimp.set_paper(@paper)
        this.switch_to_gui(name)

    to_erd: () ->
        @current_gui.to_erd(this)

    to_metamodel: () ->

    # Make the nth GUIIMP in the @lst_guis the current GUI.
    #
    # Change the current GUI the previous one.
    #
    # @param name {string} The GUI name.
    switch_to_gui: (name) ->
        if @lst_guis[name]?
            @prev_gui = @current_gui
            @current_gui = @lst_guis[name]

    # Make the GUIIMP instance that it is in the @lst_guis as the previous GUI.
    #
    # @param name {name} The name key of the @lst_guis.
    set_previous: (name) ->
        if @lst_guis[name]?
            @prev_gui = @lst_guis[name]

    # Set the previous GUIIMP instance that may not be added to my @lst_guis.
    #
    # @param guiimp {GUIIMP} A GUIIMP subclass instance.
    set_prev_gui: (guiimp) ->
        # @prev_gui = new gui.GUIEER(@graph,@paper)
        @prev_gui = guiimp
        guiimp.graph = @graph
        guiimp.paper = @paper

    # Switch to the previous GUIIMP.
    switch_to_prev: () ->
        @aux_gui = @current_gui
        @current_gui = @prev_gui
        @prev_gui = @aux_gui        

    # Simply change the current with the previous.
    #
    # @todo Support for more GUIs and @lst_guis.
    # @deprecated When there are more than two GUI, we don't know which one is the previous. Use switch_to_gui().
    switch_to_erd: () -> 
        # @current_gui.hide_umldiagram_page()
        @aux_gui = @current_gui
        @current_gui = @prev_gui
        @prev_gui = @aux_gui
        # @current_gui.show_eerdiagram_page()
    
    update_metamodel: (data) ->
        @current_gui.update_metamodel(data)

    # Translate the current model into a formalization.
    # 
    # Show the user a "wait" message while the server process the model.
    # 
    # @param strategy {String} The strategy name to use for formalize the model.
    # @param syntax {String} The output syntax format.
    translate_formal: (strategy, syntax) ->
        @current_gui.translate_formal(strategy, syntax)

    # @deprecated Use translate_formal() instead.
    translate_owllink: () ->
        @current_gui.translate_owllink(this)

    update_translation: (data) -> @current_gui.update_translation(data)

    add_object_type: (name) -> 
        @current_gui.add_object_type(name)

    add_attribute: (name) ->
        @current_gui.add_attribute(name)
        
    add_relationship: (class_a_id, class_b_id, name, mult) -> 
        @current_gui.add_relationship(class_a_id, class_b_id, name, mult)

    add_relationship_attr: (class_id, attribute_id, name) ->
        @current_gui.add_relationship_attr(class_id, attribute_id, name)

    add_relationship_isa: (class_id, isa_id, name)-> 
        @current_gui.add_relationship_isa(class_id, isa_id, name)

    add_relationship_isa_inverse: (class_id, isa_id, name)-> 
        @current_gui.add_relationship_isa_inverse(class_id, isa_id, name)
                
    add_subsumption: (class_parent_id, class_child_id, disjoint, covering) -> 
        @current_gui.add_subsumption(class_parent_id, class_child_id, disjoint, covering)
    
    edit_class_name: (class_id, name) -> @current_gui.edit_class_name(class_id, name)

    delete_class: (class_id) -> @current_gui.delete_class(class_id)

    set_isa_state: (class_id, disjoint, covering) -> 
        @current_gui.set_isa_state(class_id, disjoint, covering)        

    set_options_classid: (model_id) ->
        @current_gui.set_options_classid(model_id)

    set_association_state: (class_id, mult) -> @current_gui.set_association_state(class_id, mult)
                
    hide_options: () ->
        @current_gui.hide_options()

    hide_toolbar: () -> @current_gui.hide_toolbar()

    hide_umldiagram_page: () -> @current_gui.hide_umldiagram_page()
    
    show_umldiagram_page: () -> @current_gui.show_umldiagram_page()

    hide_eerdiagram_page: () -> @current_gui.eerdiagram_page()
    
    show_eerdiagram_page: () -> @current_gui.eerdiagram_page()
        
    set_editclass_classid: (model_id) ->
        @current_gui.set_editclass_classid(model_id)
        
    set_selection_state: () ->
        @current_gui.set_selection_state()
            
    # Update and show the "Export JSON String" section.
    show_export_json: () ->
        @exportjsonwidget.set_jsonstr(@current_gui.diag_to_json())
        $(".exportjson_details").collapsible("expand")
        this.change_to_details_page()

    # Refresh the content of the "Export JSON String" section.
    #
    # No need to show it.
    refresh_export_json: () ->
        @exportjsonwidget.set_jsonstr(@current_gui.diag_to_json())

    # Show the "Insert OWLlink" section.
    show_insert_owllink: () ->
        this.change_to_details_page()

    change_to_details_page: () ->
        $.mobile.changePage("#details-page", transition: "slide")

    change_to_diagram_page: () ->
        $.mobile.changePage("#diagram-page", transition: "slide", reverse: true)


    on_cell_clicked: (cellview, event, x, y) -> @current_gui.on_cell_clicked(cellview,event,x,y)

    # Import a JSON object.
    #
    # This will not reset the current diagram, just add more elements.
    #
    # Same as import_jsonstr, but it accept a JSON object as parameter.
    #
    # @param json_obj {JSON object} A JSON object.
    # @see import_jsonstr
    import_json: (json_obj) ->
        @current_gui.import_json(json_obj)
        # Importing owllink
        @owllinkinsert.append_owllink("\n" + json.owllink)

    # Import a JSON string.
    #
    # This will not reset the current diagram, just add more elements.
    #
    # # GUIIMPL Subclasses
    # This messages does not need to be reimplemented in GUIIMPL subclasses
    #
    # @param jsonstr {String} a JSON string, like the one returned by diag_to_json().
    # @see import_json
    import_jsonstr: (jsonstr) ->
        json = JSON.parse(jsonstr)
        # Importing the Diagram
        this.import_json(json)
    
    show_import_json: () -> @current_gui.show_import_json()

    # Reset all the diagram and the input forms.
    #
    # Reset the diagram and the "OWLlink Insert" input field.
    reset_all: () ->
        @owllinkinsert.set_owllink("")
        @current_gui.reset_all()

    # Check if the model is satisfiable sending a POST to the server.
    check_satisfiable: () ->
        @current_gui.check_satisfiable()

    # Update the diagram displaying unsatisfiable primitives in red.
    #
    # @param data [String] The JSON answer.
    update_satisfiable: (data) ->
        @current_gui.update_satisfiable(data)

    # Report an error to the user.
    #
    # @param status {String} the status text.
    # @param error {String} error message
    show_error: (status, error) ->
        $.mobile.loading("hide")
        @errorwidget.show(status, error)

    # Set the OWLlink dara at the "Insert OWLlink" section.
    #
    # @param str {string} The OWLlink data.
    set_insert_owllink: (str) ->
        @owllinkinsert.set_owllink(str)




# Current GUI instance.
# 
# An instance must be running!
# 
# Better use gui.set_current_instance()
#
# @see set_current_instance()
# @namespace gui
exports.gui.gui_instance = null

# Set the current instance of the GUI class.
#
# This has nothing to do with the current language interface (GUIUML, GUIEER,
# etc.).
#
# @param gui_instance {GUI} The running instance.
# @namespace gui
exports.gui.set_current_instance = (gui_instance) ->
    exports.gui.gui_instance = gui_instance


# @namespace gui
#
# Switch to the ERD interface and diagram.
# 
# This is sooo bad, but the context of a $.post callback function
# differs from the source caller class.
#
# We need to set a global gui instance variable with one GUI.gui instance.
exports.gui.switch_to_erd = () -> 
    gui_instance.aux_gui = gui_instance.current_gui
    gui_instance.current_gui = gui_instance.prev_gui
    gui_instance.prev_gui = gui_instance.aux_gui

# @namespace gui
#
# This is sooo bad, but the context of a $.post callback function
# differs from the source caller class.
#
# We need to set a global guiinst variable with one GUI.gui instance.
exports.gui.update_satisfiable = (data) ->
    exports.gui.gui_instance.update_satisfiable(data)

# @namespace gui
exports.gui.update_translation = (data) ->
    exports.gui.gui_instance.update_translation(data)

# @namespace gui
exports.gui.show_error = (jqXHR, status, text) ->
    exports.gui.gui_instance.show_error(status + ": " + text , jqXHR.responseText)

exports.gui.GUI = GUI
