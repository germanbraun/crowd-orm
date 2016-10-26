# export_json.coffee --
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




ExportJSONView = Backbone.View.extend(
    initialize: () ->
        @jsonstr = ""
        this.render()
    render: () ->
        template = _.template( $("#template_exportjson").html() )
        this.$el.html(template({jsonstr: @jsonstr}))
        this.$el.enhanceWithin() # Have pretty JQueryMobile buttons and textarea again.
    events:
        "click a#exportjson_copybtn" : "copy_jsonstr"
        "click a#exportjson_refreshbtn" : "refresh"
    copy_jsonstr: () ->
        console.log("Copying: " + @jsonstr)
        document.execCommand("copy", false, @jsonstr)
    refresh: () ->
        gui.gui_instance.refresh_export_json()
    set_jsonstr: (@jsonstr) ->
        this.render()
)

        

exports = exports ? this
exports.ExportJSONView = ExportJSONView

