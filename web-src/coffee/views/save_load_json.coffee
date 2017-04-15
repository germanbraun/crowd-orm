# save_load_json.coffee --
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


# Provides elements and events needed for displaying the interface for
# loading or saving the model.
SaveLoadJson = Backbone.View.extend(    
        initialize: () ->
            @is_loading = true
            @jsonlist = []
            this.render()
            # $("a#saveloadjson_cancel_btn").on("click", this.hide)

        render: () ->
            template = _.template( $("#template_saveloadjsonwidget").html(), {} )
            this.$el.html(template)

        events: 
            "click a#savejson_save_btn" :
                "save"
            "click #modelList a":
                "load_model"

        set_jsonlist: (list) ->
            @jsonlist = list
            $("#modelList").html('')
            # As appears on http://api.jquerymobile.com/enhanceWithin/
            $(this.retrieve_html_list()).appendTo("#modelList").enhanceWithin()
            $("#modelList").listview()
            $("#modelList").listview("refresh")

        retrieve_html_list: () ->
            lst_str = @jsonlist.map( (value, index, arr) ->
                '<li><a href="#">' + value + '</a></li>'
            )
            lst_str.join(' ')

        save: () ->
            modelname = $("#savejson_name").val()
            gui.gui_instance.save_model(modelname)

        load_model: (event) ->
            modelname = event.target.text
            gui.gui_instance.load_model(modelname)
);

exports = exports ? this
exports.SaveLoadJson = SaveLoadJson

