# class_options.coffee --
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


ClassOptionsView = Backbone.View.extend(
    initialize: () ->
        this.render()
        this.$el.hide()

    render: () ->
        template = _.template( $("#template_classoptions").html() )
        this.$el.html(template({classid: @classid}))

    events:
        "click a#deleteclass_button" : "delete_class",
        "click a#editclass_button" : "edit_class"

    ##
    # Set the classid of the Joint Model associated to this EditClass
    # instance, then set the position of the template to where is the
    # class Joint Model.
    set_classid: (@classid) ->
        viewpos = graph.getCell(@classid).findView(paper).getBBox()

        this.$el.css(
            top: viewpos.y,
            left: viewpos.x,
            position: 'absolute',
            'z-index': 1
            )
        this.$el.show()

    ##
    # Return the ClassID of the Joint.Model element associated to
    # this EditClass instance. 
    get_classid: () ->
        return @classid
        
    delete_class: (event) ->
        gui.gui_instance.hide_options()
        gui.gui_instance.delete_class(@classid)

    edit_class: (event) ->
        gui.gui_instance.hide_options()
        gui.gui_instance.set_editclass_classid(@classid)
        this.hide()

    hide: () ->
        this.$el.hide()
)

        
exports = exports ? this
exports.ClassOptionsView = ClassOptionsView
