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

# @namespace gui
#
# Central GUI *do-it-all* class...
#
class GUI
    constructor: (@graph, @paper) ->
        @urlprefix = ""
        @diag = new UMLDiagram(@graph)
        @state = gui.state_inst.selection_state()
        @crearclase = new CreateClassView({el: $("#crearclase")});
        @editclass = new EditClassView({el: $("#editclass")})
        @classoptions = new ClassOptionsView({el: $("#classoptions")})
        @relationoptions = new RelationOptionsView({el: $("#relationoptions")})
        @isaoptions = new IsaOptionsView({el: $("#isaoptions")})
        @trafficlight = new TrafficLightsView({el: $("#trafficlight")})
        @owllinkinsert = new OWLlinkInsertView({el: $("#owllink_placer")})
        @errorwidget = new ErrorWidgetView({el: $("#errorwidget_placer")})
        @loginwidget = new LoginWidgetView({el: $("#loginwidget_placer")})
        @importjsonwidget = new ImportJSONView({el: $("#importjsonwidget_placer")})
        @exportjsonwidget = new ExportJSONView({el: $("#exportjson_placer")})
        @saveloadjsonwidget = new SaveLoadJson({el: $("#saveloadjson_placer")})

        @login = null
        
        @serverconn = new ServerConnection( (jqXHR, status, text) ->
            exports.gui.gui_instance.show_error(status + ": " + text , jqXHR.responseText)
        )
                
        $("#diagram-page").enhanceWithin()
        $("#details-page").enhanceWithin()
        gui.set_current_instance(this);

    set_urlprefix : (str) ->
        @urlprefix = str

    # What to do when the user clicked on a cellView.
    # 
    # @param cellview [joint.dia.CellView] The cell view that recieves the click event.
    # @param event [Event] The event object representation. {https://developer.mozilla.org/en-US/docs/Web/API/Event/Event}
    # @param x [int] Where's the X coordinate position where the mouse has clicked.
    # @param y [int] Where's the Y coordinate position where the mouse has clicked.
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
    add_class: (hash_data) ->
        @diag.add_class(hash_data)

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
    add_association: (class_a_id, class_b_id, name=null, mult=null, roles=null) ->
        @diag.add_association(class_a_id, class_b_id, name, mult, roles)
        this.set_selection_state()

    # Idem a {GUI#add_association} but includes an association class.
    #
    # Some parameters are not optional.
    #
    # @see #add_association.
    add_association_class: (class_a_id, class_b_id, name, mult=null, roles=null) ->
        @diag.add_association_class(class_a_id, class_b_id, name, mult, roles)
        this.set_selection_state()

    # Add a Generalization link and then set the selection state.
    #
    # @param class_parent_id {string} The parent class Id.
    # @param class_child_id {string} The child class Id.
    # 
    # @todo Support various children on parameter class_child_id.
    add_generalization: (class_parent_id, class_child_id, disjoint=false, covering=false) ->
        @diag.add_generalization(class_parent_id, class_child_id, disjoint, covering)
        this.set_selection_state()

    #
    # Report an error to the user.
    #
    # @param status {String} the status text.
    # @param error {String} error message
    show_error: (status, error) ->
        $.mobile.loading("hide")
        @errorwidget.show(status, error)

    #
    # Show the login popup.
    # 
    show_login: () ->
        @loginwidget.show()

    #
    # Hide the login popup.
    # 
    hide_login: () ->
        @loginwidget.hide()

    # Do the login steps connecting to the server and verifying the username
    # and password.
    #
    # @param username {String} The username.
    # @param pass {String} The password.
    do_login: (username, pass) ->
        @serverconn.request_login(
            username,
            pass,
            gui.update_login)

    # Callback for the ServerConnection
    # 
    # Update the interface according to a succesful login.
    #
    # @param data {String} The information about the login answer in JSON format.
    update_login: (data) ->
        console.log(data)
        @login = JSON.parse(data)
        if @login.logged
            this.set_logged_in()
        else
            @login = null
            # For some reason it won't show the error message if not wait for
            # one second.
            setTimeout(() ->
                gui.gui_instance.show_error("Problems When Logging In", data)
            ,1000)

    # According to the information about @login, update the interface.
    set_logged_in: () ->
        if @login?
            loginbutton = $("#loginButton")
            loginbutton.html(@login.username + "(Logged in)")
            loginbutton[0].classList.remove("ui-icon-user")
            loginbutton[0].classList.add("ui-icon-action")
            @loginwidget.set_doing_login(false)
        else
            loginbutton = $("#loginButton")
            loginbutton.html("Login")
            loginbutton[0].classList.remove("ui-icon-action")
            loginbutton[0].classList.add("ui-icon-user")
            @loginwidget.set_doing_login(true)

    # Clear the login and reset the interface. Send information to the server.
    do_logout: () ->
        @serverconn.request_logout(gui.update_logout)

    # Callback for the ServerConnection.
    # 
    # Update the interface and JS as if the user has recently logged out.
    #
    # @param data {String} The information returned from the server.
    update_logout: (data) ->
        console.log(data)
        @login = null
        this.set_logged_in()

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
        
    #
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
            gui.update_satisfiable # Be careful with the context
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
        format = @crearclase.get_translation_format()
        if format == "html" 
            $("#html-output").html(data)
            $("#html-output").show()
            $("#owllink_source").hide()
        else
            $("#owllink_source").text(data)
            $("#owllink_source").show()
            $("#html-output").hide()
        
        # Goto the Translation text
        $.mobile.loading("hide")
        this.change_to_details_page()
        
        console.log(data)

    ##
    # Event handler for translate diagram to OWLlink using Ajax
    # and the api/translate/berardi.php translator URL.
    translate_owllink: () ->
        format = @crearclase.get_translation_format()
        $.mobile.loading("show", 
            text: "Consulting server...",
            textVisible: true,
            textonly: false
        )
        json = this.diag_to_json()
        @serverconn.request_translation(json, format, gui.update_translation)


    change_to_details_page: () ->
        $.mobile.changePage("#details-page",
            transition: "slide")
    change_to_diagram_page: () ->
        $.mobile.changePage("#diagram-page",
            transition: "slide",
            reverse: true)
    change_to_user_page: () ->
        $.mobile.changePage("#user-page",
            transition: "slide")
    #
    # Hide the left side "Tools" toolbar
    # 
    hide_toolbar: () ->
        $("#tools-panel [data-rel=close]").click()

    # Change the interface into a "new association" state.
    #
    # @param class_id {string} The id of the class that triggered it and thus,
    #   the starting class of the association.
    # @param mult {array} An array of two strings representing the cardinality from and to.
    # @param name [String] A string describing the name of the relation.
    # @param with_class [boolean] If true, this is an association with class.
    set_association_state: (class_id, mult, roles,  name=null, with_class=false) ->
        @state = gui.state_inst.association_state()
        @state.set_cellStarter(class_id)
        @state.set_cardinality(mult)
        @state.set_roles(roles)
        @state.set_name(name)
        # set_with_class needs a name,
        # if name=null it will set it to false nevertheless
        @state.set_with_class(with_class)

    # Change to the IsA GUI State so the user can select the child for the parent.
    #
    # @param class_id {String} The JointJS::Cell id for the parent class.
    # @param disjoint {Boolean} optional. If the relation has the disjoint constraint.
    # @param covering {Boolean} optional. If the relation has the disjoint constraint.
    set_isa_state: (class_id, disjoint=false, covering=false) ->
        @state = gui.state_inst.isa_state()
        @state.set_cellStarter(class_id)
        @state.set_constraint(disjoint, covering) 

    # Change the interface into a "selection" state.
    set_selection_state: () ->
        @state = gui.state_inst.selection_state()

    # Update and show the "Export JSON String" section.
    show_export_json: () ->
        @exportjsonwidget.set_jsonstr(this.diag_to_json())
        $(".exportjson_details").collapsible("expand")
        this.change_to_details_page()

    # Refresh the content of the "Export JSON String" section.
    #
    # No need to show it.
    refresh_export_json: () ->
        @exportjsonwidget.set_jsonstr(this.diag_to_json())

    #
    # Show the "Import JSON" modal dialog.
    #
    show_import_json: () ->
        this.hide_toolbar()
        @importjsonwidget.show()

    ##
    # Show the "Insert OWLlink" section.
    show_insert_owllink: () ->
        this.change_to_details_page()

    ##
    # Set the OWLlink addon at the "Insert OWLlink" section.
    set_insert_owllink: (str) ->
        @owllinkinsert.set_owllink(str)

    diag_to_json: () ->
        json = @diag.to_json()
        json.owllink = @owllinkinsert.get_owllink()
        return JSON.stringify(json)

    # Import a JSON string.
    #
    # This will not reset the current diagram, just add more elements.
    #
    # @param jsonstr {String} a JSON string, like the one returned by diag_to_json().
    import_jsonstr: (jsonstr) ->
        json = JSON.parse(jsonstr)
        # Importing owllink
        @owllinkinsert.append_owllink("\n" + json.owllink)
        # Importing the Diagram
        this.import_json(json)

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
    #
    # Reset the diagram and the "OWLlink Insert" input field.
    reset_all: () ->
        @diag.reset()
        @owllinkinsert.set_owllink("")
        this.hide_toolbar()

    # Display the saveloadjson Popup in the save state.
    show_save_json: () ->
        @saveloadjsonwidget.is_loading = false
        @saveloadjsonwidget.show()

    # Display the saveloadjson Popup in the load state.
    #
    # But first, we must retrieve the model list.
    show_load_json: () ->
        $.mobile.loading("show",
            text: "Retrieving models list...",
            textVisible: true,
            textonly: false
        )
        @serverconn.request_model_list(gui.update_saveloadjsonwidget)

    # Display the loadjson but without retrieving the model list.
    #
    # @param list {Array} A list of Strings with the names of the models.
    show_load_json_with_list: (list) ->
        $.mobile.loading("hide")
        @saveloadjsonwidget.set_jsonlist(list)
        this.change_to_user_page()

    # Hide the saveloadjson Popup.
    #
    # Maybe the user canceled?
    hide_saveloadjson: () ->
        @saveloadjsonwidget.hide()

exports = exports ? this

if exports.gui == undefined
    exports.gui = {}

exports.gui.gui_instance = null
exports.gui.set_current_instance = (gui_instance) ->
    exports.gui.gui_instance = gui_instance

    

# @namespace gui
#
# This is sooo bad, but the context of a $.post callback function
# differs from the source caller class.
#
# We need to set a global guiinst variable with one GUI.gui instance.
exports.gui.update_satisfiable = (data) ->
    exports.gui.gui_instance.update_satisfiable(data)

exports.gui.update_translation = (data) ->
    exports.gui.gui_instance.update_translation(data)

exports.gui.show_error = (jqXHR, status, text) ->
    exports.gui.gui_instance.show_error(status + ": " + text , jqXHR.responseText)

exports.gui.update_login = (data) ->
    exports.gui.gui_instance.update_login(data)

exports.gui.update_logout = (data) ->
    exports.gui.gui_instance.update_logout(data)

exports.gui.update_saveloadjsonwidget = (data) ->
    try
        list = JSON.parse(data)
    catch error
        $.mobile.loading("hide")
        console.log(error)
        gui.gui_instance.show_error("Couldn't retrieve models list.", data)
    exports.gui.gui_instance.show_load_json_with_list(list)

exports.gui.GUI = GUI

