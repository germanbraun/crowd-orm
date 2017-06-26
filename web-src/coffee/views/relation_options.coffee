# relation_options.coffee --
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




RelationOptionsView = Backbone.View.extend(
    initialize: () ->
        this.render()
        this.$el.hide()

    render: () ->
        template = _.template( $("#template_relationoptions").html() )
        this.$el.html(template({classid: @classid}))

    events:
        "click a#association_button" : "new_relation",
        "click a#assoc_class_button" : "new_assoc_class"

    # Retrieve the source role and multiplicity information.
    cardfrom: () ->
        # from = "2..3"
        # console.log from
        from_1 = $('#cardfrom-1').val()
        console.log(from_1)
        from_aux = from_1.concat ".."
        from_2 = $('#cardfrom-2').val()
        console.log(from_2)
        @from = from_aux.concat from_2
        @from_role = $('#role-from').val()

    # Retrieve the destination role and multiplicity
    cardto: () ->
        # too = "4..8"
        # console.log too
        too_1 = $('#cardto-1').val()
        console.log(too_1)
        too_aux = too_1.concat ".."
        too_2 = $('#cardto-2').val()
        console.log(too_2)
        @too = too_aux.concat too_2
        # console.log too
        @to_role = $('#role-to').val()

    # Create a new relation with the information from the role, multiplicity and
    # association name input fields.
    #
    # Callback, used when the user clicks on the association button.
    new_relation: () ->
        this.cardfrom()
        this.cardto()

        mult = []
        mult[0] = @from
        mult[1] = @too
        roles = []
        roles[0] = @from_role
        roles[1] = @to_role
        name = $("#assoc_name").val()
        @hide()
        console.log("New association without class:")
        console.log(mult)
        gui.gui_instance.set_association_state(@classid, mult, roles, name, false)

    # Create a new relation with the information from the role, multiplicity and
    # association name input fields. *Use an association class in the middle.*
    #
    # Callback, used when the user clicks on the create association class button.
    new_assoc_class: (from, too) ->
        this.cardfrom()
        this.cardto()

        mult = []
        mult[0] = @from
        mult[1] = @too
        roles = []
        roles[0] = @from_role
        roles[1] = @to_role
        name = $("#assoc_name").val()
        @hide()
        console.log("New association with class: " + name)
        console.log(mult)
        gui.gui_instance.set_association_state(@classid, mult, roles, name, true)


    # Map the Option value to multiplicity string.
    #
    # @param str {string} The value string.
    # @return {String} A string that represent the multiplicity as in UML.
    map_to_mult : (str) ->
        switch str
            when "zeromany" then "0..*"
            when "onemany" then "1..*"
            when "zeroone" then "0..1"
            when "oneone" then "1..1"


    set_classid: (@classid) ->
        viewpos = graph.getCell(@classid).findView(paper).getBBox()

        this.$el.css(
            top: viewpos.y,
            left: viewpos.x + viewpos.width,
            position: 'absolute',
            'z-index': 1
            )
        this.$el.show()

    get_classid: () ->
        return @classid

    hide: () ->
        this.$el.hide()

)




exports = exports ? this
exports.RelationOptionsView = RelationOptionsView
