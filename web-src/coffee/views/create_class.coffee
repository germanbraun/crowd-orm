# create_class.coffee --
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


# Provides elements and events needed for displaying the interface for
# creating a new class.
CreateClassView = Backbone.View.extend(    
        initialize: () ->
        	this.render()
    
        render: () ->
            template = _.template( $("#template_tools_navbar").html(), {} )
            this.$el.html(template)

        events: 
        	"click a#crearclase_button" :
                "create_class"
            "click a#translate_button" :
                "translate_owllink"
            "click a#insertowllink_button":
                "insert_owllink"
            "click a#resetall_button":
                "reset_all"
            "click a#importjson_open_dialog":
                "import_json"
            "click a#exportjson_open_dialog":
                "export_json"
            "click a#meta_erd_button" : "meta_to_erd"
            "click a#savejson":
                "save_json"
            "click a#loadjson":
                "load_json"

        
        meta_to_erd: (event) -> 
        	console.log(event) 
        	guiinst.to_erd()
        
        
        create_class: (event) ->
            guiinst.add_object_type(
                name: $("#crearclase_input").val()
            )

        # Event handler for translate diagram to OWLlink using Ajax
        # and the api/translate/berardi.php translator URL.
        translate_owllink: (event) ->
            syntax = this.get_translation_format()
            strategy = this.get_translation_strategy()
            gui.gui_instance.translate_formal(strategy, syntax)

        # Which is the current translation syntax format selected by the
        # user?
        #
        # @return [String] "html", "owllink", etc.
        get_translation_format: () ->
            $("#format_select")[0].value

        # Which is the current strategy the user selected?
        # 
        # @return {String} "berardi", "crowd", etc.
        get_translation_strategy: () ->
            $("#strategy_select")[0].value

        insert_owllink: () ->
            guiinst.show_insert_owllink()
        reset_all: () ->
            guiinst.reset_all()
        import_json: () ->
            guiinst.show_import_json()
        export_json: () ->
            guiinst.show_export_json()
        save_json: () ->
            gui.gui_instance.show_save_json()
        load_json: () ->
            gui.gui_instance.show_load_json()
                
);

        

exports = exports ? this
exports.CreateClassView = CreateClassView
